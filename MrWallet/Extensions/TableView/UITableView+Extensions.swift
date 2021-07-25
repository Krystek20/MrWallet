import UIKit.UITableView

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
    }
}
