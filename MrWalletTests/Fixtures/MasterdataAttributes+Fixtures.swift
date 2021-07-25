import Foundation
@testable import MrWallet

extension MasterdataAttributes {
    static var fixture: MasterdataAttributes {
        MasterdataAttributes(
            cryptocoins: [.fixtureCryptocoin],
            commodities: [.fixtureCommodity],
            fiats: [.fixtureFiat()],
            wallets: [.fixtureWallet()],
            commodityWallets: [.fixtureCommodityWallet()],
            fiatwallets: [.fixtureFiatWallet()]
        )
    }
}

extension Attributes {
    static var fixtureCryptocoin: Attributes<CryptocoinAttributes> {
        Attributes<CryptocoinAttributes>(
            type: .cryptocoin,
            attributes: .fixture,
            id: "1"
        )
    }
    
    static var fixtureCommodity: Attributes<CommodityAttributes> {
        Attributes<CommodityAttributes>(
            type: .commodity,
            attributes: .fixture,
            id: "1"
        )
    }
    
    static func fixtureFiat(hasWallet: Bool = true) -> Attributes<FiatAttributes> {
        Attributes<FiatAttributes>(
            type: .fiat,
            attributes: .fixture(hasWallet: hasWallet),
            id: "1"
        )
    }
    
    static func fixtureWallet(ballance: String = "2.26908585") -> Attributes<WalletAttributes> {
        Attributes<WalletAttributes>(
            type: .wallet,
            attributes: .fixture(ballance: ballance),
            id: "1"
        )
    }
    
    static func fixtureCommodityWallet(ballance: String = "0.3333") -> Attributes<CommodityWalletAttributes> {
        Attributes<CommodityWalletAttributes>(
            type: .wallet,
            attributes: .fixture(ballance: ballance),
            id: "1"
        )
    }
    
    static func fixtureFiatWallet(ballance: String = "107.82000000") -> Attributes<FiatWalletAttributes> {
        Attributes<FiatWalletAttributes>(
            type: .fiatWallet,
            attributes: .fixture(ballance: ballance),
            id: "1"
        )
    }
}

extension CryptocoinAttributes {
    static var fixture: CryptocoinAttributes {
        CryptocoinAttributes(
            symbol: "AAA",
            name: "ACoin",
            logo: "https://www.somelogo.com/logo.svg",
            logoDark: "https://www.somelogo.com/dartKogo.svg",
            avgPrice: "66.32",
            precisionForFiatPrice: 2
        )
    }
}

extension CommodityAttributes {
    static var fixture: CommodityAttributes {
        CommodityAttributes(
            symbol: "BBB",
            name: "Bold",
            logo: "https://www.somelogo.com/logo.svg",
            logoDark: "https://www.somelogo.com/dartKogo.svg",
            avgPrice: "12.21",
            precisionForFiatPrice: 3
        )
    }
}

extension FiatAttributes {
    static func fixture(hasWallet: Bool = true) -> FiatAttributes {
        FiatAttributes(
            symbol: "PLN",
            name: "Polski złoty",
            logo: "https://www.somelogo.com/logo.svg",
            logoDark: "https://www.somelogo.com/dartKogo.svg",
            hasWallets: hasWallet
        )
    }
}

extension WalletAttributes {
    static func fixture(ballance: String = "2.26908585") -> WalletAttributes {
        WalletAttributes(
            cryptocoinSymbol: "AAA",
            balance: ballance,
            isDefault: true,
            name: "A wallet",
            deleted: false
        )
    }
}

extension CommodityWalletAttributes {
    static func fixture(ballance: String = "0.3333") -> CommodityWalletAttributes {
        CommodityWalletAttributes(
            cryptocoinSymbol: "BBB",
            balance: ballance,
            isDefault: true,
            name: "B wallet",
            deleted: false
        )
    }
}

extension FiatWalletAttributes {
    static func fixture(ballance: String = "107.82000000") -> FiatWalletAttributes {
        FiatWalletAttributes(
            fiatSymbol: "PLN",
            balance: ballance,
            name: "PLN Wallet"
        )
    }
}
