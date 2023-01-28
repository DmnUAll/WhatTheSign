import UIKit

// MARK: - NavigationButtonsDelegate protocol
protocol NavigationButtonsDelegate: AnyObject {
    func showInfo()
    func showImagePicker()
}

// MARK: - NavigationController
final class NavigationController: UINavigationController {

    // MARK: - Properties and Initializers
    weak var buttonsDelegate: NavigationButtonsDelegate?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension NavigationController {

    @objc private func infoButtonTapped() {
        buttonsDelegate?.showInfo()
    }

    @objc private func cameraButtonTapped() {
        buttonsDelegate?.showImagePicker()
    }

    private func configureNavigationController() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backgroundColor = .wtsBlue
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.wtsYellow
        ]
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                           style: .plain,
                                           target: nil,
                                           action: #selector(infoButtonTapped))
        navigationBar.topItem?.leftBarButtonItem = infoButton
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"),
                                           style: .plain,
                                           target: nil,
                                           action: #selector(cameraButtonTapped))
        navigationBar.topItem?.rightBarButtonItem = cameraButton
        navigationBar.topItem?.backButtonTitle = "Назад"
    }
}
