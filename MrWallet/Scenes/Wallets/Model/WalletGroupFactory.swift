import Foundation

protocol WalletGroupFactoring {
    func createWalletGroup(
        from walletsAttributes: [Attributes<WalletAttributes>],
        cryptocoinAttributes: [Attributes<CryptocoinAttributes>]) -> WalletGroup
    func createWalletGroup(
        from commodityWalletAttributes: [Attributes<CommodityWalletAttributes>],
        commodityAttributes: [Attributes<CommodityAttributes>]) -> WalletGroup
    func createWalletGroup(
        from fiatWalletAttributes: [Attributes<FiatWalletAttributes>],
        fiatAttributes: [Attributes<FiatAttributes>]) -> WalletGroup
}

struct WalletGroupFactory: WalletGroupFactoring {
    func createWalletGroup(
        from walletsAttributes: [Attributes<WalletAttributes>],
        cryptocoinAttributes: [Attributes<CryptocoinAttributes>]) -> WalletGroup {
        WalletGroup(
            name: "Wallets",
            cellType: .standard,
            walletViewModels: walletsAttributes
                .compactMap {
                    guard !$0.attributes.deleted else { return nil }
                    let symbol = $0.attributes.cryptocoinSymbol
                    let cryptocoin = cryptocoinAttributes.first(where: { $0.attributes.symbol == symbol })
                    return WalletViewCellModel(
                        walletAttribute: $0.attributes,
                        cryptocoinAttributes: cryptocoin?.attributes
                    )
                }
                .sorted(type: .desc)
        )
    }
    
    func createWalletGroup(
        from commodityWalletAttributes: [Attributes<CommodityWalletAttributes>],
        commodityAttributes: [Attributes<CommodityAttributes>]) -> WalletGroup {
        WalletGroup(
            name: "Commodity Wallets",
            cellType: .standard,
            walletViewModels: commodityWalletAttributes
                .compactMap {
                    guard !$0.attributes.deleted else { return nil }
                    let symbol = $0.attributes.cryptocoinSymbol
                    let cryptocoin = commodityAttributes.first(where: { $0.attributes.symbol == symbol })
                    return WalletViewCellModel(
                        commodityWalletAttributes: $0.attributes,
                        commodityAttributes: cryptocoin?.attributes
                    )
                }
                .sorted(type: .desc)
        )
    }
    
    func createWalletGroup(
        from fiatWalletAttributes: [Attributes<FiatWalletAttributes>],
        fiatAttributes: [Attributes<FiatAttributes>]) -> WalletGroup {
        WalletGroup(
            name: "Fiat Wallets",
            cellType: .decorated,
            walletViewModels: fiatWalletAttributes
                .map {
                    let symbol = $0.attributes.fiatSymbol
                    let fiat = fiatAttributes.first(where: { $0.attributes.symbol == symbol })
                    return WalletViewCellModel(
                        fiatWalletAttributes: $0.attributes,
                        fiatAttributes: fiat?.attributes
                    )
                }
                .sorted(type: .desc)
        )
    }
}
