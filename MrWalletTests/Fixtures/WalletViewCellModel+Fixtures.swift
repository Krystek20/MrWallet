import Foundation
@testable import MrWallet

extension WalletViewCellModel {
    static var fixture: WalletViewCellModel {
        WalletViewCellModel(
            name: "example name",
            symbol: "EN",
            iconPath: "example path",
            balance: "123.12",
            isMarked: true
        )
    }
}

