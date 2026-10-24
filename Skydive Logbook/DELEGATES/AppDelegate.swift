import Adapty
import AdaptyUI
//import FirebaseCore
import UIKit
import UserNotifications

@main

// MARK: - CLASS:

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - APPLICATION:
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        // ADAPTY:
        Adapty.activate("public_live_stgLOJHr.8tssVbeAirtHJYt1qgTE")
        AdaptyUI.activate()
        
        // FIREBASE:
//        FirebaseApp.configure()
    
        return true
    }

    // MARK: UI SCENE SESSION LIFECYCLE:

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

// MARK: - EXTENSION:
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
