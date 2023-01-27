import UIKit

final class SignCell: UITableViewCell {
    
    let signImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var signNumberLabel = makeLabel(withAlignment: .center)
    
    lazy var signNameLabel = makeLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        backgroundColor = .wtsBlueLight
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignCell {
    
    private func addSubviews() {
        addSubview(signImageView)
        addSubview(signNumberLabel)
        addSubview(signNameLabel)
    }
    
    private func setupConstraints() {
        let constraints = [
            signImageView.heightAnchor.constraint(equalToConstant: 48),
            signImageView.widthAnchor.constraint(equalTo: signImageView.heightAnchor, multiplier: 1),
            signImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            signNumberLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 54),
            signNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            signNumberLabel.leadingAnchor.constraint(equalTo: signImageView.trailingAnchor, constant: 9),
            signNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            signNameLabel.leadingAnchor.constraint(equalTo: signNumberLabel.trailingAnchor, constant: 9),
            signNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeLabel(withAlignment alignment: NSTextAlignment = .natural) -> UILabel {
        let label = UILabel()
        label.toAutolayout()
        label.textAlignment = alignment
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }
}
