import Foundation
import RealmSwift
import UIKit

class JumpClassRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var date = ""
    @Persisted var location = ""
    @Persisted var aircraft = ""
    @Persisted var canopy = ""
    @Persisted var mission: Mission?
    @Persisted var height = ""
    @Persisted var time = ""
    @Persisted var cutaway: Cutaway?
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
            "mission": mission?.rawValue ?? "",
            "height": height,
            "time": time,
            "cutaway": cutaway?.rawValue ?? "",
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
        let missionString = dictionary["mission"] as? String ?? ""
        mission = Mission(rawValue: missionString)
        height = dictionary["height"] as? String ?? ""
        time = dictionary["time"] as? String ?? ""
        let cutawayString = dictionary["cutaway"] as? String ?? ""
        cutaway = Cutaway(rawValue: cutawayString)
        comment = dictionary["comment"] as? String ?? ""
    }
}


enum Mission: String, PersistableEnum {
    case Accuracy
    case Acrobatics
    case AFF
    case Base
    case BaseWingsuit
    case CanopyFormation
    case Freefly
    case Freestyle
    case Fun
    case Group
    case Instructor
    case Military
    case ParaSki
    case Proximity
    case Skysurfing
    case StaticLine
    case Piloting
    case Tandem
    case Vertical
    case Video
    case Wingsuit
    case Formation
    
    var localizedValue: String {
        switch self {
        case .Accuracy:
            return NSLocalizedString("Accuracy", comment: "")
        case .Acrobatics:
            return NSLocalizedString("Acrobatics", comment: "")
        case .AFF:
            return NSLocalizedString("AFF", comment: "")
        case .Base:
            return NSLocalizedString("Base", comment: "")
        case .BaseWingsuit:
            return NSLocalizedString("Base/Wingsuit", comment: "")
        case .CanopyFormation:
            return NSLocalizedString("Canopy formation", comment: "")
        case .Freefly:
            return NSLocalizedString("Freefly", comment: "")
        case .Freestyle:
            return NSLocalizedString("Freestyle", comment: "")
        case .Fun:
            return NSLocalizedString("Fun", comment: "")
        case .Group:
            return NSLocalizedString("Group", comment: "")
        case .Instructor:
            return NSLocalizedString("Instructor", comment: "")
        case .Military:
            return NSLocalizedString("Military", comment: "")
        case .ParaSki:
            return NSLocalizedString("Para-ski", comment: "")
        case .Proximity:
            return NSLocalizedString("Proximity", comment: "")
        case .Skysurfing:
            return NSLocalizedString("Skysurfing", comment: "")
        case .StaticLine:
            return NSLocalizedString("Static-line", comment: "")
        case .Piloting:
            return NSLocalizedString("Piloting", comment: "")
        case .Tandem:
            return NSLocalizedString("Tandem", comment: "")
        case .Vertical:
            return NSLocalizedString("Vertical", comment: "")
        case .Video:
            return NSLocalizedString("Video", comment: "")
        case .Wingsuit:
            return NSLocalizedString("Wingsuit", comment: "")
        case .Formation:
            return NSLocalizedString("Formation", comment: "")
        }
    }
}

enum Cutaway: String, PersistableEnum {
    case Yes
    case No
    
    var localizedValue: String {
        switch self {
        case .Yes:
            return NSLocalizedString("Yes", comment: "")
        case .No:
            return NSLocalizedString("No", comment: "")
        }
    }
}
