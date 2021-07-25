import UIKit

final class WalletsCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private weak var tabBarController: TabBarController?
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(tabBarController: TabBarController, navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    // MARK: - Coordinator
    
    override func start() {
        let viewModel = WalletsViewModel()
        let controller = WalletsViewController(viewModel: viewModel)
        controller.tabBarItem = UITabBarItem.walletTabBarItem
        navigationController.viewControllers = [controller]
        tabBarController?.append(navigationController)
    }
}
