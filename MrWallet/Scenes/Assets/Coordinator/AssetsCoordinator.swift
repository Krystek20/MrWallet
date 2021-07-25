import UIKit

final class AssetsCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private weak var tabBarController: TabBarController?
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(tabBarController: TabBarController, navigationController: UINavigationController = UINavigationController()) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    override func start() {
        let viewModel = AssetsViewModel()
        let controller = AssetsViewController(viewModel: viewModel)
        controller.tabBarItem = UITabBarItem.assetTabBarItem
        navigationController.viewControllers = [controller]
        tabBarController?.append(navigationController)
    }
}
