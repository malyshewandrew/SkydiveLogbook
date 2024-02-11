import RealmSwift
import UIKit

// MARK: - ADD SUBVIEWS:

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

// MARK: - STACKVIEW ADD SUBVIEWS:

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}


//// MARK: - BLUR:
//extension UIView {
//    func applyBlurEffect(_ style: UIBlurEffect.Style = .dark) {
//        let blurEffect = UIBlurEffect(style: style)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(blurEffectView)
//    }
//}
