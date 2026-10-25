import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()

    let localRealm: Realm

    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Container.className()) { _, newObject in
                        newObject?["id"] = UUID().uuidString
                    }
                    migration.enumerateObjects(ofType: Aad.className()) { _, newObject in
                        newObject?["id"] = UUID().uuidString
                    }
                    migration.enumerateObjects(ofType: MainCanopy.className()) { _, newObject in
                        newObject?["id"] = UUID().uuidString
                    }
                    migration.enumerateObjects(ofType: ReserveCanopy.className()) { _, newObject in
                        newObject?["id"] = UUID().uuidString
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config

        do {
            self.localRealm = try Realm(configuration: config)
        } catch {
            fatalError("Realm initialization failed: \(error)")
        }
    }
}
