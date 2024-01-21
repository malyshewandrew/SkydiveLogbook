import Foundation
import RealmSwift
import UIKit

class LocationClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var location = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension LocationClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "location": location
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        location = dictionary["location"] as? String ?? ""
    }
}
