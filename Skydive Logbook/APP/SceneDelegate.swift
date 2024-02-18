import RealmSwift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var realmManager = RealmManager()
    
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

        // MARK: ROOT:

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([mainNavigationController, statisticNavigationController, addNewJumpNavigationController, systemNavigationController, settingsNavigationController], animated: true)

        // MARK: TAB BAR UI CONFIGURATE:

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
    }

    // MARK: - LOAD REALM DATA:

    private func loadRealmData() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map {
            $0
        }
        arrayAccountRealm = realmManager.localRealm.objects(AccountClassRealm.self).map {
            $0
        }
        arrayNotesRealm = realmManager.localRealm.objects(NoteClassRealm.self).map {
            $0
        }
        arraySystemsRealm = realmManager.localRealm.objects(SystemClassRealm.self).map {
            $0
        }
        arrayLocationsRealm = realmManager.localRealm.objects(LocationClassRealm.self).map {
            $0
        }
        arrayAircraftsRealm = realmManager.localRealm.objects(AircraftClassRealm.self).map {
            $0
        }
        arrayCanopiesRealm = realmManager.localRealm.objects(CanopyClassRealm.self).map {
            $0
        }
    }
    
    // MARK: - OTHERS:

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
