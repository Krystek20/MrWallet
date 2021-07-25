import UIKit
import Combine

final class AssetsView: UIView {
    
    // MARK: - Properties
    
    var isLoading: Bool = false {
        didSet {
            isLoading
                ? indicatorView.startAnimating()
                : indicatorView.stopAnimating()
        }
    }
    
    // MARK: - Views
    
    let tableView = UITableView().configure {
        $0.register(cell: AssetViewCell.self)
    }
    
    let segmentControl = UISegmentedControl(items: AssetFilters.allCases.map(\.rawValue)).configure {
        $0.selectedSegmentIndex = .zero
    }
    
    private let indicatorView = UIActivityIndicatorView().configure {
        $0.hidesWhenStopped = true
        $0.color = .darkGray
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
        addSubview(indicatorView)
        addSubview(segmentControl)
        addSubview(tableView)
    }
    
    override func updateConstraints() {
        segmentControl.activate {[
            $0.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10.0),
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0),
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -10.0)
        ]}
        
        tableView.activate {[
            $0.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10.0),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor),
            $0.leftAnchor.constraint(equalTo: leftAnchor),
            $0.rightAnchor.constraint(equalTo: rightAnchor)
        ]}
        
        indicatorView.activate {[
            $0.centerYAnchor.constraint(equalTo: centerYAnchor),
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]}
        
        super.updateConstraints()
    }
}
