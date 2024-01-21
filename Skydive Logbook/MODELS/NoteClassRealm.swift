import Foundation
import RealmSwift
import UIKit

class NoteClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var note = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension NoteClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "note": note
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        note = dictionary["note"] as? String ?? ""
    }
}
