import Foundation
import UIKit

// MARK: - FONTS:

let fontRegularStandard8: UIFont = .systemFont(ofSize: 8, weight: .regular, width: .standard) // account: info account text.
let fontMediumStandard9: UIFont = .systemFont(ofSize: 9, weight: .medium, width: .standard) // statistic: top10.
let fontBoldStandard10: UIFont = .systemFont(ofSize: 10, weight: .bold, width: .standard) // system titles: container, aad, main, reserve.
let fontRegularStandard10: UIFont = .systemFont(ofSize: 10, weight: .regular, width: .standard) // calculator: result text label.
let fontMediumStandard10: UIFont = .systemFont(ofSize: 10, weight: .medium, width: .standard)
let fontThinStandard10: UIFont = .systemFont(ofSize: 10, weight: .thin, width: .standard) // main jump cell: right side.
let fontMediumStandard12: UIFont = .systemFont(ofSize: 12, weight: .medium, width: .standard)
let fontRegularStandard12: UIFont = .systemFont(ofSize: 12, weight: .regular, width: .standard)
let fontBoldStandard14: UIFont = .systemFont(ofSize: 14, weight: .bold, width: .standard)
let fontMediumStandard14: UIFont = .systemFont(ofSize: 14, weight: .medium, width: .standard)
let fontMediumStandard15: UIFont = .systemFont(ofSize: 15, weight: .medium, width: .standard)
let fontBoldStandard16: UIFont = .systemFont(ofSize: 16, weight: .bold, width: .standard)
let fontHeavyStandard18: UIFont = .systemFont(ofSize: 18, weight: .heavy, width: .standard)
let fontRegularStandard18: UIFont = .systemFont(ofSize: 18, weight: .regular, width: .standard)
let fontMediumStandard18: UIFont = .systemFont(ofSize: 18, weight: .bold, width: .standard)
let fontBoldStandard20: UIFont = .systemFont(ofSize: 20, weight: .bold, width: .standard)
let fontBoldStandard22: UIFont = .systemFont(ofSize: 22, weight: .bold, width: .standard)
let fontBoldStandard24: UIFont = .systemFont(ofSize: 24, weight: .bold, width: .standard)
let fontBoldStandard30: UIFont = .systemFont(ofSize: 30, weight: .bold, width: .standard)

// MARK: - CORNER RADIUS:

let cornerRadius10: CGFloat = 10
let cornerRadius20: CGFloat = 20

// MARK: - TEXT ALIGMENT:

let textAligmentTop: UIControl.ContentVerticalAlignment = .top
let textAligmentCenter: NSTextAlignment = .center

// MARK: - HEIGHTS:

let height40: CGFloat = 40
let height65: CGFloat = 65
let height75: CGFloat = 75

// MARK: - VIBRATIONS:

class Vibration {
    let vibrationNotification = UINotificationFeedbackGenerator()
    let vibrationSelectionFeedbackGenerator = UISelectionFeedbackGenerator()
    let vibrationImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    func vibrationSucces() {
        vibrationNotification.notificationOccurred(.success)
    }

    func vibrationError() {
        vibrationNotification.notificationOccurred(.error)
    }
    
    func vibrationSelection() {
        vibrationSelectionFeedbackGenerator.prepare()
        vibrationSelectionFeedbackGenerator.selectionChanged()
    }
    
    func vibrationStandart() {
        vibrationImpactFeedbackGenerator.prepare()
        vibrationImpactFeedbackGenerator.impactOccurred()
    }
}

// MARK: - GRADIENT:

// Добавляется к объекту который нужно залить через метод .addGradient
extension UIView {
    func addGradient(colors: [UIColor], startPoint: CGPoint = .init(x: 0.0, y: 0.5),
                     endPoint: CGPoint = .init(x: 1.0, y: 0.5))
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
