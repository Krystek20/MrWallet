import XCTest
@testable import MrWallet

final class WalletGroupFactoryTests: XCTestCase {

    private var sut: WalletGroupFactory!
    private let lowerBallance = "12.12"
    private let greaterBallance = "222.12"
    
    override func setUp() {
        sut = WalletGroupFactory()
    }
    
    private var expectedCryptocoinsViewModels: [WalletViewCellModel] {
        [
            WalletViewCellModel(
                walletAttribute: .fixture(ballance: greaterBallance),
                cryptocoinAttributes: .fixture
            ),
            WalletViewCellModel(
                walletAttribute: .fixture(ballance: lowerBallance),
                cryptocoinAttributes: .fixture
            )
        ]
    }
    
    private var expectedCommoditiesViewModels: [WalletViewCellModel] {
        [
            WalletViewCellModel(
                commodityWalletAttributes: .fixture(ballance: greaterBallance),
                commodityAttributes: .fixture
            ),
            WalletViewCellModel(
                commodityWalletAttributes: .fixture(ballance: lowerBallance),
                commodityAttributes: .fixture
            )
        ]
    }
    
    private var expectedFiatsViewModels: [WalletViewCellModel] {
        [
            WalletViewCellModel(
                fiatWalletAttributes: .fixture(ballance: greaterBallance),
                fiatAttributes: .fixture()
            ),
            WalletViewCellModel(
                fiatWalletAttributes: .fixture(ballance: lowerBallance),
                fiatAttributes: .fixture()
            )
        ]
    }
    
    func testCreateWalletGroupForWalletsReturnsSortedDescWalletGroup() {
        // given
        let expected = WalletGroup(
            name: "Wallets",
            cellType: .standard,
            walletViewModels: expectedCryptocoinsViewModels
        )
        
        // when
        let walletGroup = sut.createWalletGroup(
            from: [.fixtureWallet(ballance: lowerBallance),
                   .fixtureWallet(ballance: greaterBallance)],
            cryptocoinAttributes: [.fixtureCryptocoin]
        )
        
        // then
        XCTAssertEqual(walletGroup, expected)
    }
    
    func testCreateWalletGroupForCommodityWalletsReturnsSortedDescWalletGroup() {
        // given
        let expected = WalletGroup(
            name: "Commodity Wallets",
            cellType: .standard,
            walletViewModels: expectedCommoditiesViewModels
        )
        
        // when
        let walletGroup = sut.createWalletGroup(
            from: [.fixtureCommodityWallet(ballance: lowerBallance),
                   .fixtureCommodityWallet(ballance: greaterBallance)],
            commodityAttributes: [.fixtureCommodity]
        )
        
        // then
        XCTAssertEqual(walletGroup, expected)
    }
    
    func testCreateWalletGroupForFiatWalletsReturnsSortedDescWalletGroup() {
        // given
        let lowerBallance = "12.12"
        let greaterBallance = "222.12"
        let expected = WalletGroup(
            name: "Fiat Wallets",
            cellType: .decorated,
            walletViewModels: expectedFiatsViewModels
        )
        
        // when
        let walletGroup = sut.createWalletGroup(
            from: [.fixtureFiatWallet(ballance: lowerBallance),
                   .fixtureFiatWallet(ballance: greaterBallance)],
            fiatAttributes: [.fixtureFiat()]
        )
        
        // then
        XCTAssertEqual(walletGroup, expected)
    }
}
