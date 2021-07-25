import UIKit
import Combine
import SDWebImageSVGCoder

final class AssetViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: AssetViewCellModelType? {
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
    private let priceLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 14.0, weight: .regular)
        $0.textColor = .darkGray
    }
    private lazy var stackView = UIStackView(arrangedSubviews: [nameLabel, symbolLabel, priceLabel]).configure {
        $0.axis = .vertical
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
        contentView.addSubview(priceLabel)
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
            $0.rightAnchor.constraint(lessThanOrEqualTo: priceLabel.leftAnchor, constant: -10.0)
        ]}
        
        priceLabel.activate {[
            $0.topAnchor.constraint(equalTo: stackView.topAnchor),
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0)
        ]}
        
        super.updateConstraints()
    }
    
    private func configureViews() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        symbolLabel.text = viewModel.symbol
        guard let url = URL(string: viewModel.iconPath) else { return }
        iconView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "photo")
        )
    }
}
