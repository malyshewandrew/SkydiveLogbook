import Foundation
import RealmSwift
import UIKit

class JumpClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var date = ""
    @Persisted var location = ""
    @Persisted var aircraft = ""
    @Persisted var canopy = ""
    @Persisted var mission = ""
    @Persisted var height = ""
    @Persisted var time = ""
    @Persisted var cutaway = ""
    @Persisted var comment = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension JumpClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "date": date,
            "location": location,
            "aircraft": aircraft,
            "canopy": canopy,
            "mission": mission,
            "height": height,
            "time": time,
            "cutaway": cutaway,
            "comment": comment
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        date = dictionary["date"] as? String ?? ""
        location = dictionary["location"] as? String ?? ""
        aircraft = dictionary["aircraft"] as? String ?? ""
        canopy = dictionary["canopy"] as? String ?? ""
        mission = dictionary["mission"] as? String ?? ""
        height = dictionary["height"] as? String ?? ""
        time = dictionary["time"] as? String ?? ""
        cutaway = dictionary["cutaway"] as? String ?? ""
        comment = dictionary["comment"] as? String ?? ""
    }
}
