import UIKit
import UserNotifications

final class NotificationManager {
    static let instance = NotificationManager()
    private init() {}
    
    // MARK: - SET MONTHLY NOTIFICATION:
    
    func setMonthlyNotification(arrayJumpsRealm: [JumpClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "monthlySwitch")
        if value {
            let content = UNMutableNotificationContent()
            let currentMonth = Calendar.current.component(.month, from: Date())
            let currentYear = Calendar.current.component(.year, from: Date())
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let jumpsCount = arrayJumpsRealm.reduce(0) { result, jump in
                guard let jumpDate = dateFormatter.date(from: jump.date) else { return result }
                let jumpMonth = Calendar.current.component(.month, from: jumpDate)
                let jumpYear = Calendar.current.component(.year, from: jumpDate)
                if jumpYear == currentYear, jumpMonth == currentMonth {
                    return result + 1
                }
                return result
            }
            content.title = "\(NSLocalizedString("Total jumps / notifications", comment: "")): \(arrayJumpsRealm.count)"
            content.body = "\(NSLocalizedString("In this month / notifications", comment: "")): \(jumpsCount)"
            content.sound = UNNotificationSound.default
            let currentDate = Date()
            let calendar = Calendar.current
            let lastDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.end
            if let lastDay = lastDayOfMonth {
                var components = calendar.dateComponents([.day, .hour, .minute], from: lastDay - 1)
                components.hour = 20
                components.minute = 0
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: "MonthlyNotification", content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
                print("Месячный отчет записан. Дата: \(trigger.dateComponents.description)")
            }
        } else {
            print("Switch сводки в конце месяца: выключен.")
        }
    }
    
    
    // MARK: REMOVE MONTHLY NOTIFICATION:
    
    func removeMonthlyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MonthlyNotification"])
        print("Месячный отчет удален.")
    }
    
    // MARK: - SET CONTAINER NOTIFICATION:
    
    func setContainerNotification(for systemClasses: [SystemClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "containerSwitch")
        if value {
            print("Switch ранца включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for systemClass in systemClasses {
                if let container = systemClass.container {
                    guard let manufacturingDate = dateFormatter.date(from: container.dom),
                          let serviceLife = Int(container.serviceLifeYears),
                          let expirationDate = Calendar.current.date(byAdding: .year, value: serviceLife, to: manufacturingDate)
                    else {
                        continue
                    }
                    guard let threeMonthsBeforeExpiration = Calendar.current.date(byAdding: .month, value: -3, to: expirationDate) else {
                        continue
                    }
                    let content = UNMutableNotificationContent()
                    content.title = "Ресурс ранца \(container.name)"
                    content.body = "Осталось 3 месяца"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: threeMonthsBeforeExpiration)
                    triggerDate.hour = 21
                    triggerDate.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "ContainerNotification\(container.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Ранец записан: \(container.name.description)")
                }
            }
        } else {
            print("Switch ранца выключен.")
        }
    }
    
    // MARK: REMOVE CONTAINER NOTIFICATION:
    
    func removeContainerNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let container = systemClass.container {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["ContainerNotification\(container.id)"])
                print("Ранец удален: \(container.name.description)")
            }
        }
    }
    
    // MARK: - SET AAD NOTIFICATION:
    
    func setAadNotification(for systemClasses: [SystemClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "aadSwitch")
        if value {
            print("Switch прибора включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for systemClass in systemClasses {
                if let aad = systemClass.aad {
                    guard let manufacturingDate = dateFormatter.date(from: aad.dom),
                          let serviceLife = Int(aad.serviceLifeYears),
                          let expirationDate = Calendar.current.date(byAdding: .year, value: serviceLife, to: manufacturingDate)
                    else {
                        continue
                    }
                    guard let threeMonthsBeforeExpiration = Calendar.current.date(byAdding: .month, value: -3, to: expirationDate) else {
                        continue
                    }
                    let content = UNMutableNotificationContent()
                    content.title = "Ресурс прибора"
                    content.body = "Осталось 3 месяца"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: threeMonthsBeforeExpiration)
                    triggerDate.hour = 21
                    triggerDate.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "AadNotification\(aad.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Прибор записан: \(aad.name)")
                }
            }
        } else {
            print("Switch прибора выключен.")
        }
    }
    
    // MARK: REMOVE AAD NOTIFICATION:
    
    func removeAadNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let aad = systemClass.aad {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["AadNotification\(aad.id)"])
                print("Прибор удален: \(aad.name)")
            }
        }
    }
    
    // MARK: - SET MAIN CANOPY RESOURSE NOTIFICATION:
    
    func setMainCanopyResourseNotification(for systemClasses: [SystemClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "mainCanopyResourseSwitch")
        if value {
            print("Switch основного по дате включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for systemClass in systemClasses {
                if let mainCanopy = systemClass.mainCanopy {
                    guard let manufacturingDate = dateFormatter.date(from: mainCanopy.dom),
                          let serviceLife = Int(mainCanopy.serviceLifeYears),
                          let expirationDate = Calendar.current.date(byAdding: .year, value: serviceLife, to: manufacturingDate)
                    else {
                        continue
                    }
                    guard let threeMonthsBeforeExpiration = Calendar.current.date(byAdding: .month, value: -3, to: expirationDate) else {
                        continue
                    }
                    let content = UNMutableNotificationContent()
                    content.title = "Ресурс основного"
                    content.body = "Осталось 3 месяца"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: threeMonthsBeforeExpiration)
                    triggerDate.hour = 21
                    triggerDate.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "MainCanopyResourseNotification\(mainCanopy.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Основной записан: \(mainCanopy.name)")
                }
            }
        } else {
            print("Switch основного по дате выключен.")
        }
    }
    
    // MARK: REMOVE MAIN CANOPY RESOURSE NOTIFICATION:
    
    func removeMainCanopyResourseNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let mainCanopy = systemClass.mainCanopy {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MainCanopyResourseNotification\(mainCanopy.id)"])
                print("Основной удален: \(mainCanopy.name)")
            }
        }
    }
    
    // MARK: - SET RESERVE CANOPY RESOURSE NOTIFICATION:
    
    func setReserveCanopyResourseNotification(for systemClasses: [SystemClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "reserveCanopyResourseSwitch")
        if value {
            print("Switch запасного по дате включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for systemClass in systemClasses {
                if let reserveCanopy = systemClass.reserveCanopy {
                    guard let manufacturingDate = dateFormatter.date(from: reserveCanopy.dom),
                          let serviceLife = Int(reserveCanopy.serviceLifeYears),
                          let expirationDate = Calendar.current.date(byAdding: .year, value: serviceLife, to: manufacturingDate)
                    else {
                        continue
                    }
                    guard let threeMonthsBeforeExpiration = Calendar.current.date(byAdding: .month, value: -3, to: expirationDate) else {
                        continue
                    }
                    let content = UNMutableNotificationContent()
                    content.title = "Ресурс запасного"
                    content.body = "Осталось 3 месяца"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: threeMonthsBeforeExpiration)
                    triggerDate.hour = 21
                    triggerDate.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "ReserveCanopyResourseNotification\(reserveCanopy.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Запаска записана: \(reserveCanopy.name)")
                }
            }
        } else {
            print("Switch запасного по дате выключен.")
        }
    }
    
    // MARK: REMOVE RESERVE CANOPY RESOURSE NOTIFICATION:
    
    func removeReserveCanopyResourseNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let reserveCanopy = systemClass.reserveCanopy {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["ReserveCanopyResourseNotification\(reserveCanopy.id)"])
                print("Запаска удалена: \(reserveCanopy.name)")
            }
        }
    }
    
    // MARK: - SET LICENSE NOTIFICATION:
    
    func setLicenseNotification(for accountClasses: [AccountClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "licenseSwitch")
        if value {
            print("Switch лицензии включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for account in accountClasses {
                if let licenseDate = dateFormatter.date(from: account.licenseDate) {
                    guard let oneMonthBeforeExpiration = Calendar.current.date(byAdding: .month, value: -1, to: licenseDate) else { return }
                    let content = UNMutableNotificationContent()
                    content.title = "Срок лицензии"
                    content.body = "Остался 1 месяц до истечения срока лицензии"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: oneMonthBeforeExpiration)
                    triggerDate.hour = 20
                    triggerDate.minute = 0
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "License\(account.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Лицензия записана: \(account.licenseDate)")
                }
            }
        } else {
            print("Switch лицензии выключен.")
        }
    }
    
    // MARK: REMOVE LICENSE NOTIFICATION:
    
    func removeLicenseNotification(for accountClasses: [AccountClassRealm]) {
        for account in accountClasses {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["License\(account.id)"])
            print("Лицензия удалена. \(account.id)")
        }
    }
    
    // MARK: - SET MEDICINE NOTIFICATION:
    
    func setMedicineNotification(for accountClasses: [AccountClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "medicineSwitch")
        if value {
            print("Switch медицины включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for account in accountClasses {
                if let licenseDate = dateFormatter.date(from: account.medicine) {
                    guard let oneMonthBeforeExpiration = Calendar.current.date(byAdding: .month, value: -1, to: licenseDate) else { return }
                    let content = UNMutableNotificationContent()
                    content.title = "Срок медицины"
                    content.body = "Остался 1 месяц до истечения срока медицины"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: oneMonthBeforeExpiration)
                    triggerDate.hour = 20
                    triggerDate.minute = 0
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "Medicine\(account.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Медицина записана: \(account.medicine)")
                }
            }
        } else {
            print("Switch медицины выключен.")
        }
    }
    
    // MARK: REMOVE MEDICINE NOTIFICATION:
    
    func removeMedicineNotification(for accountClasses: [AccountClassRealm]) {
        for account in accountClasses {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Medicine\(account.id)"])
            print("Медицина удалена. \(account.id)")
        }
    }
    
    // MARK: - SET INSURANCE NOTIFICATION:
    
    func setInsuranceNotification(for accountClasses: [AccountClassRealm]) {
        let value = UserDefaults.standard.bool(forKey: "insuranceSwitch")
        if value {
            print("Switch страховки включен.")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.yyyy"
            
            for account in accountClasses {
                if let licenseDate = dateFormatter.date(from: account.insurance) {
                    guard let oneMonthBeforeExpiration = Calendar.current.date(byAdding: .month, value: -1, to: licenseDate) else { return }
                    let content = UNMutableNotificationContent()
                    content.title = "Срок страховки"
                    content.body = "Остался 1 месяц до истечения срока страховки"
                    content.sound = UNNotificationSound.default
                    var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: oneMonthBeforeExpiration)
                    triggerDate.hour = 20
                    triggerDate.minute = 0
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let request = UNNotificationRequest(identifier: "Insurance\(account.id)", content: content, trigger: trigger)
                    let center = UNUserNotificationCenter.current()
                    center.add(request, withCompletionHandler: nil)
                    print("Страховка записана: \(account.insurance)")
                }
            }
        } else {
            print("Switch страховки выключен.")
        }
    }
    
    // MARK: REMOVE INSURANCE NOTIFICATION:
    
    func removeInsuranceNotification(for accountClasses: [AccountClassRealm]) {
        for account in accountClasses {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Insurance\(account.id)"])
            print("Страховка удалена. \(account.id)")
        }
    }
}
// MARK: - EXTENSION:

extension NotificationManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
