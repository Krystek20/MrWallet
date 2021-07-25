import UIKit.UIView

extension UIView: Configurable { }

extension UIView {
    func activate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func activate(_ makeConstraints: (UIView) -> [NSLayoutConstraint]) {
        activate(constraints: makeConstraints(self))
    }
}
