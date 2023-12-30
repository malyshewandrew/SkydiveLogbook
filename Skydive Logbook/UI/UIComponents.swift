import Foundation
import UIKit

// MARK: - COLORS:

let colorBackground: UIColor = #colorLiteral(red: 0.001496930607, green: 0.04223745316, blue: 0.05422458798, alpha: 1)
let colorTabBar = #colorLiteral(red: 0.06738657504, green: 0.08715785295, blue: 0.11772459, alpha: 1)
let colorCell = #colorLiteral(red: 0.04016558453, green: 0.1143882051, blue: 0.171395421, alpha: 1)
let colorItem = #colorLiteral(red: 1, green: 0.3193878531, blue: 0, alpha: 1)
let colorDarkGray = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
let colorWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let colorBlue = #colorLiteral(red: 0.042927064, green: 0.5177074075, blue: 1, alpha: 1)
let colorGreen = #colorLiteral(red: 0.1744495332, green: 0.7518933415, blue: 0.3197995424, alpha: 1)
let colorRed = #colorLiteral(red: 0.9987930655, green: 0.2710086107, blue: 0.2263382077, alpha: 1)
let colorLightGray = #colorLiteral(red: 0.5568621755, green: 0.5568631887, blue: 0.5783511996, alpha: 1)

// MARK: - COLORS CG:

let colorWhiteCG: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let colorBlackCG: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
let colorCellCG: CGColor = #colorLiteral(red: 0.04016558453, green: 0.1143882051, blue: 0.171395421, alpha: 1)
let colorBackgroundCG: CGColor = #colorLiteral(red: 0.001496930607, green: 0.04223745316, blue: 0.05422458798, alpha: 1)
let colorSystemGreenCG: CGColor = #colorLiteral(red: 0.1744495332, green: 0.7518933415, blue: 0.3197995424, alpha: 1)
let colorBlueCG: CGColor = #colorLiteral(red: 0.5799726248, green: 0.7478471398, blue: 0.9699549079, alpha: 1)
let colorGreenCG: CGColor = #colorLiteral(red: 0, green: 0.9652737975, blue: 0, alpha: 1)
let colorYellowCG: CGColor = #colorLiteral(red: 0.9407497644, green: 0.8451362848, blue: 0, alpha: 1)
let colorOrangeCG: CGColor = #colorLiteral(red: 0.996230185, green: 0.3853428364, blue: 0.2686244547, alpha: 1)
let colorRedCG: CGColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)

// MARK: - FONTS:

let fontMainNumber: UIFont = .systemFont(ofSize: 20, weight: .bold, width: .standard)
let fontMainCanopy: UIFont = .systemFont(ofSize: 18, weight: .heavy, width: .standard)
let fontMainMission: UIFont = .systemFont(ofSize: 15, weight: .medium, width: .standard)
let fontMainDateLocationAircraftHeight: UIFont = .systemFont(ofSize: 10, weight: .thin, width: .standard)

let fontStatisticTop10: UIFont = .systemFont(ofSize: 9, weight: .medium, width: .standard)
let fontStatisticMissions: UIFont = .systemFont(ofSize: 9, weight: .medium, width: .standard)

let fontCalculatorText: UIFont = .systemFont(ofSize: 10, weight: .regular, width: .standard)


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
