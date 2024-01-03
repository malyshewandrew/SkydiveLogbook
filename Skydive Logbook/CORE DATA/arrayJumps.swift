import Foundation

// MARK: - ARRAY JUMPS:

var arrayJumps: [JumpStructure] = [
    JumpStructure(date: "01.01.1994", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2005", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("AFF", comment: ""), height: "2000", time: "12", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "12.10.2023", location: "Skydive City", aircraft: "An-2", canopy: "Malva-260", mission: NSLocalizedString("Wingsuit", comment: ""), height: "4200", time: "2", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.1992", location: "Skydive City", aircraft: "An-2", canopy: "Student-240", mission: NSLocalizedString("Para-ski", comment: ""), height: "1100", time: "13", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2021", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "24", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.1991", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2005", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("AFF", comment: ""), height: "2000", time: "12", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "12.10.1987", location: "Skydive City", aircraft: "An-2", canopy: "Malva-260", mission: NSLocalizedString("Wingsuit", comment: ""), height: "4200", time: "2", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2003", location: "Skydive City", aircraft: "An-2", canopy: "Student-240", mission: NSLocalizedString("Para-ski", comment: ""), height: "1100", time: "13", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2020", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "24", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.1976", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.1999", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("AFF", comment: ""), height: "2000", time: "12", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "12.10.2002", location: "Skydive City", aircraft: "An-2", canopy: "Malva-260", mission: NSLocalizedString("Wingsuit", comment: ""), height: "4200", time: "2", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2023", location: "Skydive City", aircraft: "An-2", canopy: "Student-240", mission: NSLocalizedString("Para-ski", comment: ""), height: "1100", time: "13", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2024", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "24", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2994", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.1967", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("AFF", comment: ""), height: "2000", time: "12", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "12.10.1500", location: "Skydive City", aircraft: "An-2", canopy: "Malva-260", mission: NSLocalizedString("Wingsuit", comment: ""), height: "4200", time: "2", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.2007", location: "Skydive City", aircraft: "An-2", canopy: "Student-240", mission: NSLocalizedString("Para-ski", comment: ""), height: "1100", time: "13", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "01.01.1999", location: "Skydive City", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "24", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп")
]

