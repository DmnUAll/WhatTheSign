import UIKit

final class SignsListPresenter {
    
    private let signCategory = [
        "Предупреждающие знаки",
        "Знаки приоритета",
        "Запрещающие знаки",
        "Предписывающие знаки",
        "Знаки особых предписаний",
        "Информационные знаки",
        "Знаки сервиса",
        "Знаки дополнительной информации (таблички)"
    ]
    private weak var viewController: SignsListController?
    private var signsArray = [[String: String]]()
    
    init(viewController: SignsListController? = nil) {
        self.viewController = viewController
        getData()
    }
}

extension SignsListPresenter {
    
    private func getData() {
        let path = Bundle.main.path(forResource: "Signs", ofType: "plist")!
        guard let data = NSArray(contentsOfFile: path) as? Array<[String: String]> else { return }
        signsArray = data
    }
    
    func giveNumberOfSections() -> Int {
        signCategory.count
    }
    
    func giveNameOfSection(_ section: Int) -> String? {
        signCategory[section]
    }
    
    func giveNumberOfRows(inSection section: Int) -> Int {
        var counter = 0
        for item in signsArray where item["signNumber"]!.hasPrefix("\(section + 1)") {
            counter += 1
        }
        return counter
    }
    
    func configureCell(forIndexPath indexPath: IndexPath, at tableView: UITableView) -> UITableViewCell {
        let signsArray = signsArray.filter{$0["signNumber"]!.hasPrefix("\(indexPath.section + 1)")}
        let cell = tableView.dequeueReusableCell(withIdentifier: "signCell", for: indexPath) as! SignCell
        cell.signNumberLabel.text = signsArray[indexPath.row]["signNumber"]
        cell.signNameLabel.text = signsArray[indexPath.row]["signName"]
        cell.signImageView.image = UIImage(named: signsArray[indexPath.row]["signNumber"] ?? "1.1")
        return cell
    }
    
    func giveSignInfo(forIndexPath indexPath: IndexPath) -> [String: String] {
        let signsGroupArray = signsArray.filter{$0["signNumber"]!.hasPrefix("\(indexPath.section + 1)")}
        return signsGroupArray[indexPath.row]
    }
    
    func giveSignInfo(forGuess guess: String) -> [String: String]? {
        guard let signInfo = signsArray.first(where: {$0["signNumber"] == guess}) else { return nil }
        return signInfo
    }
    
    func applyFilter(withText text: String?) {
        guard let text else { return }
        getData()
        if text != "" {
            signsArray = signsArray.filter{$0["signName"]!.lowercased().contains("\(text.lowercased())")}
        } 
    }
}
