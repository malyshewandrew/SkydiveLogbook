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
