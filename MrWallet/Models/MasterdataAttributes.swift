import Foundation

struct MasterdataAttributes: Codable, Equatable {
    let cryptocoins: [Attributes<CryptocoinAttributes>]
    let commodities: [Attributes<CommodityAttributes>]
    let fiats: [Attributes<FiatAttributes>]
    let wallets: [Attributes<WalletAttributes>]
    let commodityWallets: [Attributes<CommodityWalletAttributes>]
    let fiatwallets: [Attributes<FiatWalletAttributes>]
}
