import XCTest
@testable import MrWallet

final class PriceFormatterTests: XCTestCase {
    
    private var sut: PriceFormatter!
    
    override func setUp() {
        sut = PriceFormatter()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testFormatingPriceWithTwoFractionDigitsForUSLocale() {
        // given
        let locale = Locale(identifier: "en-US")
        
        // when
        let output = sut.format(for: "198.580", configuration: .init(precision: 2, currencyCode: .euro, locale: locale))
        
        // then
        XCTAssertEqual(output, "€198.58")
    }
    
    func testFormatingPriceWithThreeFractionDigitsForPLLocale() {
        // given
        let locale = Locale(identifier: "pl_PL")
        
        // when
        let output = sut.format(for: "198.5800", configuration: .init(precision: 3, currencyCode: .euro, locale: locale))
        
        // then
        XCTAssertEqual(output, "198,580 €")
    }
}
