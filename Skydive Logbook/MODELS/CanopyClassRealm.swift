import Foundation
import RealmSwift
import UIKit

class CanopyClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var canopy = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension CanopyClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "canopy": canopy
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        canopy = dictionary["canopy"] as? String ?? ""
    }
}
