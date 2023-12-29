import UIKit

// MARK: - ADD SUBVIEWS:

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
