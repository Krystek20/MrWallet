import Foundation
@testable import MrWallet

extension WalletGroup {
    static func fixture(cellType: WalletCellType) -> WalletGroup {
        WalletGroup(
            name: "example name",
            cellType: cellType,
            walletViewModels: [
                .fixture,
                .fixture
            ]
        )
    }
}
