import Foundation
import Combine

protocol AssetsViewModelType {
    
    // MARK: - Inputs
    
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
    var segmentChanged: CurrentValueSubject<String, Never> { get }
    
    // MARK: - Outputs
    
    var isLoadingAssets: AnyPublisher<Bool, Never> { get }
    var assetViewModels: AnyPublisher<[AssetViewCellModel], Never> { get }
}

final class AssetsViewModel: AssetsViewModelType {
    
    // MARK: - Inputs
    
    let viewDidLoad = PassthroughSubject<Void, Never>()
    let segmentChanged = CurrentValueSubject<String, Never>(AssetFilters.all.rawValue)
    
    // MARK: - Outputs
    
    var isLoadingAssets: AnyPublisher<Bool, Never> {
        loadingSubject
            .map(\.isLoading)
            .eraseToAnyPublisher()
    }
    
    var assetViewModels: AnyPublisher<[AssetViewCellModel], Never> {
        loadingSubject
            .combineLatest(segmentChanged)
            .map(prepareViewModels)
            .eraseToAnyPublisher()
    }

    // MARK: - Properties
    
    private let interactor: MasterdataInteractorType
    private var bindings = Set<AnyCancellable>()
    private let loadingSubject = LoadableSubject<MasterdataAttributes>(.notRequested)
    private let assetViewCellModelFactory: AssetViewCellModelFactoring
    
    // MARK: - Initialization
    
    init(interactor: MasterdataInteractorType = MasterdataInteractor(),
         assetViewCellModelFactory: AssetViewCellModelFactoring = AssetViewCellModelFactory()) {
        self.interactor = interactor
        self.assetViewCellModelFactory = assetViewCellModelFactory
        setupBindings()
    }
    
    // MARK: - Setup
    
    private func setupBindings() {
        viewDidLoad.sink { [weak self] in
            self?.loadAssets()
        }
        .store(in: &bindings)
    }
    
    // MARK: - Private
    
    private func loadAssets() {
        interactor.loadMasterdata(loadableSubject: loadingSubject)
    }
    
    private func prepareViewModels(loading: LoadingState<MasterdataAttributes>, filterName: String) -> [AssetViewCellModel] {
        guard let masterdataAttributes = loading.result,
              let filter = AssetFilters(rawValue: filterName) else { return [] }
        let cryptocoins = masterdataAttributes.cryptocoins.compactMap(assetViewCellModelFactory.createViewModel)
        let commodities = masterdataAttributes.commodities.compactMap(assetViewCellModelFactory.createViewModel)
        let fiats = masterdataAttributes.fiats.compactMap(assetViewCellModelFactory.createViewModel)
        
        switch filter {
        case .all: return cryptocoins + commodities + fiats
        case .cryptocoins: return cryptocoins
        case .commodities: return commodities
        case .fiats: return fiats
        }
    }
}
