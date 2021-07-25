import XCTest
@testable import MrWallet

final class TabBarCoordinatorTests: XCTestCase {
    
    private var sut: TabBarCoordinator!
    private var navigationControler: UINavigationController!
    
    override func setUp() {
        navigationControler = UINavigationController()
        sut = TabBarCoordinator(navigationController: navigationControler)
    }
    
    override func tearDown() {
        navigationControler = nil
        sut = nil
    }
    
    func testStartSetTabBarControllerToNavigation() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(navigationControler.viewControllers.first is TabBarController)
    }
}
