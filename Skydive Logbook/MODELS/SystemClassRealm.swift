import Foundation
import RealmSwift
import UIKit

class SystemClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var container: Container?
    @Persisted var aad: Aad?
    @Persisted var mainCanopy: MainCanopy?
    @Persisted var reserveCanopy: ReserveCanopy?
    @Persisted var comment: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

class Container: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var dom: String = ""
    @Persisted var serialNumber: String = ""
    @Persisted var serviceLifeYears: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

class Aad: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var dom: String = ""
    @Persisted var serialNumber: String = ""
    @Persisted var serviceLifeYears: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

class MainCanopy: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var dom: String = ""
    @Persisted var serialNumber: String = ""
    @Persisted var serviceLifeYears: String = ""
    @Persisted var serviceLifeJumps: String = ""
    @Persisted var countJumps: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

class ReserveCanopy: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var dom: String = ""
    @Persisted var serialNumber: String = ""
    @Persisted var serviceLifeYears: String = ""
    @Persisted var countRepack: String = ""
    @Persisted var datePack: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}
