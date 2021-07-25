import Foundation
@testable import MrWallet

extension AssetViewCellModel {
    static var fixture: AssetViewCellModel {
        AssetViewCellModel(
            name: "Example name",
            symbol: "AAA",
            iconPath: "https://www.examplePath.com/static/cryptocoin/btc.svg",
            price: "66.32"
        )
    }
    
    static var fixtureWithoutPrice: AssetViewCellModel {
        AssetViewCellModel(
            name: "Example name",
            symbol: "AAA",
            iconPath: "https://www.examplePath.com/static/cryptocoin/btc.svg",
            price: nil
        )
    }
}
