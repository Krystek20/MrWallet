import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    func start()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
}

class BaseCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    private(set) var childCoordinators: [Coordinator] = []
    
    // MARK: - Coordinator
    
    func start() { }
    
    func start(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func finish(coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        childCoordinators.remove(at: index)
    }
}
