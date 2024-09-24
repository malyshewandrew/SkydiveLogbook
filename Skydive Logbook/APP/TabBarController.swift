import SwiftUI
import UIKit

// MARK: - CLASS:

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: PRIVATE PROPERTIES:

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    // MARK: FUNC FOR ACTION WHERE TAP ON ITEM:

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            switch selectedIndex {
            case 0:
                VibrationManager.instance.vibrationStandart()
            case 1:
                VibrationManager.instance.vibrationStandart()
            case 2:
                VibrationManager.instance.vibrationStandart()
            case 3:
                VibrationManager.instance.vibrationStandart()
            case 4:
                VibrationManager.instance.vibrationStandart()
            default:
                break
            }
        }
    }
}
