import Foundation
import UIKit.UIView

protocol Configurable { }

extension Configurable {
    @discardableResult
    func configure(_ configure: (Self) -> Void) -> Self {
        configure(self)
        return self
    }
}
