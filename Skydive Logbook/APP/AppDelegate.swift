import Adapty
import FirebaseCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: ADAPTY:
        
        Adapty.activate("public_live_stgLOJHr.8tssVbeAirtHJYt1qgTE")
        
        // MARK: FIREBASE:
        
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UI SCENE SESSION LIFECYCLE:

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
