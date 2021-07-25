import Foundation
import Combine

protocol WalletsViewModelType {
    
    // MARK: - Inputs
    
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
    
    // MARK: - Outputs

    var walletGroups: AnyPublisher<[WalletGroup], Never> { get }
}

final class WalletsViewModel: WalletsViewModelType {
    
    // MARK: - Inputs
    
    let viewDidLoad = PassthroughSubject<Void, Never>()
    
    // MARK: - Outputs
    
    var walletGroups: AnyPublisher<[WalletGroup], Never> {
        loadingSubject
            .map(prepareWalletGroups)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Properties
    
    private let interactor: MasterdataInteractorType
    private var bindings = Set<AnyCancellable>()
    private let loadingSubject = LoadableSubject<MasterdataAttributes>(.notRequested)
    private let walletGroupFactory: WalletGroupFactoring
    
    // MARK: - Initialization
    
    init(interactor: MasterdataInteractorType = MasterdataInteractor(),
         walletGroupFactory: WalletGroupFactoring = WalletGroupFactory()) {
        self.interactor = interactor
        self.walletGroupFactory = walletGroupFactory
        setupBindings()
    }
    
    // MARK: - Setup
    
    private func setupBindings() {
        viewDidLoad.sink { [weak self] in
            self?.loadWallets()
        }
        .store(in: &bindings)
    }
    
    // MARK: - Private
    
    private func loadWallets() {
        interactor.loadMasterdata(loadableSubject: loadingSubject)
    }
    
    private func prepareWalletGroups(loading: LoadingState<MasterdataAttributes>) -> [WalletGroup] {
        guard let masterdataAttributes = loading.result else { return [] }
        return [
            walletGroupFactory.createWalletGroup(
                from: masterdataAttributes.wallets,
                cryptocoinAttributes: masterdataAttributes.cryptocoins
            ),
            walletGroupFactory.createWalletGroup(
                from: masterdataAttributes.commodityWallets,
                commodityAttributes: masterdataAttributes.commodities
            ),
            walletGroupFactory.createWalletGroup(
                from: masterdataAttributes.fiatwallets,
                fiatAttributes: masterdataAttributes.fiats
            )
        ]
    }
}
