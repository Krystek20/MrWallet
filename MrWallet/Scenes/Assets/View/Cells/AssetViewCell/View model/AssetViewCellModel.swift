import Combine

protocol AssetViewCellModelType {
    var name: String { get }
    var symbol: String { get }
    var iconPath: String { get }
    var price: String? { get }
}

struct AssetViewCellModel: AssetViewCellModelType, Equatable {
    let name: String
    let symbol: String
    let iconPath: String
    let price: String?
}
