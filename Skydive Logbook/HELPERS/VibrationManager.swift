import UIKit

// MARK: - CLASS:

final class VibrationManager {
    // MARK: - STATIC:

    static let instance = VibrationManager()
    
    // MARK: - PRIVATE INIT:

    private init() {}
    
    // MARK: - PROPERTIES:

    private let vibrationNotification = UINotificationFeedbackGenerator()
    private let vibrationSelectionFeedbackGenerator = UISelectionFeedbackGenerator()
    private let vibrationSmall = UIImpactFeedbackGenerator(style: .light)
    let vibrationMedium = UIImpactFeedbackGenerator(style: .medium)
    private let vibrationImpactFeedbackGeneratorSpeed = UIImpactFeedbackGenerator(style: .rigid)
    private var timer: Timer?
    
    // MARK: - PUBLIC METHODS:

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

    func handleVibration() {
        if self.timer == nil {
            self.vibrationImpactFeedbackGeneratorSpeed.prepare()
            self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.vibrationSpeed), userInfo: nil, repeats: true)
        } else {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    @objc private func vibrationSpeed() {
        self.vibrationImpactFeedbackGeneratorSpeed.impactOccurred()
    }
}
