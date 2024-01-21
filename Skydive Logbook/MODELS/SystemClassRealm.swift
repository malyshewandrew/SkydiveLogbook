import Foundation
import RealmSwift

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

extension SystemClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "container": container?.toDictionary() ?? [:],
            "aad": aad?.toDictionary() ?? [:],
            "mainCanopy": mainCanopy?.toDictionary() ?? [:],
            "reserveCanopy": reserveCanopy?.toDictionary() ?? [:],
            "comment": comment
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        if let containerDictionary = dictionary["container"] as? [String: Any] {
            container = Container(fromDictionary: containerDictionary)
        }
        if let aadDictionary = dictionary["aad"] as? [String: Any] {
            aad = Aad(fromDictionary: aadDictionary)
        }
        if let mainCanopyDictionary = dictionary["mainCanopy"] as? [String: Any] {
            mainCanopy = MainCanopy(fromDictionary: mainCanopyDictionary)
        }
        if let reserveCanopyDictionary = dictionary["reserveCanopy"] as? [String: Any] {
            reserveCanopy = ReserveCanopy(fromDictionary: reserveCanopyDictionary)
        }
        comment = dictionary["comment"] as? String ?? ""
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

extension Container {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "dom": dom,
            "serialNumber": serialNumber,
            "serviceLifeYears": serviceLifeYears
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        dom = dictionary["dom"] as? String ?? ""
        serialNumber = dictionary["serialNumber"] as? String ?? ""
        serviceLifeYears = dictionary["serviceLifeYears"] as? String ?? ""
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

extension Aad {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "dom": dom,
            "serialNumber": serialNumber,
            "serviceLifeYears": serviceLifeYears
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        dom = dictionary["dom"] as? String ?? ""
        serialNumber = dictionary["serialNumber"] as? String ?? ""
        serviceLifeYears = dictionary["serviceLifeYears"] as? String ?? ""
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

extension MainCanopy {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "dom": dom,
            "serialNumber": serialNumber,
            "serviceLifeYears": serviceLifeYears,
            "serviceLifeJumps": serviceLifeJumps,
            "countJumps": countJumps
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        dom = dictionary["dom"] as? String ?? ""
        serialNumber = dictionary["serialNumber"] as? String ?? ""
        serviceLifeYears = dictionary["serviceLifeYears"] as? String ?? ""
        serviceLifeJumps = dictionary["serviceLifeJumps"] as? String ?? ""
        countJumps = dictionary["countJumps"] as? String ?? ""
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

extension ReserveCanopy {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "dom": dom,
            "serialNumber": serialNumber,
            "serviceLifeYears": serviceLifeYears,
            "countRepack": countRepack,
            "datePack": datePack
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        dom = dictionary["dom"] as? String ?? ""
        serialNumber = dictionary["serialNumber"] as? String ?? ""
        serviceLifeYears = dictionary["serviceLifeYears"] as? String ?? ""
        countRepack = dictionary["countRepack"] as? String ?? ""
        datePack = dictionary["datePack"] as? String ?? ""
    }
}
