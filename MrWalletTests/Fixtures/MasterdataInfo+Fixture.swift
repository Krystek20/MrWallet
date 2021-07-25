import Foundation
@testable import MrWallet

extension MasterdataInfo {
    static let fixture = MasterdataInfo(
        data: Masterdata(
            type: .collection,
            attributes: MasterdataAttributes(
                cryptocoins: [.fixtureCryptocoin],
                commodities: [.fixtureCommodity],
                fiats: [.fixtureFiat()],
                wallets: [.fixtureWallet()],
                commodityWallets: [.fixtureCommodityWallet()],
                fiatwallets: [.fixtureFiatWallet()])
        )
    )
}
