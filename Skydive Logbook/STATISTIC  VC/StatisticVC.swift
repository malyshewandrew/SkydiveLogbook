import Lottie
import UIKit

final class StatisticVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let statisticLottie = LottieAnimationView(name: "Statistic")
    private let confettiLottie = LottieAnimationView(name: "StatisticConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let tableView = UITableView()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatisticCell.self, forCellReuseIdentifier: "CellStatistic")
        navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
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

        view.backgroundColor = colorBackground

        // MARK: ANIMATIONS:

        statisticLottie.play()
        statisticLottie.loopMode = .autoReverse

        // MARK: TABLE VIEW:

        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none

        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confetti))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - FUNC FOR CONFETTI + VIBRATION:

    @objc private func confetti() {
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
        for jump in arrayJumps {
            sumTime += Int(jump.time) ?? 0
        }

        var timeMessage = ""
        switch sumTime {
        case 0...150:
            timeMessage = "Наберись еще опыта (0 - 2,5 минут)"
        case 150...300:
            timeMessage = "Время одной музыкальной композиции (2,5 - 5 минут)"
        case 300...600:
            timeMessage = "Время короткометражного фильма (5 - 10 минут)"
        case 600...900:
            timeMessage = "(10 - 15 минут)"
        case 900...1000:
            timeMessage = "Время дополнительного футбольного тайма (15 - 16 минут)"
        case 1000...1200:
            timeMessage = "(16 - 20 минут)"
        case 1200...1500:
            timeMessage = "(20 - 25 минут)"
        case 1500...2500:
            timeMessage = "(25 - 40 минут)"
        case 2500...3000:
            timeMessage = "Время школьного урока (41 - 50 минут)"
        case 3000...3500:
            timeMessage = "За это время на машине вы бы могли доехать в космос, если бы ваша машина могла ехать вверх (50 - 58 минут)"
        case 3500...5000:
            timeMessage = "Время футбольного матча (58 - 83 минут)."
        case 5000...6000:
            timeMessage = "За это время МКС облетает вокруг Земли (83 - 100 минут)."
        case 6000...8000:
            timeMessage = "Время целого кинофильма (100 - 133 минут)"
        case 8000...10000:
            timeMessage = "Время выступления циркового номера (133 - 166 минут)"
        case 10000...13000:
            timeMessage = "(166 - 216 минут)"
        case 13000...17000:
            timeMessage = "(216 - 283 минут)"
        case 17000...20000:
            timeMessage = "(283 - 333 минут)"
        case 20000...25000:
            timeMessage = "(333 - 416 минут)"
        case 25000...30000:
            timeMessage = "(416 - 500 минут)"
        case 35000...40000:
            timeMessage = "(500 - 666 минут)"
        case 40000...50000:
            timeMessage = "(666 - 833 минут)"
        case 50000...100000:
            timeMessage = "(833 - 1666 минут)"
        case 100000...:
            timeMessage = "(1666 - ... минут)"
        default:
            timeMessage = "(133 - 166 минут)"
        }

        var sumHeight = 0
        for jump in arrayJumps {
            sumHeight += Int(jump.height) ?? 0
        }
        var heightMessage = "Придумать"
        switch sumHeight {
        case 0...150:
            heightMessage = "Придумать"
        case 150...300:
            heightMessage = "Придумать"
        default:
            heightMessage = "Придумать"
        }

        let alert = UIAlertController(title: NSLocalizedString("General info", comment: "") + ":",
                                      message: """
                                      \nСуммарная высота \(sumHeight) м.
                                      \(heightMessage)\n
                                      \nВремя свободнго падения: \(sumTime) c.
                                      \(timeMessage)\n
                                      """,
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
        contentView.layer.shadowColor = colorWhiteCG
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
        let dateFormatter = DateFormatter()

        for jump in arrayJumps {
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
        for (year, count) in yearsCount.sorted(by: { $0 > $1 }) {
            message += "\(year) \(NSLocalizedString("year", comment: "")): \(count)\n"
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

        for jump in arrayJumps {
            if let height = Int(jump.height), height > maxJumpHeight {
                maxJumpHeight = height
                maxHeightDate = jump.date
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("Maximum height", comment: "") + ":",
                                      message: "\n\(NSLocalizedString("Maximum height alert", comment: "")): \(maxHeightDate)",
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
        for jump in arrayJumps {
            sumAverageHeight += Int(jump.height) ?? 0
        }

        var averageHeight = 0

        if arrayJumps.count == 0 {
            averageHeight = 0
        } else {
            averageHeight = sumAverageHeight / arrayJumps.count
        }

        let alert = UIAlertController(title: "Средняя высота",
                                      message: """
                                      \n\(NSLocalizedString("Average height", comment: "")): \(averageHeight) \(NSLocalizedString("m.", comment: ""))
                                      """,
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

        for jump in arrayJumps {
            if let height = Int(jump.height), height < minJumpHeight {
                minJumpHeight = height
                minHeightDate = jump.date
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("Minimum height", comment: "") + ":",
                                      message: "\n\(NSLocalizedString("Minimum height alert", comment: "")): \(minHeightDate)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: DATE FIRST:

    func tapDateFirstButton() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        if let jumpDateString = arrayJumps.first?.date, let jumpDate = dateFormatter.date(from: jumpDateString) {
            let userCalendar = Calendar.current
            let dayMonthYearPassed = userCalendar.dateComponents([.day, .month, .year], from: jumpDate, to: currentDate)

            guard let year = dayMonthYearPassed.year,
                  let month = dayMonthYearPassed.month,
                  let day = dayMonthYearPassed.day else { return }

            let alert = UIAlertController(title: NSLocalizedString("Date first jump", comment: "") + ":",
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

    // MARK: MAX TIME:

    func tapMaxTimeButton() {
        var maxJumpHeight = 0
        var maxTimeDate = ""

        for jump in arrayJumps {
            if let height = Int(jump.time), height > maxJumpHeight {
                maxJumpHeight = height
                maxTimeDate = jump.date
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("Maximum time", comment: "") + ":",
                                      message: "\n\(NSLocalizedString("Maximum time alert", comment: "")): \(maxTimeDate)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }

    // MARK: DATE LAST:

    func tapDateLastButton() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        if let jumpDateString = arrayJumps.last?.date, let jumpDate = dateFormatter.date(from: jumpDateString) {
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

    // MARK: MAX DAY:

    func tapMaxDayButton() {
        var jumpsMaxDay: [String: Int] = [:]
        var dayWithMostJumps = ""
        var numberOfJumps = 0

        for jump in arrayJumps {
            if let count = jumpsMaxDay[jump.date] {
                jumpsMaxDay[jump.date] = count + 1
            } else {
                jumpsMaxDay[jump.date] = 1
            }
        }

        if let maxDay = jumpsMaxDay.max(by: { $0.value < $1.value }) {
            dayWithMostJumps = maxDay.key
            numberOfJumps = maxDay.value
        } else {
            dayWithMostJumps = ""
            numberOfJumps = 0
        }

        let alert = UIAlertController(title: NSLocalizedString("Max in one day", comment: "") + ":",
                                      message: """
                                      \n\(NSLocalizedString("Max count of jumps", comment: "")): \(numberOfJumps)
                                      \n\(NSLocalizedString("Max count of jumps text", comment: "")): \(dayWithMostJumps)
                                      """,
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
        for jump in arrayJumps {
            sumAverageTime += Int(jump.time) ?? 0
        }

        var averageTime = 0

        if arrayJumps.count == 0 {
            averageTime = 0
        } else {
            averageTime = sumAverageTime / arrayJumps.count
        }

        let alert = UIAlertController(title: "Среднее время:",
                                      message: """
                                      \n\(NSLocalizedString("Average time", comment: "")): \(averageTime) \(NSLocalizedString("s.", comment: ""))
                                      """,
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

        for jump in arrayJumps {
            if jump.cutaway == NSLocalizedString("Yes", comment: "") {
                countCutaway += 1
                let jumpData = (date: jump.date, comment: jump.comment)
                dataWithCutawayYes.append(jumpData)
            }
        }

        let resultString = dataWithCutawayYes.map { "\($0.date)\n\($0.comment)" }.joined(separator: "\n\n")
        let alert = UIAlertController(title: NSLocalizedString("CutawayStatistic", comment: "") + ":",
                                      message: """
                                      \n\(NSLocalizedString("Сount of cutaways", comment: "")): \(countCutaway)\n
                                      \(resultString)
                                      """,
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
        for jump in arrayJumps {
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
        for (aircraft, count) in aircraftCount.sorted(by: { $0.value > $1.value }) {
            message += "\(aircraft): \(count)\n"
        }

        let alert = UIAlertController(title: NSLocalizedString("List aircrafts", comment: "") + ":",
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

    // MARK: CANOPIES:

    func tapCanopiesButton() {
        var arrayCanopies: [String] = []
        for jump in arrayJumps {
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
        for (canopy, count) in canopyCount.sorted(by: { $0.value > $1.value }) {
            message += "\(canopy): \(count)\n"
        }

        let alert = UIAlertController(title: NSLocalizedString("List canopies", comment: "") + ":",
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

    // MARK: LOCATIONS:

    func tapLocationsButton() {
        var arrayLocations: [String] = []
        for jump in arrayJumps {
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

        for (location, count) in locationCount.sorted(by: { $0.value > $1.value }) {
            message += "\(location): \(count)\n"
        }

        let alert = UIAlertController(title: NSLocalizedString("List locations", comment: "") + ":",
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
}
