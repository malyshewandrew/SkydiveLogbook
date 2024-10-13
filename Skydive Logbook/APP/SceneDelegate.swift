import CoreLocation
import RealmSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let realmManager = RealmManager()
    private let locationManager = CLLocationManager()

    // MARK: SCENE:

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // MARK: WINDOW:

        let window = UIWindow(windowScene: windowScene)

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

        let tabBarController = TabBarController()
        tabBarController.setViewControllers([mainNavigationController, statisticNavigationController, addNewJumpNavigationController, systemNavigationController, settingsNavigationController], animated: true)

        tabBarController.tabBar.backgroundColor = .colorTabBar
        tabBarController.tabBar.unselectedItemTintColor = .colorTabBarUnselected
        tabBarController.tabBar.tintColor = .colorTabBarSelected
        tabBarController.tabBar.layer.cornerRadius = 10

        // MARK: HELPERS:

        self.window = window
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        // MARK: LOAD REALM DATA:

        loadRealmData()

        // MARK: GET USER LOCATION:

        getUserLocation()
    }

    // MARK: - LOAD REALM DATA:

    private func loadRealmData() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map { $0 }
        arrayAccountRealm = realmManager.localRealm.objects(AccountClassRealm.self).map { $0 }
        arrayNotesRealm = realmManager.localRealm.objects(NoteClassRealm.self).map { $0 }
        arraySystemsRealm = realmManager.localRealm.objects(SystemClassRealm.self).map { $0 }
        arrayLocationsRealm = realmManager.localRealm.objects(LocationClassRealm.self).map { $0 }
        arrayAircraftsRealm = realmManager.localRealm.objects(AircraftClassRealm.self).map { $0 }
        arrayCanopiesRealm = realmManager.localRealm.objects(CanopyClassRealm.self).map { $0 }
    }

    // MARK: GET USER LOCATION:

    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - OTHERS:

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
