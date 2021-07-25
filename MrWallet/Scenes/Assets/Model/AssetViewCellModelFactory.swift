import Foundation

protocol AssetViewCellModelFactoring {
    func createViewModel(from attributes: Attributes<CryptocoinAttributes>) -> AssetViewCellModel?
    func createViewModel(from attributes: Attributes<CommodityAttributes>) -> AssetViewCellModel?
    func createViewModel(from attributes: Attributes<FiatAttributes>) -> AssetViewCellModel?
}

struct AssetViewCellModelFactory: AssetViewCellModelFactoring {
    
    // MARK: - Properties
    
    private let priceFormatter: PriceFormatting
    
    // MARK: - Initialization
    
    init(priceFormatter: PriceFormatting = PriceFormatter()) {
        self.priceFormatter = priceFormatter
    }
    
    // MARK: - Public
    
    func createViewModel(from attributes: Attributes<CryptocoinAttributes>) -> AssetViewCellModel? {
        AssetViewCellModel(
            name: attributes.attributes.name,
            symbol: attributes.attributes.symbol,
            iconPath: attributes.attributes.logo,
            price: priceFormatter.format(for: attributes.attributes.avgPrice, precision: attributes.attributes.precisionForFiatPrice)
        )
    }
    
    func createViewModel(from attributes: Attributes<CommodityAttributes>) -> AssetViewCellModel? {
        AssetViewCellModel(
            name: attributes.attributes.name,
            symbol: attributes.attributes.symbol,
            iconPath: attributes.attributes.logo,
            price: priceFormatter.format(for: attributes.attributes.avgPrice, precision: attributes.attributes.precisionForFiatPrice)
        )
    }
    
    func createViewModel(from attributes: Attributes<FiatAttributes>) -> AssetViewCellModel? {
        guard attributes.attributes.hasWallets else { return nil }
        return AssetViewCellModel(
            name: attributes.attributes.name,
            symbol: attributes.attributes.symbol,
            iconPath: attributes.attributes.logo,
            price: nil
        )
    }
}
