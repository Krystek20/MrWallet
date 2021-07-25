import Foundation
@testable import MrWallet

final class PriceFormatterMock: PriceFormatting {
    
    // MARK: - Properties
    
    private(set) var formatCounter: Int = .zero
    private(set) var priceSet: String?
    private(set) var configurationSet: PriceFormatter.Configuration?
    private let expectedValue: String
    
    // MARK: - Initialization
    
    init(expectedValue: String) {
        self.expectedValue = expectedValue
    }
    
    // MARK: - Public
    
    func format(for price: String, configuration: PriceFormatter.Configuration) -> String? {
        formatCounter += 1
        priceSet = price
        configurationSet = configuration
        return expectedValue
    }
}
