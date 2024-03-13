import SwiftUI
import UIKit

// MARK: - CLASS:

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: PRIVATE PROPERTIES:

    private let vibrationOn = Vibration()

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    // MARK: FUNC FOR ACTION WHERE TAP ON ITEM:

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            switch selectedIndex {
            case 0:
                vibrationOn.vibrationStandart()
            case 1:
                vibrationOn.vibrationStandart()
            case 2:
                vibrationOn.vibrationStandart()
            case 3:
                vibrationOn.vibrationStandart()
            case 4:
                vibrationOn.vibrationStandart()
            default:
                break
            }
        }
    }
}
