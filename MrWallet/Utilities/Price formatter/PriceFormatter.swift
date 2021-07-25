import Foundation

protocol PriceFormatting {
    func format(for price: String, configuration: PriceFormatter.Configuration) -> String?
}

extension PriceFormatting {
    func format(for price: String, precision: Int) -> String? {
        format(for: price, configuration: PriceFormatter.Configuration(precision: precision))
    }
}

struct PriceFormatter: PriceFormatting {
    
    // MARK: - Configuration
    
    struct Configuration: Equatable {
        let precision: Int
        let currencyCode: CurrencyCode
        let locale: Locale
        
        init(precision: Int, currencyCode: CurrencyCode = .euro, locale: Locale = .current) {
            self.precision = precision
            self.currencyCode = currencyCode
            self.locale = locale
        }
    }
    
    // MARK: - Properties
    
    private let formatter: NumberFormatter
    
    // MARK: - Initialization
    
    init(formatter: NumberFormatter = NumberFormatter()) {
        self.formatter = formatter
    }
    
    // MARK: - Public
    
    func format(for price: String, configuration: Configuration) -> String? {
        guard let doublePrice = Double(price) else { return nil }
        formatter.minimumFractionDigits = configuration.precision
        formatter.maximumFractionDigits = configuration.precision
        formatter.numberStyle = .currency
        formatter.currencyCode = configuration.currencyCode.rawValue
        formatter.locale = configuration.locale
        return formatter.string(from: NSNumber(value: doublePrice))
    }
}
