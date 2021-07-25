import UIKit
import Combine
import SDWebImageSVGCoder

final class WalletViewCell: UITableViewCell, WalletCell {
    
    // MARK: - Properties
    
    var viewModel: WalletViewCellModelType? {
        didSet { configureViews() }
    }
    
    // MARK: - Views
    
    private let iconView = UIImageView().configure {
        $0.contentMode = .scaleAspectFit
    }
    private let nameLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.textColor = .darkGray
    }
    private let symbolLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14.0, weight: .light)
        $0.textColor = .darkGray
    }
    private lazy var stackView = UIStackView(arrangedSubviews: [nameLabel, symbolLabel]).configure {
        $0.axis = .vertical
    }
    private let defaultLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14.0, weight: .light)
        $0.textColor = .darkGray
        $0.text = "Default"
    }
    private let balanceLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.textColor = .darkGray
    }
    private lazy var rightStackView = UIStackView(arrangedSubviews: [balanceLabel, defaultLabel]).configure {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSelf()
        setupViews()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupSelf() {
        selectionStyle = .none
    }
    
    private func setupViews() {
        contentView.addSubview(iconView)
        contentView.addSubview(stackView)
        contentView.addSubview(rightStackView)
    }
    
    override func updateConstraints() {
        iconView.activate {[
            $0.widthAnchor.constraint(equalToConstant: 35.0),
            $0.heightAnchor.constraint(equalToConstant: 35.0),
            $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
            $0.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10.0),
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
        ]}
        
        stackView.activate {[
            $0.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10.0),
            $0.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10.0),
            $0.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            $0.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 10.0),
            $0.rightAnchor.constraint(lessThanOrEqualTo: rightStackView.leftAnchor, constant: -10.0)
        ]}
        
        rightStackView.activate {[
            $0.topAnchor.constraint(equalTo: stackView.topAnchor),
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0)
        ]}

        super.updateConstraints()
    }
    
    private func configureViews() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        balanceLabel.text = viewModel.balance
        symbolLabel.text = viewModel.symbol
        defaultLabel.isHidden = !viewModel.isMarked
        guard let path = viewModel.iconPath,
              let url = URL(string: path) else { return }
        iconView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "photo")
        )
    }
}
