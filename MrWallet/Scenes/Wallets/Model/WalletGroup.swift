import Combine

enum WalletCellType: Equatable {
    case standard
    case decorated
}

protocol WalletGroupType: Equatable {
    var name: String { get }
    var walletViewModels: [WalletViewCellModel] { get }
    var cellType: WalletCellType { get }
}

struct WalletGroup: WalletGroupType, Equatable {
    let name: String
    let cellType: WalletCellType
    let walletViewModels: [WalletViewCellModel]
}
