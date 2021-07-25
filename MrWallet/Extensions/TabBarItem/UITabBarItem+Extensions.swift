import UIKit.UITabBarItem

extension UITabBarItem {
    static var walletTabBarItem: UITabBarItem {
        UITabBarItem(
            title: "Wallet",
            image: UIImage(systemName: "wallet.pass"),
            selectedImage: UIImage(systemName: "wallet.pass.fill")
        )
    }
    
    static var assetTabBarItem: UITabBarItem {
        UITabBarItem(
            title: "Asset",
            image: UIImage(systemName: "bitcoinsign.circle"),
            selectedImage: UIImage(systemName: "bitcoinsign.circle.fill")
        )
    }
}
