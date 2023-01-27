import UIKit

final class SignsListView: UIView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.toAutolayout()
        searchBar.barTintColor = .wtsBlue
        searchBar.tintColor = .wtsYellow
        searchBar.searchTextField.backgroundColor = .wtsBlueDark
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.tintColor = .white
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.backgroundColor = .wtsRed
        tableView.register(SignCell.self, forCellReuseIdentifier: "signCell")
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignsListView {
    
    private func addSubviews() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        let constraints = [
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
