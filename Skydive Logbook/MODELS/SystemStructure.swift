import Foundation

struct SystemStructure {
    let name: String
    let container: Container
    let aad: Aad
    let mainCanopy: MainCanopy
    let reserveCanopy: ReserveCanopy
    let comment: String
}

struct Container {
    let name: String
    let dom: String
    let serialNumber: String
    let serviceLifeYears: String
}

struct Aad {
    let name: String
    let dom: String
    let serialNumber: String
    let serviceLifeYears: String
}

struct MainCanopy {
    let name: String
    let dom: String
    let serialNumber: String
    let serviceLifeYears: String
    let serviceLifeJumps: String
    let countJumps: String
    
}

struct ReserveCanopy {
    let name: String
    let dom: String
    let serialNumber: String
    let serviceLifeYears: String
    let countRepack: String
    let datePack: String
}
