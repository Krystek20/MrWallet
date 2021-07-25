import UIKit
import Combine

final class WalletsView: UIView {
    
    // MARK: - Views
    
    let tableView = UITableView().configure {
        $0.register(cell: WalletViewCell.self)
        $0.register(cell: FiatWalletViewCell.self)
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupSelf()
        setupViews()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupSelf() {
        backgroundColor = .white
    }
    
    private func setupViews() {
        addSubview(tableView)
    }
    
    override func updateConstraints() {
        tableView.activate {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leftAnchor.constraint(equalTo: leftAnchor),
            $0.rightAnchor.constraint(equalTo: rightAnchor)
        ]}
        super.updateConstraints()
    }
}
