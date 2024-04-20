import UIKit
import UserNotifications

final class NotificationManager {
    static let instance = NotificationManager()
    private init() {}

    // MARK: - SET MONTHLY NOTIFICATION:
    
    func setMonthlyNotification(arrayJumpsRealm: [JumpClassRealm]) {
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
        
        content.title = "Всего прыжков: \(arrayJumpsRealm.count)"
        content.body = "В этом месяце: \(jumpsCount)"
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
        }
    }

    // MARK: REMOVE MONTHLY NOTIFICATION:
    
    func removeMonthlyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MonthlyNotification"])
    }
    
    // MARK: - SET CONTAINER NOTIFICATION:

    func setContainerNotifications(for systemClasses: [SystemClassRealm]) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.yyyy"
            return formatter
        }()
        
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
                content.title = "Ресурс ранца"
                content.body = "Осталось 3 месяца"
                content.sound = UNNotificationSound.default
                
                var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: threeMonthsBeforeExpiration)
                triggerDate.hour = 21
                triggerDate.minute = 00
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                
                let request = UNNotificationRequest(identifier: "ContainerNotification\(container.id)", content: content, trigger: trigger)
                
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
            }
        }
    }

    // MARK: REMOVE CONTAINER NOTIFICATION:
    
    func removeContainerNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let container = systemClass.container {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["ContainerNotification\(container.id)"])
            }
        }
    }
    
    // MARK: - SET AAD NOTIFICATION:

    func setAadNotifications(for systemClasses: [SystemClassRealm]) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.yyyy"
            return formatter
        }()
        
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
            }
        }
    }

    // MARK: REMOVE AAD NOTIFICATION:
    
    func removeAadNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let aad = systemClass.aad {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["AadNotification\(aad.id)"])
            }
        }
    }
    
    // MARK: - SET MAIN CANOPY RESOURSE NOTIFICATION:

    func setMainCanopyResourseNotifications(for systemClasses: [SystemClassRealm]) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.yyyy"
            return formatter
        }()
        
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
            }
        }
    }

    // MARK: REMOVE MAIN CANOPY RESOURSE NOTIFICATION:
    
    func removeMainCanopyResourseNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let mainCanopy = systemClass.mainCanopy {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["MainCanopyResourseNotification\(mainCanopy.id)"])
            }
        }
    }
    
    // MARK: - SET RESERVE CANOPY RESOURSE NOTIFICATION:

    func setReserveCanopyResourseNotifications(for systemClasses: [SystemClassRealm]) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.yyyy"
            return formatter
        }()
        
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
            }
        }
    }

    // MARK: REMOVE RESERVE CANOPY RESOURSE NOTIFICATION:
    
    func removeReserveCanopyResourseNotification(for systemClasses: [SystemClassRealm]) {
        for systemClass in systemClasses {
            if let reserveCanopy = systemClass.reserveCanopy {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["ReserveCanopyResourseNotification\(reserveCanopy.id)"])
            }
        }
    }
    
    // MARK: - SET LICENCE NOTIFICATION:

    func setLicenceNotifications(for accountClasses: [AccountClassRealm]) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter
        }()
        
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
                
                let request = UNNotificationRequest(identifier: "Licence\(account.id)", content: content, trigger: trigger)
                
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: nil)
                print(oneMonthBeforeExpiration)
                print(request)
                print(triggerDate)
            }
        }
    }

    // MARK: REMOVE LICENCE NOTIFICATION:
    
    func removeLicenceNotification(for accountClasses: [AccountClassRealm]) {
        for account in accountClasses {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Licence\(account.id)"])
        }
    }
  
}

// MARK: - EXTENSION:

extension NotificationManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
