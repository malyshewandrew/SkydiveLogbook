import Foundation

// MARK: - ARRAY JUMPS:

var arrayJumps: [JumpStructure] = [
    JumpStructure(date: "03.08.1994", location: "Minsk", aircraft: "Mi-2", canopy: "Student-240", mission: NSLocalizedString("Video", comment: ""), height: "1200", time: "55", cutaway: NSLocalizedString("No", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "10.12.2022", location: "Orsha", aircraft: "Mi-2", canopy: "Malva-24", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "60", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Перехлест"),
    JumpStructure(date: "12.10.2021", location: "Minsk", aircraft: "TVS", canopy: "Magellan-150", mission: NSLocalizedString("AFF", comment: ""), height: "2200", time: "55", cutaway: NSLocalizedString("No", comment: ""), comment: "Перехлест"),
    JumpStructure(date: "23.01.2005", location: "Brest", aircraft: "Mi-2", canopy: "Student-240", mission: NSLocalizedString("Video", comment: ""), height: "1200", time: "50", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "15.01.2003", location: "Mogilev", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "60", cutaway: NSLocalizedString("No", comment: ""), comment: "Закрутка строп"),
    JumpStructure(date: "19.03.2021", location: "Vitebsk", aircraft: "TVS", canopy: "Malva-24", mission: NSLocalizedString("Group", comment: ""), height: "3500", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "07.01.1995", location: "Grodno", aircraft: "An-2", canopy: "Malva-26", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "40", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Перехлест"),
    JumpStructure(date: "02.09.2023", location: "Brest", aircraft: "TVS", canopy: "Magellan-150", mission: NSLocalizedString("Video", comment: ""), height: "1200", time: "45", cutaway: NSLocalizedString("No", comment: ""), comment: "Закрутка строп"),
    JumpStructure(date: "30.10.2022", location: "Gomel", aircraft: "Mi-2", canopy: "Malva-24", mission: NSLocalizedString("AFF", comment: ""), height: "4200", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "12.07.1998", location: "Minsk", aircraft: "An-2", canopy: "Malva-26", mission: NSLocalizedString("Tandem", comment: ""), height: "1200", time: "55", cutaway: NSLocalizedString("No", comment: ""), comment: "Перехлест"),
    JumpStructure(date: "30.09.2001", location: "Orsha", aircraft: "Mi-2", canopy: "Student-240", mission: NSLocalizedString("AFF", comment: ""), height: "900", time: "55", cutaway: NSLocalizedString("No", comment: ""), comment: "Закрутка строп"),
    JumpStructure(date: "22.02.2023", location: "Minsk", aircraft: "TVS", canopy: "Magellan-150", mission: NSLocalizedString("Video", comment: ""), height: "1200", time: "20", cutaway: NSLocalizedString("No", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "13.02.2020", location: "Orsha", aircraft: "Mi-2", canopy: "Malva-24", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Перехлест"),
    JumpStructure(date: "28.09.2023", location: "Vitebsk", aircraft: "TVS", canopy: "Student-240", mission: NSLocalizedString("Group", comment: ""), height: "2500", time: "10", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Закрутка строп"),
    JumpStructure(date: "21.11.2023", location: "Mogilev", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "3500", time: "15", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "16.12.2022", location: "Orsha", aircraft: "TVS", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1200", time: "15", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Закрутка строп"),
    JumpStructure(date: "11.11.2010", location: "Vitebsk", aircraft: "Mi-2", canopy: "Malva-24", mission: NSLocalizedString("Tandem", comment: ""), height: "3000", time: "55", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "10.01.2005", location: "Gomel", aircraft: "An-2", canopy: "Magellan-150", mission: NSLocalizedString("Group", comment: ""), height: "1000", time: "5", cutaway: NSLocalizedString("No", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "16.02.2001", location: "Minsk", aircraft: "TVS", canopy: "Student-240", mission: NSLocalizedString("Tandem", comment: ""), height: "1500", time: "5", cutaway: NSLocalizedString("No", comment: ""), comment: "Закрутка строп"),
    JumpStructure(date: "24.03.2015", location: "Brest", aircraft: "Mi-2", canopy: "Malva-24", mission: NSLocalizedString("AFF", comment: ""), height: "1200", time: "35", cutaway: NSLocalizedString("Yes", comment: ""), comment: "Самоотцеп"),
    JumpStructure(date: "17.10.2019", location: "Minsk", aircraft: "Mi-2", canopy: "Student-240", mission: NSLocalizedString("Video", comment: ""), height: "1500", time: "10", cutaway: NSLocalizedString("No", comment: ""), comment: "Перехлест")
]
