import AlertKit
import UIKit

// MARK: - CLASS:

final class AlertKitManager {
    // MARK: - STATIC:

    static let instance = AlertKitManager()

    // MARK: - PRIVATE INIT:

    private init() {}

    // MARK: - PUBLIC METHODS:

    func alertKit(title: String, icon: AlertIcon, style: AlertViewStyle, haptic: AlertHaptic) {
        AlertKitAPI.present(
            title: title,
            icon: icon,
            style: style,
            haptic: haptic
        )
    }
}
