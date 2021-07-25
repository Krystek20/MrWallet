import XCTest
import Combine
@testable import MrWallet

final class WalletViewModelTests: XCTestCase {

    private var sut: WalletsViewModel!
    private var masterdataInteractor: MasterdataInteractorMock!
    private var bindings = Set<AnyCancellable>()
    private let factory = WalletGroupFactory()
    
    override func setUp() {
        masterdataInteractor = MasterdataInteractorMock()
        sut = WalletsViewModel(
            interactor: masterdataInteractor
        )
    }
    
    override func tearDown() {
        masterdataInteractor = nil
        sut = nil
        bindings.removeAll()
    }
    
    func testViewDidLoadCallsWalletGroupsWithThreeGroups() {
        // given
        let expectation = XCTestExpectation()
        let expected = [
            factory.createWalletGroup(
                from: [.fixtureWallet()],
                cryptocoinAttributes: [.fixtureCryptocoin]
            ),
            factory.createWalletGroup(
                from: [.fixtureCommodityWallet()],
                commodityAttributes: [.fixtureCommodity]
            ),
            factory.createWalletGroup(
                from: [.fixtureFiatWallet()],
                fiatAttributes: [.fixtureFiat()]
            )
        ]
        sut.viewDidLoad.send()
        
        sut.walletGroups
            .dropFirst()
            .sink(receiveValue: { viewModels in
                // then
                XCTAssertEqual(viewModels, expected)
                expectation.fulfill()
            })
            .store(in: &bindings)
        
        // when
        masterdataInteractor.loadableSubjectSet?.value = .loaded(.fixture)
        wait(for: [expectation], timeout: 1.0)
    }
}
