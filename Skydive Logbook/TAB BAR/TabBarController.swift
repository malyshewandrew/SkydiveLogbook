import SwiftUI
import UIKit

// MARK: - CLASS:

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: PRIVATE PROPERTIES:

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        // MARK: TAB BAR ITEMS:

        let mainViewController = MainVC()
        mainViewController.title = NSLocalizedString("Main tab bar", comment: "")
        mainViewController.tabBarItem.image = UIImage(systemName: "house.fill")

        let statisticViewController = StatisticVC()
        statisticViewController.title = NSLocalizedString("Statistic tab bar", comment: "")
        statisticViewController.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard.fill")

        let addNewJumpViewController = NewJumpVC()
        addNewJumpViewController.title = NSLocalizedString("Add jump tab bar", comment: "")
        addNewJumpViewController.tabBarItem.image = UIImage(systemName: "plus.rectangle.portrait.fill")

        let systemViewController = SystemVC()
        systemViewController.title = NSLocalizedString("System tab bar", comment: "")
        systemViewController.tabBarItem.image = UIImage(systemName: "backpack.fill")

        let settingsViewController = SettingsVC()
        settingsViewController.title = NSLocalizedString("Settings tab bar", comment: "")
        settingsViewController.tabBarItem.image = UIImage(systemName: "gearshape.fill")

        // MARK: NAVIGATION BAR ITEMS:

        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        let statisticNavigationController = UINavigationController(rootViewController: statisticViewController)
        let addNewJumpNavigationController = UINavigationController(rootViewController: addNewJumpViewController)
        let systemNavigationController = UINavigationController(rootViewController: systemViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        // MARK: TAB BAR UI CONFIGURATE:

        setViewControllers([mainNavigationController, statisticNavigationController, addNewJumpNavigationController, systemNavigationController, settingsNavigationController], animated: true)
        tabBar.backgroundColor = .colorTabBar
        tabBar.unselectedItemTintColor = .colorTabBarUnselected
        tabBar.tintColor = .colorTabBarSelected
        tabBar.layer.cornerRadius = 10
    }

    // MARK: FUNC FOR ACTION WHERE TAP ON ITEM:

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            switch selectedIndex {
            case 0, 1, 2, 3, 4:
                VibrationManager.instance.vibrationStandart()
            default:
                break
            }
        }
    }
}
