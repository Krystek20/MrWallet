import XCTest
import Combine
@testable import MrWallet

final class AssetViewCellModelFactoryTests: XCTestCase {

    private let expectedPriceValue = "$123,21"
    private var sut: AssetViewCellModelFactory!
    private var priceFormatterMock: PriceFormatterMock!

    override func setUp() {
        priceFormatterMock = PriceFormatterMock(expectedValue: expectedPriceValue)
        sut = AssetViewCellModelFactory(priceFormatter: priceFormatterMock)
    }
    
    override func tearDown() {
        priceFormatterMock = nil
        sut = nil
    }
    
    func testCreateViewModelCallsOneTimePriceFormattterForCryptocoins() {
        // given
        let attributes = Attributes<CryptocoinAttributes>.fixtureCryptocoin.attributes
        let expectedConfiguration = PriceFormatter.Configuration(
            precision: attributes.precisionForFiatPrice,
            currencyCode: .euro,
            locale: .current
        )
        
        // when
        _ = sut.createViewModel(from: .fixtureCryptocoin)
        
        // then
        XCTAssertEqual(priceFormatterMock.priceSet, attributes.avgPrice)
        XCTAssertEqual(priceFormatterMock.configurationSet, expectedConfiguration)
        XCTAssertEqual(priceFormatterMock.formatCounter, 1)
    }
    
    func testCreateViewModelForCryptocoinsReturnsViewModel() {
        // given
        let attributes = Attributes<CryptocoinAttributes>.fixtureCryptocoin.attributes
        let expected = AssetViewCellModel(
            name: attributes.name,
            symbol: attributes.symbol,
            iconPath: attributes.logo,
            price: expectedPriceValue
        )
        
        // when
        let viewModel = sut.createViewModel(from: .fixtureCryptocoin)
        
        // then
        XCTAssertEqual(viewModel, expected)
    }
    
    func testCreateViewModelCallsOneTimePriceFormattterForCommodity() {
        // given
        let attributes = Attributes<CommodityAttributes>.fixtureCommodity.attributes
        let expectedConfiguration = PriceFormatter.Configuration(
            precision: attributes.precisionForFiatPrice,
            currencyCode: .euro,
            locale: .current
        )
        
        // when
        _ = sut.createViewModel(from: .fixtureCommodity)
        
        // then
        XCTAssertEqual(priceFormatterMock.priceSet, attributes.avgPrice)
        XCTAssertEqual(priceFormatterMock.configurationSet, expectedConfiguration)
        XCTAssertEqual(priceFormatterMock.formatCounter, 1)
    }
    
    func testCreateViewModelForCommodityReturnsViewModel() {
        // given
        let attributes = Attributes<CryptocoinAttributes>.fixtureCommodity.attributes
        let expected = AssetViewCellModel(
            name: attributes.name,
            symbol: attributes.symbol,
            iconPath: attributes.logo,
            price: expectedPriceValue
        )
        
        // when
        let viewModel = sut.createViewModel(from: .fixtureCommodity)
        
        // then
        XCTAssertEqual(viewModel, expected)
    }
    
    func testCreateViewModelNotCallsPriceFormattterForFiat() {
        // when
        _ = sut.createViewModel(from: .fixtureFiat())
        
        // then
        XCTAssertNil(priceFormatterMock.priceSet)
        XCTAssertNil(priceFormatterMock.configurationSet)
        XCTAssertEqual(priceFormatterMock.formatCounter, .zero)
    }
    
    func testCreateViewModelForFiatReturnsViewModel() {
        // given
        let attributes = Attributes<CryptocoinAttributes>.fixtureFiat().attributes
        let expected = AssetViewCellModel(
            name: attributes.name,
            symbol: attributes.symbol,
            iconPath: attributes.logo,
            price: nil
        )
        
        // when
        let viewModel = sut.createViewModel(from: .fixtureFiat())
        
        // then
        XCTAssertEqual(viewModel, expected)
    }
    
    func testCreateViewModelForFiatReturnsNilIfNotWallet() {
        // when
        let viewModel = sut.createViewModel(from: .fixtureFiat(hasWallet: false))
        
        // then
        XCTAssertNil(viewModel)
    }
}
