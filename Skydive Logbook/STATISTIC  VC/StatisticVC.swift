import Lottie
import UIKit
import RealmSwift

final class StatisticVC: UIViewController {
    // MARK: - PROPERTIES:

    private let statisticLottie = LottieAnimationView(name: "Statistic")
    private let confettiLottie = LottieAnimationView(name: "StatisticConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let tableView = UITableView()
    private let dateFormatter = DateFormatter()
    
    let realmManager = RealmManager()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        loadJumps()
        configureGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadJumps()
        tableView.reloadData()
    }

    // MARK: - ADD SUBVIEWS::

    private func addSubviews() {
        view.addSubviews(confettiLottie, tableView, statisticLottie, confettiButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION STATISTIC LOTTIE:

        statisticLottie.translatesAutoresizingMaskIntoConstraints = false
        statisticLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statisticLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        statisticLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        statisticLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: statisticLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: statisticLottie.centerYAnchor).isActive = true
        confettiLottie.heightAnchor.constraint(equalToConstant: 300).isActive = true
        confettiLottie.widthAnchor.constraint(equalToConstant: 300).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: statisticLottie.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true

        // MARK: ANIMATIONS:

        statisticLottie.play()
        statisticLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        // MARK: TABLE VIEW:

        tableView.backgroundColor = .colorBackground
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatisticCell.self, forCellReuseIdentifier: "CellStatistic")
        tableView.reloadData()
    }
    
    // MARK: - LOAD JUMPS FROM REALM:
    
    private func loadJumps() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map({
            $0 })
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnConfettiButton))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func tapOnConfettiButton() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension StatisticVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellStatistic", for: indexPath) as? StatisticCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
}

// MARK: - EXTENSION FOR DLEGATES:

extension StatisticVC: StatisticCellDelegate {
    // MARK: GENERAL INFO:

    func tapGeneralInfoButton() {
        var sumTime = 0
        for jump in arrayJumpsRealm {
            sumTime += Int(jump.time) ?? 0
        }

        var timeMessage = ""
        switch sumTime {
        case 0...1:
            timeMessage = NSLocalizedString("Case 0-1", comment: "")
        case 1...150:
            timeMessage = NSLocalizedString("1-150", comment: "")
        case 150...300:
            timeMessage = NSLocalizedString("150-300", comment: "")
        case 300...600:
            timeMessage = NSLocalizedString("300-600", comment: "")
        case 600...900:
            timeMessage = NSLocalizedString("600-900", comment: "")
        case 900...1000:
            timeMessage = NSLocalizedString("900-1000", comment: "")
        case 1000...1200:
            timeMessage = NSLocalizedString("1000-1200", comment: "")
        case 1200...1500:
            timeMessage = NSLocalizedString("1200-1500", comment: "")
        case 1500...2500:
            timeMessage = NSLocalizedString("1500-2500", comment: "")
        case 2500...3000:
            timeMessage = NSLocalizedString("2500-3000", comment: "")
        case 3000...3500:
            timeMessage = NSLocalizedString("3000-3500", comment: "")
        case 3500...5000:
            timeMessage = NSLocalizedString("3500-5000", comment: "")
        case 5000...6000:
            timeMessage = NSLocalizedString("5000-6000", comment: "")
        case 6000...8000:
            timeMessage = NSLocalizedString("6000-8000", comment: "")
        case 8000...10000:
            timeMessage = NSLocalizedString("8000-10000", comment: "")
        case 10000...13000:
            timeMessage = NSLocalizedString("10000-13000", comment: "")
        case 13000...17000:
            timeMessage = NSLocalizedString("13000-17000", comment: "")
        case 17000...20000:
            timeMessage = NSLocalizedString("17000-20000", comment: "")
        case 20000...25000:
            timeMessage = NSLocalizedString("20000-25000", comment: "")
        case 25000...30000:
            timeMessage = NSLocalizedString("25000-30000", comment: "")
        case 35000...40000:
            timeMessage = NSLocalizedString("35000-40000", comment: "")
        case 40000...50000:
            timeMessage = NSLocalizedString("40000-50000", comment: "")
        case 50000...100000:
            timeMessage = NSLocalizedString("50000-100000", comment: "")
        case 100000...:
            timeMessage = NSLocalizedString("100000-...", comment: "")
        default:
            timeMessage = NSLocalizedString("Default-Default", comment: "")
        }

        var sumHeight = 0
        for jump in arrayJumpsRealm {
            sumHeight += Int(jump.height) ?? 0
        }
        var heightMessage = "Придумать"
        switch sumHeight {
        case 0...1:
            heightMessage = ""
        case 0...150:
            heightMessage = "Придумать"
        case 150...300:
            heightMessage = "Придумать"
        default:
            heightMessage = "Придумать"
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = """
            \n\(NSLocalizedString("Total height", comment: "")): \(sumHeight) \(NSLocalizedString("m.", comment: ""))
            \(heightMessage)\n
            \n\(NSLocalizedString("Free fall time", comment: "")): \(sumTime) \(NSLocalizedString("s.", comment: ""))
            \(timeMessage)\n
            """
        }

        let alert = UIAlertController(title: NSLocalizedString("General info", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: TOTAL JUMPS:

    func tapTotalButton() {
        let contentView = UIView()
        let imageLottie = LottieAnimationView(name: "Total")

        let alert = UIAlertController(title: NSLocalizedString("saving data", comment: "") + ":", message: "\n\n\n\n\n\n \(NSLocalizedString("saving data text", comment: ""))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20

        alert.view.addSubviews(contentView, imageLottie)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: alert.view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -45).isActive = true
        contentView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor).isActive = true
        contentView.backgroundColor = .clear
        contentView.layer.shadowRadius = 50
        contentView.layer.shadowColor = UIColor.colorWhite.cgColor
        contentView.layer.shadowOpacity = 1

        imageLottie.translatesAutoresizingMaskIntoConstraints = false
        imageLottie.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        imageLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageLottie.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageLottie.play()
        imageLottie.loopMode = .loop

        present(alert, animated: true)
    }

    // MARK: JUMPS YEAR:

    func tapYearButton() {
        var arrayYears: [String] = []

        for jump in arrayJumpsRealm {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let date = dateFormatter.date(from: jump.date) {
                dateFormatter.dateFormat = "yyyy"
                let yearString = dateFormatter.string(from: date)
                arrayYears.append(yearString)
            }
        }

        var yearsCount: [String: Int] = [:]

        for year in arrayYears {
            if let count = yearsCount[year] {
                yearsCount[year] = count + 1
            } else {
                yearsCount[year] = 1
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = NSLocalizedString("no jumps", comment: "")
        } else {
            for (year, count) in yearsCount.sorted(by: { $0 > $1 }) {
                message += "\(year) \(NSLocalizedString("year", comment: "")): \(count)\n"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("jumps by year", comment: "") + ":",
                                      message: """
                                      \n\(message)
                                      """,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: CATEGORIES:

    func tapCategoryButton() {
        let alert = UIAlertController(title: NSLocalizedString("Categories USPA", comment: "") + ":",
                                      message: NSLocalizedString("Categories USPA List", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: MAX HEIGHT:

    func tapMaxHeightButton() {
        var maxJumpHeight = 0
        var maxHeightDate = ""

        for jump in arrayJumpsRealm {
            if let height = Int(jump.height), height > maxJumpHeight {
                maxJumpHeight = height
                maxHeightDate = jump.date
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Maximum height alert", comment: "")): \(maxHeightDate)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Maximum height", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: AVERAGE HEIGHT:

    func tapAverageHeightButton() {
        var sumAverageHeight = 0
        for jump in arrayJumpsRealm {
            sumAverageHeight += Int(jump.height) ?? 0
        }

        var averageHeight = 0
        if arrayJumpsRealm.count == 0 {
            averageHeight = 0
        } else {
            averageHeight = sumAverageHeight / arrayJumpsRealm.count
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Average height of jump", comment: "")): \(averageHeight) \(NSLocalizedString("m.", comment: ""))"
        }

        let alert = UIAlertController(title: NSLocalizedString("Average height", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: MIN HEIGHT:

    func tapMinHeightButton() {
        var minJumpHeight = Int.max
        var minHeightDate = ""

        for jump in arrayJumpsRealm {
            if let height = Int(jump.height), height < minJumpHeight {
                minJumpHeight = height
                minHeightDate = jump.date
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Minimum height alert", comment: "")): \(minHeightDate)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Minimum height", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: DATE FIRST:

    func tapDateFirstButton() {
        if arrayJumpsRealm.count == 0 {
            let alert = UIAlertController(title: NSLocalizedString("Date first jump", comment: "") + ":",
                                          message: "\n" + NSLocalizedString("no jumps", comment: ""),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alert.view.backgroundColor = .black
            alert.view.layer.masksToBounds = true
            alert.view.layer.cornerRadius = 20
            present(alert, animated: true)
        } else {
            let currentDate = Date()

            dateFormatter.dateFormat = "dd.MM.yyyy"

            if let jumpDateString = arrayJumpsRealm.first?.date, let jumpDate = dateFormatter.date(from: jumpDateString) {
                let userCalendar = Calendar.current
                let dayMonthYearPassed = userCalendar.dateComponents([.day, .month, .year], from: jumpDate, to: currentDate)

                guard let year = dayMonthYearPassed.year,
                      let month = dayMonthYearPassed.month,
                      let day = dayMonthYearPassed.day else { return }

                var message = ""
                if arrayJumpsRealm.count == 0 {
                    message = "\n" + NSLocalizedString("no jumps", comment: "")
                } else {
                    message = "\n\(year) \(NSLocalizedString("y.", comment: "")) \(month) \(NSLocalizedString("mon.", comment: "")) \(day) \(NSLocalizedString("d.", comment: "")) \(NSLocalizedString("ago", comment: ""))"
                }

                let alert = UIAlertController(title: NSLocalizedString("Date first jump", comment: "") + ":",
                                              message: message,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
                alert.view.backgroundColor = .black
                alert.view.layer.masksToBounds = true
                alert.view.layer.cornerRadius = 20
                present(alert, animated: true)
            }
        }
    }

    // MARK: MAX TIME:

    func tapMaxTimeButton() {
        var maxJumpHeight = 0
        var maxTimeDate = ""

        for jump in arrayJumpsRealm {
            if let height = Int(jump.time), height > maxJumpHeight {
                maxJumpHeight = height
                maxTimeDate = jump.date
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Maximum time alert", comment: "")): \(maxTimeDate)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Maximum time", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: DATE LAST:

    func tapDateLastButton() {
        if arrayJumpsRealm.count == 0 {
            let alert = UIAlertController(title: NSLocalizedString("Date last jump", comment: "") + ":",
                                          message: "\n" + NSLocalizedString("no jumps", comment: ""),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alert.view.backgroundColor = .black
            alert.view.layer.masksToBounds = true
            alert.view.layer.cornerRadius = 20
            present(alert, animated: true)
        } else {
            let currentDate = Date()
            dateFormatter.dateFormat = "dd.MM.yyyy"

            if let jumpDateString = arrayJumpsRealm.last?.date, let jumpDate = dateFormatter.date(from: jumpDateString) {
                let userCalendar = Calendar.current
                let dayMonthYearPassed = userCalendar.dateComponents([.day, .month, .year], from: jumpDate, to: currentDate)

                guard let year = dayMonthYearPassed.year,
                      let month = dayMonthYearPassed.month,
                      let day = dayMonthYearPassed.day else { return }

                let alert = UIAlertController(title: NSLocalizedString("Date last jump", comment: "") + ":",
                                              message: """
                                              \n\(year) \(NSLocalizedString("y.", comment: "")) \(month) \(NSLocalizedString("mon.", comment: "")) \(day) \(NSLocalizedString("d.", comment: "")) \(NSLocalizedString("ago", comment: ""))
                                              """,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
                alert.view.backgroundColor = .black
                alert.view.layer.masksToBounds = true
                alert.view.layer.cornerRadius = 20
                present(alert, animated: true)
            }
        }
    }

    // MARK: MAX DAY:

    func tapMaxDayButton() {
        var jumpsMaxDay: [String: Int] = [:]
        var dayWithMostJumps = ""

        for jump in arrayJumpsRealm {
            if let count = jumpsMaxDay[jump.date] {
                jumpsMaxDay[jump.date] = count + 1
            } else {
                jumpsMaxDay[jump.date] = 1
            }
        }

        if let maxDay = jumpsMaxDay.max(by: { $0.value < $1.value }) {
            dayWithMostJumps = maxDay.key
        } else {
            dayWithMostJumps = ""
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Max count of jumps text", comment: "")): \(dayWithMostJumps)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Max in one day", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: AVERAGE TIME:

    func tapAverageTimeButton() {
        var sumAverageTime = 0
        for jump in arrayJumpsRealm {
            sumAverageTime += Int(jump.time) ?? 0
        }

        var averageTime = 0
        if arrayJumpsRealm.count == 0 {
            averageTime = 0
        } else {
            averageTime = sumAverageTime / arrayJumpsRealm.count
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = " \n\(NSLocalizedString("Average free fall time of jump", comment: "")): \(averageTime) \(NSLocalizedString("s.", comment: ""))"
        }

        let alert = UIAlertController(title: NSLocalizedString("Average time", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: CUTAWAY:

    func tapCountCutawayButton() {
        var countCutaway = 0
        var dataWithCutawayYes: [(date: String, comment: String)] = []

        for jump in arrayJumpsRealm {
            if jump.cutaway?.localizedValue == NSLocalizedString("Yes", comment: "") {
                countCutaway += 1
                let jumpData = (date: jump.date, comment: jump.comment)
                dataWithCutawayYes.append(jumpData)
            }
        }

        let resultString = dataWithCutawayYes.map { "\($0.date)\n\($0.comment)" }.joined(separator: "\n\n")

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Count cutaway", comment: "")): \(countCutaway)\n\n\(resultString)"
        }

        let alert = UIAlertController(title: NSLocalizedString("CutawayStatistic", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: AIRCRAFTS:

    func tapAircraftsButton() {
        var arrayAircrafts: [String] = []
        for jump in arrayJumpsRealm {
            arrayAircrafts.append(jump.aircraft)
        }

        var aircraftCount: [String: Int] = [:]

        for aircraft in arrayAircrafts {
            if let count = aircraftCount[aircraft] {
                aircraftCount[aircraft] = count + 1
            } else {
                aircraftCount[aircraft] = 1
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            for (aircraft, count) in aircraftCount.sorted(by: { $0.value > $1.value }) {
                message += "\n\(aircraft): \(count)\n"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("List aircrafts", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: CANOPIES:

    func tapCanopiesButton() {
        var arrayCanopies: [String] = []
        for jump in arrayJumpsRealm {
            arrayCanopies.append(jump.canopy)
        }

        var canopyCount: [String: Int] = [:]

        for canopy in arrayCanopies {
            if let count = canopyCount[canopy] {
                canopyCount[canopy] = count + 1
            } else {
                canopyCount[canopy] = 1
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            for (canopy, count) in canopyCount.sorted(by: { $0.value > $1.value }) {
                message += "\n\(canopy): \(count)\n"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("List canopies", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: LOCATIONS:

    func tapLocationsButton() {
        var arrayLocations: [String] = []
        for jump in arrayJumpsRealm {
            arrayLocations.append(jump.location)
        }

        var locationCount: [String: Int] = [:]

        for location in arrayLocations {
            if let count = locationCount[location] {
                locationCount[location] = count + 1
            } else {
                locationCount[location] = 1
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            for (location, count) in locationCount.sorted(by: { $0.value > $1.value }) {
                message += "\n\(location): \(count)\n"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("List locations", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }
}
