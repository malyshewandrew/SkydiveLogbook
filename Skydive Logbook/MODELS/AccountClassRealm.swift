import Foundation
import RealmSwift
import UIKit

class AccountClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var nickname = ""
    @Persisted var licenseType = ""
    @Persisted var licenseDate = ""
    @Persisted var medicine = ""
    @Persisted var insurance = ""
    @Persisted var reserveCanopy = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension AccountClassRealm {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "nickname": nickname,
            "licenseType": licenseType,
            "licenseDate": licenseDate,
            "medicine": medicine,
            "insurance": insurance,
            "reserveCanopy": reserveCanopy
        ]
    }

    convenience init(fromDictionary dictionary: [String: Any]) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        nickname = dictionary["nickname"] as? String ?? ""
        licenseType = dictionary["licenseType"] as? String ?? ""
        licenseDate = dictionary["licenseDate"] as? String ?? ""
        medicine = dictionary["medicine"] as? String ?? ""
        insurance = dictionary["insurance"] as? String ?? ""
        reserveCanopy = dictionary["reserveCanopy"] as? String ?? ""
    }
}
