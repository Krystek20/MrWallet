import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Coordinator
    
    override func start() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        start(coordinator: coordinator)
    }
}
