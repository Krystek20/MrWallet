import UIKit.UIScene

protocol ApplicationManaging {
    var canLoadInterface: Bool { get }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
}

struct ApplicationManager: ApplicationManaging {
    
    // MARK: - Properties
    
    var canLoadInterface: Bool {
        !ProcessInfo.isRunningTests
    }
    private let imageConfigurator: SVGImageConfiguring
    
    // MARK: - Initialization
    
    init(imageConfigurator: SVGImageConfiguring = SVGImageConfigurator()) {
        self.imageConfigurator = imageConfigurator
    }
    
    // MARK: - Public
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        imageConfigurator.configure()
    }
}
