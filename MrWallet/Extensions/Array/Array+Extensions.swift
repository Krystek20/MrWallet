import Foundation

extension Array where Element == WalletViewCellModel {
    enum SortingType {
        case asc
        case desc
    }
    
    func sorted(type: SortingType) -> [Element] {
        sorted(by: { lhs, rhs in
            let lhsBalance = Double(lhs.balance) ?? .zero
            let rhsBalance = Double(rhs.balance) ?? .zero
            switch type {
            case .asc: return lhsBalance < rhsBalance
            case .desc: return lhsBalance > rhsBalance
            }
        })
    }
}
