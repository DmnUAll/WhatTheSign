import UIKit

// MARK: - SifnInfoController
final class SignInfoController: UIViewController {

    // MARK: - Properties and Initializers
    private let signInfoView = SignInfoView()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .wtsBlue
        view.addSubview(signInfoView)
        setupConstraints()
    }

    convenience init(signInfo: [String: String]) {
        self.init()
        title = signInfo["signNumber"] ?? "Не определено"
        signInfoView.signImageView.image = UIImage(named: signInfo["signNumber"] ?? "1.1")
        signInfoView.signNameLabel.text = signInfo["signName"] ?? "Не определено"
        signInfoView.signInfoTextView.text = signInfo["signDescription"] ?? "Не определено"
    }
}

// MARK: - Helpers
extension SignInfoController {

    private func setupConstraints() {
        let constraints = [
            signInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
