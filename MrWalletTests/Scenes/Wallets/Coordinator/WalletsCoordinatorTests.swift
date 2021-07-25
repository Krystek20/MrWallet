import XCTest
@testable import MrWallet

final class WalletsCoordinatorTests: XCTestCase {
    
    private var sut: WalletsCoordinator!
    private var navigationControler: UINavigationController!
    private var tabBarController: TabBarController!
    
    override func setUp() {
        navigationControler = UINavigationController()
        tabBarController = TabBarController()
        sut = WalletsCoordinator(tabBarController: tabBarController, navigationController: navigationControler)
    }
    
    override func tearDown() {
        navigationControler = nil
        tabBarController = nil
        sut = nil
    }
    
    func testStartSetWalletsViewControllerToNavigation() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(navigationControler.viewControllers.first is WalletsViewController)
    }
    
    func testStartSetNavigationControllerToTabBarController() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(tabBarController.viewControllers?.first === navigationControler)
    }
}
