import UIKit
import CoreML
import Vision

// MARK: - SignsListController
final class SignsListController: UIViewController {

    // MARK: - Properties and Initializers
    private let signsListView = SignsListView()
    private var presenter: SignsListPresenter?
    private let imagePicker = UIImagePickerController()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Счастливого пути!"
        view.backgroundColor = .wtsBlue
        view.addSubview(signsListView)
        setupConstraints()
        presenter = SignsListPresenter(viewController: self)
        signsListView.searchBar.delegate = self
        signsListView.tableView.dataSource = self
        signsListView.tableView.delegate = self
        (navigationController as? NavigationController)?.buttonsDelegate = self
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        view.addKeyboardHiddingFeature()
    }
}

// MARK: - Helpers
extension SignsListController {

    private func setupConstraints() {
        let constraints = [
            signsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signsListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func updateSignsList(bySearch searchText: String?) {
        presenter?.applyFilter(withText: searchText)
        signsListView.tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension SignsListController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateSignsList(bySearch: searchBar.text)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSignsList(bySearch: searchText)
    }
}

// MARK: - UITableViewDataSource
extension SignsListController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSections = presenter?.giveNumberOfSections() else { return 0}
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = presenter?.giveNameOfSection(section) else { return nil }
        return title
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 48)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = .wtsBlue
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        let headerView = UIView()
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return 48
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = presenter?.giveNumberOfRows(inSection: section) else { return 0 }
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = presenter?.configureCell(forIndexPath: indexPath,
                                                  at: tableView) else {
            return UITableViewCell()
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SignsListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = presenter?.giveSignInfo(forIndexPath: indexPath) else { return }
        navigationController?.pushViewController(SignInfoController(signInfo: data), animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SignsListController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Не удалось конвертировать UIImage в CIImage")
            }
              detectImage(image: ciimage)
        }
        imagePicker.dismiss(animated: true)
    }

    func detectImage(image: CIImage) {
        guard let model = try? VNCoreMLModel(
            for: RoadSignImageClassifier(configuration: MLModelConfiguration()).model
        ) else {
            fatalError("Ошибка загрузки модели CoreML")
        }
        let request = VNCoreMLRequest(model: model) { [weak self] request, _ in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Ошибка при обработке фото")
            }
            if let firstResult = results.first {
                guard let self,
                      let data = self.presenter?.giveSignInfo(forGuess: firstResult.identifier) else { return }
                self.navigationController?.pushViewController(SignInfoController(signInfo: data), animated: true)
            }
        }

        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError("Ошибка при обработке запроса")
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension SignsListController: UINavigationControllerDelegate { }

// MARK: - NavigationButtonsDelegate
extension SignsListController: NavigationButtonsDelegate {
    func showInfo() {
        let alert = UIAlertController(title: "Ссылка на GitHub", message: nil, preferredStyle: .alert)
        let textView = UITextView()
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let controller = UIViewController()
        textView.frame = controller.view.frame
        controller.view.addSubview(textView)
        textView.backgroundColor = .clear
        alert.setValue(controller, forKey: "contentViewController")
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view!,
                                                            attribute: .height,
                                                            relatedBy: .equal,
                                                            toItem: nil,
                                                            attribute: .notAnAttribute,
                                                            multiplier: 1,
                                                            constant: 150)
        alert.view.addConstraint(height)
        let attributedString = NSMutableAttributedString(string: "https://github.com/DmnUAll/WhatTheSign")
        let url = URL(string: "https://github.com/DmnUAll/WhatTheSign")
        attributedString.setAttributes([.link: url ?? ""], range: NSRange(location: 0, length: attributedString.length))
        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.textAlignment = .center
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func showImagePicker() {
        present(imagePicker, animated: true, completion: nil)
    }
}
