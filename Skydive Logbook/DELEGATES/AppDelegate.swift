import Adapty
import FirebaseCore
import OneSignalFramework
import UIKit
import UserNotifications

@main

// MARK: - CLASS:

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let ONESIGNAL_APP_ID = "482028d6-faec-4939-94da-dcc51e0a465b"
    
    // MARK: - APPLICATION:
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // NOTIFICATIONS:
        requestNotificationPermission()
        
        UNUserNotificationCenter.current().delegate = self
        
        // ADAPTY:
        Adapty.activate("public_live_stgLOJHr.8tssVbeAirtHJYt1qgTE")
        
        // FIREBASE:
        FirebaseApp.configure()
    
        return true
    }

    // MARK: UI SCENE SESSION LIFECYCLE:

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // REQUEST NOTIFICATION PERMISSION:
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    self.oneSignalTurnOn()
                }
            } else {
                if let error = error {
                    print("Ошибка при запросе уведомлений: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // ONE SIGNAL:
    private func oneSignalTurnOn() {
        OneSignal.initialize(ONESIGNAL_APP_ID)
        OneSignal.Notifications.requestPermission({ accepted in
            print("Пользователь разрешил уведомления: \(accepted)")
        }, fallbackToSettings: true)
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
