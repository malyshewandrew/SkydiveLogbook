import Foundation
import UIKit

// MARK: - FONTS:

let fontRegularStandard8: UIFont = .systemFont(ofSize: 8, weight: .regular, width: .standard) // account: info account text
let fontMediumStandard9: UIFont = .systemFont(ofSize: 9, weight: .medium, width: .standard) // statistic: top10
let fontBoldStandard10: UIFont = .systemFont(ofSize: 10, weight: .bold, width: .standard) // system titles: container, aad, main, reserve
let fontRegularStandard10: UIFont = .systemFont(ofSize: 10, weight: .regular, width: .standard) // calculator: result text label
let fontMediumStandard10: UIFont = .systemFont(ofSize: 10, weight: .medium, width: .standard)
let fontThinStandard10: UIFont = .systemFont(ofSize: 10, weight: .thin, width: .standard) // main jump cell: right side
let fontMediumStandard12: UIFont = .systemFont(ofSize: 12, weight: .medium, width: .standard)
let fontRegularStandard12: UIFont = .systemFont(ofSize: 12, weight: .regular, width: .standard)
let fontRegularStandard14: UIFont = .systemFont(ofSize: 14, weight: .regular, width: .standard)
let fontThinStandard14: UIFont = .systemFont(ofSize: 14, weight: .thin, width: .standard)
let fontMediumStandard14: UIFont = .systemFont(ofSize: 14, weight: .medium, width: .standard)
let fontBoldStandard16: UIFont = .systemFont(ofSize: 16, weight: .bold, width: .standard)
let fontMediumStandard18: UIFont = .systemFont(ofSize: 18, weight: .bold, width: .standard)
let fontBoldStandard24: UIFont = .systemFont(ofSize: 24, weight: .bold, width: .standard)
let fontBoldStandard30: UIFont = .systemFont(ofSize: 30, weight: .bold, width: .standard)
let fontRegularStandard50: UIFont = .systemFont(ofSize: 50, weight: .regular, width: .standard)
let fontRegularStandard72: UIFont = .systemFont(ofSize: 72, weight: .thin, width: .standard)
let fontBlackSandard100: UIFont = .systemFont(ofSize: 100, weight: .black, width: .standard)

// MARK: - CORNER RADIUS:

let cornerRadius15: CGFloat = 15

// MARK: - HEIGHTS:

let height40: CGFloat = 40
let height45: CGFloat = 45
let height65: CGFloat = 65
let height75: CGFloat = 75

// MARK: - TEXT ALIGMENT:

let textAligmentTop: UIControl.ContentVerticalAlignment = .top
let textAligmentCenter: NSTextAlignment = .center

// MARK: - VIBRATIONS:

final class Vibration {
    let vibrationNotification = UINotificationFeedbackGenerator()
    let vibrationSelectionFeedbackGenerator = UISelectionFeedbackGenerator()
    let vibrationSmall = UIImpactFeedbackGenerator(style: .light)
    let vibrationMedium = UIImpactFeedbackGenerator(style: .medium)
    let vibrationImpactFeedbackGeneratorSpeed = UIImpactFeedbackGenerator(style: .rigid)

    func vibrationSucces() {
        self.vibrationNotification.notificationOccurred(.success)
    }

    func vibrationError() {
        self.vibrationNotification.notificationOccurred(.error)
    }
    
    func vibrationSelection() {
        self.vibrationSelectionFeedbackGenerator.prepare()
        self.vibrationSelectionFeedbackGenerator.selectionChanged()
    }
    
    func vibrationLight() {
        self.vibrationSmall.prepare()
        self.vibrationSmall.impactOccurred()
    }
    
    func vibrationStandart() {
        self.vibrationMedium.prepare()
        self.vibrationMedium.impactOccurred()
    }
    
    var timer: Timer?

    func handleVibration() {
        if timer == nil {
            vibrationImpactFeedbackGeneratorSpeed.prepare()
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(vibrationSpeed), userInfo: nil, repeats: true)
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func vibrationSpeed() {
        self.vibrationImpactFeedbackGeneratorSpeed.impactOccurred()
    }
}
