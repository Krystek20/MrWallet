import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    private var tabCoordinators: [Coordinator] = []
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    override func start() {
        let controller = TabBarController()
        navigationController.viewControllers = [controller]

        tabCoordinators = [
            AssetsCoordinator(tabBarController: controller),
            WalletsCoordinator(tabBarController: controller)
        ]

        tabCoordinators.forEach { $0.start() }
    }
}
