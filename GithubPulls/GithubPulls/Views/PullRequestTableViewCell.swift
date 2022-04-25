import UIKit

class PullRequestTableViewCell: UITableViewCell {
    private let imageSize: CGFloat = 50.0
    private let contentSpacing: CGFloat = 4.0
    private let imageSpacing: CGFloat = 16.0
    private let inset: CGFloat = 16.0
    static let reusableIdentifier: String = "PullRequestTableViewCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let createdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let closedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var userImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = contentSpacing
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(userName)
        stackView.addArrangedSubview(createdLabel)
        stackView.addArrangedSubview(closedLabel)
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = imageSpacing
        stackView.addArrangedSubview(userImageView)
        stackView.addArrangedSubview(labelStackView)
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        title.text = nil
        userName.text = nil
        createdLabel.text = nil
        closedLabel.text = nil
        userImageView.image = nil
    }
    
    private func configureCell() {
        contentView.addSubview(contentStackView)
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset))
        constraints.append(contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset))
        constraints.append(contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset))
        constraints.append(contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset))
        constraints.append(userImageView.widthAnchor.constraint(equalToConstant: imageSize))
        constraints.append(userImageView.heightAnchor.constraint(equalToConstant: imageSize))
        NSLayoutConstraint.activate(constraints)
    }
}
