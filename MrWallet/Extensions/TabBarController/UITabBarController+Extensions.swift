import UIKit.UITabBarController

extension UITabBarController {
    func append(_ controller: UIViewController) {
        let controllers = viewControllers ?? []
        viewControllers = (controllers + [controller])
    }
}
