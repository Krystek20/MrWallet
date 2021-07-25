import Foundation

struct Attributes<T: Codable & Equatable>: Codable, Equatable {
    let type: AttributesType
    let attributes: T
    let id: String
}

enum AttributesType: String, Codable {
    case cryptocoin
    case commodity
    case fiat
    case wallet
    case fiatWallet = "fiat_wallet"
}

struct CryptocoinAttributes: Codable, Equatable {
    let symbol: String
    let name: String
    let logo: String
    let logoDark: String
    let avgPrice: String
    let precisionForFiatPrice: Int
}

struct CommodityAttributes: Codable, Equatable {
    let symbol: String
    let name: String
    let logo: String
    let logoDark: String
    let avgPrice: String
    let precisionForFiatPrice: Int
}

struct FiatAttributes: Codable, Equatable {
    let symbol: String
    let name: String
    let logo: String
    let logoDark: String
    let hasWallets: Bool
}

struct WalletAttributes: Codable, Equatable {
    let cryptocoinSymbol: String
    let balance: String
    let isDefault: Bool
    let name: String
    let deleted: Bool
}

struct CommodityWalletAttributes: Codable, Equatable {
    let cryptocoinSymbol: String
    let balance: String
    let isDefault: Bool
    let name: String
    let deleted: Bool
}

struct FiatWalletAttributes: Codable, Equatable {
    let fiatSymbol: String
    let balance: String
    let name: String
}
