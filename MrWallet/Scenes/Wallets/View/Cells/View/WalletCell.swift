import UIKit.UITableViewCell

protocol WalletCell where Self: UITableViewCell {
    var viewModel: WalletViewCellModelType? { get set }
}
