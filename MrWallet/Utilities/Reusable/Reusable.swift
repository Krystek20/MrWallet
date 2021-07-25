import Foundation
import UIKit.UITableViewCell

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
