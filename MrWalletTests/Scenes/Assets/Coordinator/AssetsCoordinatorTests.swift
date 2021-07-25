import XCTest
@testable import MrWallet

final class AssetsCoordinatorTests: XCTestCase {
    
    private var sut: AssetsCoordinator!
    private var navigationControler: UINavigationController!
    private var tabBarController: TabBarController!
    
    override func setUp() {
        navigationControler = UINavigationController()
        tabBarController = TabBarController()
        sut = AssetsCoordinator(tabBarController: tabBarController, navigationController: navigationControler)
    }
    
    override func tearDown() {
        navigationControler = nil
        tabBarController = nil
        sut = nil
    }
    
    func testStartSetAssetsViewControllerToNavigation() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(navigationControler.viewControllers.first is AssetsViewController)
    }
    
    func testStartSetNavigationControllerToTabBarController() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(tabBarController.viewControllers?.first === navigationControler)
    }
}
