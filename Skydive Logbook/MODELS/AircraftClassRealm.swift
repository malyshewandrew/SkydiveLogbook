import Foundation
import RealmSwift
import UIKit

class AircraftClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var aircraft = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension AircraftClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "aircraft": aircraft
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        aircraft = dictionary["aircraft"] as? String ?? ""
    }
}
