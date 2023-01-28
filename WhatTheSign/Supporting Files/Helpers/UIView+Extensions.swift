import UIKit

extension UIView {

    func toAutolayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addKeyboardHiddingFeature() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
}
