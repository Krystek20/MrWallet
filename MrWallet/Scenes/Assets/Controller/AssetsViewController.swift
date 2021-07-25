import UIKit
import Combine

final class AssetsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: AssetsViewModelType
    private let mainView: AssetsView
    private var bindings = Set<AnyCancellable>()
    private let dataSource = AssetsDataSource()
    
    // MARK: - Initialization
    
    init(viewModel: AssetsViewModelType) {
        self.viewModel = viewModel
        self.mainView = AssetsView()
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
        title = "Assets Screen"
        mainView.tableView.dataSource = dataSource
        mainView.segmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    private func setupBindings() {
        viewModel.isLoadingAssets
            .assignNoRetain(to: \.isLoading, on: mainView)
            .store(in: &bindings)
        
        viewModel.assetViewModels
            .sink(receiveValue: { [weak self] viewModels in
                self?.dataSource.viewModels = viewModels
                self?.mainView.tableView.reloadData()
            })
            .store(in: &bindings)
    }

    // MARK: - Private
    
    @objc private func segmentChanged(_ segmentControl: UISegmentedControl) {
        guard let title = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) else { return }
        viewModel.segmentChanged.send(title)
    }
}
