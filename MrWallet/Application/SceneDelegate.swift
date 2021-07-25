import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var applicationCoordinator: Coordinator?
    private let applicationManager: ApplicationManaging = ApplicationManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard applicationManager.canLoadInterface,
              let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        let navigationController = UINavigationController()
        applicationCoordinator = ApplicationCoordinator(navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    
        applicationManager.scene(scene, willConnectTo: session, options: connectionOptions)
        applicationCoordinator?.start()
        
        self.window = window
    }
}
