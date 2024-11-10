import SwiftUI
import UIKit

// MARK: - CLASS:

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: PRIVATE PROPERTIES:

    private let mainViewController = MainVC()
    private let statisticViewController = StatisticVC()
    private let addNewJumpViewController = NewJumpVC()
    private let systemViewController = SystemVC()
    private let settingsViewController = SettingsVC()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureItems()
        configureNavigation()
        configureUI()
    }

    // MARK: - CONFIGURE ITEMS:

    private func configureItems() {
        setupTabBarItemSettings(viewController: mainViewController, title: "Main tab bar", image: "house.fill")
        setupTabBarItemSettings(viewController: statisticViewController, title: "Statistic tab bar", image: "list.bullet.clipboard.fill")
        setupTabBarItemSettings(viewController: addNewJumpViewController, title: "Add jump tab bar", image: "plus.rectangle.portrait.fill")
        setupTabBarItemSettings(viewController: systemViewController, title: "System tab bar", image: "backpack.fill")
        setupTabBarItemSettings(viewController: settingsViewController, title: "Settings tab bar", image: "gearshape.fill")
    }

    // MARK: - CONFIGURE NAVIGATION:

    private func configureNavigation() {
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        let statisticNavigationController = UINavigationController(rootViewController: statisticViewController)
        let addNewJumpNavigationController = UINavigationController(rootViewController: addNewJumpViewController)
        let systemNavigationController = UINavigationController(rootViewController: systemViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        setViewControllers([mainNavigationController, statisticNavigationController, addNewJumpNavigationController, systemNavigationController, settingsNavigationController], animated: true)
    }

    // MARK: - CONFIGURE TAB BAR UI:

    private func configureUI() {
        tabBar.backgroundColor = .colorTabBar
        tabBar.unselectedItemTintColor = .colorTabBarUnselected
        tabBar.tintColor = .colorTabBarSelected
        tabBar.layer.cornerRadius = 10
    }

    // MARK: - HELPERS:

    // MARK: SETUP SETTINGS FOR TAB BAR ITEMS:

    private func setupTabBarItemSettings(viewController: UIViewController, title: String, image: String) {
        viewController.tabBarItem.title = NSLocalizedString(title, comment: "")
        viewController.tabBarItem.image = UIImage(systemName: image)
    }
}

// MARK: - EXTENSIONS:

extension TabBarController {
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
