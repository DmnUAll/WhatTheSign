import UIKit

// MARK: - SignInfoView
final class SignInfoView: UIView {

    // MARK: - Properties and Initializers
    let signImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutolayout()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()

    let signNameLabel: UILabel = {
        let label = UILabel()
        label.toAutolayout()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    let signInfoTextView: UITextView = {
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .wtsBlueSky
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.layer.cornerRadius = 25
        textView.layer.borderWidth = 1.5
        textView.layer.borderColor = UIColor.black.cgColor
        textView.clipsToBounds = true
        return textView
    }()

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .wtsBlueLight
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SignInfoView {

    private func addSubviews() {
        mainStackView.addArrangedSubview(signImageView)
        mainStackView.addArrangedSubview(signNameLabel)
        mainStackView.addArrangedSubview(signInfoTextView)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let constraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6),
            signImageView.heightAnchor.constraint(equalTo: signImageView.widthAnchor, multiplier: 1),
            signImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 6),
            signImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 6),
            signImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -6),
            signNameLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 12),
            signNameLabel.topAnchor.constraint(equalTo: signImageView.bottomAnchor, constant: 6),
            signNameLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -12),
            signInfoTextView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 6),
            signInfoTextView.topAnchor.constraint(equalTo: signNameLabel.bottomAnchor, constant: 6),
            signInfoTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            signInfoTextView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
