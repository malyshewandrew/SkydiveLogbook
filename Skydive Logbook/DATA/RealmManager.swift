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
                    migration.enumerateObjects(ofType: Container.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString
                    }
                    migration.enumerateObjects(ofType: Aad.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString
                    }
                    migration.enumerateObjects(ofType: MainCanopy.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString
                    }
                    migration.enumerateObjects(ofType: ReserveCanopy.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString
                    }
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config

        self.localRealm = try! Realm(configuration: config)
    }
}
