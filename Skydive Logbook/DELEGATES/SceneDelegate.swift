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

        let window = UIWindow(windowScene: windowScene)
        let loadViewController = LoadViewController()

        self.window = window
        window.rootViewController = loadViewController
        window.makeKeyAndVisible()

        // OAD REALM DATA:
        loadRealmData()

        // GET USER LOCATION:
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
