import Foundation

protocol WalletViewCellModelType {
    var name: String { get }
    var symbol: String { get }
    var iconPath: String? { get }
    var balance: String { get }
    var isMarked: Bool { get }
}

struct WalletViewCellModel: WalletViewCellModelType, Equatable {
    let name: String
    let symbol: String
    let iconPath: String?
    let balance: String
    let isMarked: Bool

    init(name: String, symbol: String, iconPath: String?, balance: String, isMarked: Bool) {
        self.name = name
        self.symbol = symbol
        self.iconPath = iconPath
        self.balance = balance
        self.isMarked = isMarked
    }
    
    init(walletAttribute: WalletAttributes, cryptocoinAttributes: CryptocoinAttributes?) {
        self.init(
            name: walletAttribute.name,
            symbol: walletAttribute.cryptocoinSymbol,
            iconPath: cryptocoinAttributes?.logo,
            balance: walletAttribute.balance,
            isMarked: walletAttribute.isDefault
        )
    }
    
    init(commodityWalletAttributes: CommodityWalletAttributes, commodityAttributes: CommodityAttributes?) {
        self.init(
            name: commodityWalletAttributes.name,
            symbol: commodityWalletAttributes.cryptocoinSymbol,
            iconPath: commodityAttributes?.logo,
            balance: commodityWalletAttributes.balance,
            isMarked: commodityWalletAttributes.isDefault
        )
    }
    
    init(fiatWalletAttributes: FiatWalletAttributes, fiatAttributes: FiatAttributes?) {
        self.init(
            name: fiatWalletAttributes.name,
            symbol: fiatWalletAttributes.fiatSymbol,
            iconPath: fiatAttributes?.logo,
            balance: fiatWalletAttributes.balance,
            isMarked: false
        )
    }
}
