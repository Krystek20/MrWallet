import XCTest
@testable import MrWallet

final class BaseCoordinatorTests: XCTestCase {
    
    private var sut: BaseCoordinator!
    
    override func setUp() {
        sut = BaseCoordinator()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testStartWithCoordinatorSetParent() {
        // given
        let coordinator = AssetsCoordinator(tabBarController: TabBarController())
        
        // when
        sut.start(coordinator: coordinator)
        
        // then
        XCTAssertTrue(coordinator.parentCoordinator === sut)
    }
    
    func testStartWithCoordinatorStoreInArray() {
        // given
        let coordinator = AssetsCoordinator(tabBarController: TabBarController())
        
        // when
        sut.start(coordinator: coordinator)
        
        // then
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
    
    func testFinishWithCoordinatorRemoveCoordinatorFromArray() {
        // given
        let coordinator = AssetsCoordinator(tabBarController: TabBarController())
        sut.start(coordinator: coordinator)
        
        // when
        sut.finish(coordinator: coordinator)
        
        // then
        XCTAssertEqual(sut.childCoordinators.count, .zero)
    }
}
