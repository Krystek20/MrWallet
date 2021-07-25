import UIKit
import Combine

final class WalletsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: WalletsViewModelType
    private let mainView: WalletsView
    private var bindings = Set<AnyCancellable>()
    private var dataSource = WalletsDataSource()
    
    // MARK: - Initialization
    
    init(viewModel: WalletsViewModelType) {
        self.viewModel = viewModel
        self.mainView = WalletsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupBindings()
        viewModel.viewDidLoad.send()
    }
    
    // MARK: - Setup
    
    private func setupSelf() {
        title = "Wallets Screen"
        mainView.tableView.dataSource = dataSource
    }
    
    private func setupBindings() {
        viewModel.walletGroups
            .sink(receiveValue: { [weak self] walletGroups in
                self?.dataSource.walletGroups = walletGroups
                self?.mainView.tableView.reloadData()
            })
            .store(in: &bindings)
    }
}
