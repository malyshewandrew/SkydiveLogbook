import Foundation
import UIKit

// MARK: - FONTS:

let fontMainNumber: UIFont = .systemFont(ofSize: 20, weight: .bold, width: .standard)
let fontMainCanopy: UIFont = .systemFont(ofSize: 18, weight: .heavy, width: .standard)
let fontMainMission: UIFont = .systemFont(ofSize: 15, weight: .medium, width: .standard)
let fontMainDateLocationAircraftHeight: UIFont = .systemFont(ofSize: 10, weight: .thin, width: .standard)
let fontStatisticTop10: UIFont = .systemFont(ofSize: 9, weight: .medium, width: .standard)
let fontStatisticMissions: UIFont = .systemFont(ofSize: 9, weight: .medium, width: .standard)
let fontCalculatorText: UIFont = .systemFont(ofSize: 10, weight: .regular, width: .standard)
let fontRegularStandart8: UIFont = .systemFont(ofSize: 8, weight: .regular, width: .standard)
let fontStackView: UIFont = .systemFont(ofSize: 8, weight: .regular, width: .standard)
let fontBoldStandart10: UIFont = .systemFont(ofSize: 10, weight: .bold, width: .standard)
let fontRegularStandart10: UIFont = .systemFont(ofSize: 10, weight: .regular, width: .standard)
let fontMediumStandart10: UIFont = .systemFont(ofSize: 10, weight: .medium, width: .standard)
let fontMediumStandart12: UIFont = .systemFont(ofSize: 12, weight: .medium, width: .standard)
let fontRegularStandart12: UIFont = .systemFont(ofSize: 12, weight: .regular, width: .standard)
let fontBoldStandart14: UIFont = .systemFont(ofSize: 14, weight: .bold, width: .standard)
let fontMediumStandart14: UIFont = .systemFont(ofSize: 14, weight: .medium, width: .standard)
let fontBoldStandart16: UIFont = .systemFont(ofSize: 16, weight: .bold, width: .standard)
let fontMediumStandart16: UIFont = .systemFont(ofSize: 16, weight: .bold, width: .standard)
let fontRegularStandart18: UIFont = .systemFont(ofSize: 18, weight: .regular, width: .standard)
let fontMediumStandart18: UIFont = .systemFont(ofSize: 18, weight: .bold, width: .standard)
let fontBoldStandart20: UIFont = .systemFont(ofSize: 20, weight: .bold, width: .standard)
let fontBoldStandart22: UIFont = .systemFont(ofSize: 22, weight: .bold, width: .standard)
let fontBoldStandart24: UIFont = .systemFont(ofSize: 24, weight: .bold, width: .standard)
let fontBoldStandart30: UIFont = .systemFont(ofSize: 30, weight: .bold, width: .standard)

// MARK: - NUMBER OF LINES:

let numberOfLines1 = 1
let numberOfLines0 = 0

// MARK: - CORNER RADIUS:

let cornerRadius10: CGFloat = 10
let cornerRadius20: CGFloat = 20

// MARK: - TEXT ALIGMENT:

let textAligmentTop: UIControl.ContentVerticalAlignment = .top
let textAligmentCenter: NSTextAlignment = .center
let textAligmentLeft: NSTextAlignment = .left

// MARK: - BORDER WIDTH:

let borderWidth05: CGFloat = 0.5

// MARK: - HEIGHTS:

let height40: CGFloat = 40
let height65: CGFloat = 65
let height75: CGFloat = 75

// MARK: - VIBRATIONS:

class Vibration {
    let vibrationNotification = UINotificationFeedbackGenerator()

    func vibrationSucces() {
        vibrationNotification.notificationOccurred(.success)
    }

    func vibrationError() {
        vibrationNotification.notificationOccurred(.error)
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
