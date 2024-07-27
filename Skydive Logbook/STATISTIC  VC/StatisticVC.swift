import Lottie
import RealmSwift
import UIKit

final class StatisticVC: UIViewController {
    // MARK: - PROPERTIES:

    private let effectOneLottie = LottieAnimationView(name: "Effect")
    private let effectTwoLottie = LottieAnimationView(name: "Effect")
    private let statisticLottie = LottieAnimationView(name: "Statistic")
    private let confettiLottie = LottieAnimationView(name: "StatisticConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let tableView = UITableView()
    private let dateFormatter = DateFormatter()
    private let realmManager = RealmManager()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        configureGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadJumps()
        tableView.reloadData()
    }
    
    // MARK: - ADD SUBVIEWS::

    private func addSubviews() {
        view.addSubviews(confettiLottie, effectOneLottie, effectTwoLottie, tableView, statisticLottie, confettiButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION STATISTIC LOTTIE:

        statisticLottie.translatesAutoresizingMaskIntoConstraints = false
        statisticLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statisticLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        statisticLottie.heightAnchor.constraint(equalToConstant: 80).isActive = true
        statisticLottie.widthAnchor.constraint(equalToConstant: 80).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: statisticLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: statisticLottie.centerYAnchor).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: EFFECT ONE LOTTIE:

        effectOneLottie.translatesAutoresizingMaskIntoConstraints = false
        effectOneLottie.centerXAnchor.constraint(equalTo: confettiLottie.centerXAnchor).isActive = true
        effectOneLottie.centerYAnchor.constraint(equalTo: confettiLottie.centerYAnchor).isActive = true
        effectOneLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: EFFECT TWO LOTTIE:

        effectTwoLottie.translatesAutoresizingMaskIntoConstraints = false
        effectTwoLottie.centerXAnchor.constraint(equalTo: confettiLottie.centerXAnchor).isActive = true
        effectTwoLottie.centerYAnchor.constraint(equalTo: confettiLottie.centerYAnchor).isActive = true
        effectTwoLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

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
        statisticLottie.loopMode = .loop
        statisticLottie.animationSpeed = 0.6

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        // MARK: EFFECT ONE LOTTIE:

        effectOneLottie.play()
        effectOneLottie.loopMode = .loop
        effectOneLottie.animationSpeed = 0.2
        effectOneLottie.layer.shadowRadius = 15
        effectOneLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        effectOneLottie.layer.shadowOpacity = 1

        // MARK: EFFECT TWO LOTTIE:

        effectTwoLottie.play()
        effectTwoLottie.loopMode = .loop
        effectTwoLottie.animationSpeed = 0.1
        effectTwoLottie.transform = CGAffineTransform(scaleX: -1, y: 1)
        effectTwoLottie.layer.shadowRadius = 10
        effectTwoLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        effectTwoLottie.layer.shadowOpacity = 1
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatisticCell.self, forCellReuseIdentifier: "CellStatistic")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.reloadData()
    }

    // MARK: - LOAD JUMPS FROM REALM:

    private func loadJumps() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map { $0 }
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confettiButtonTapped))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func confettiButtonTapped() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
        confettiLottie.animationSpeed = 0.7
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
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
}

// MARK: - EXTENSION FOR DELEGATES:

extension StatisticVC: StatisticCellDelegate {
    // MARK: GENERAL INFO VC:

    func tapGeneralInfoVCButton() {
        vibrationOn.vibrationStandart()
        
        tableView.layer.opacity = 0.0
        tabBarController?.tabBar.layer.opacity = 0.0
        effectOneLottie.layer.opacity = 0.0
        effectTwoLottie.layer.opacity = 0.0
        statisticLottie.layer.opacity = 0.0
        confettiLottie.layer.opacity = 0.0
        
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            var sumHeight = 0
            for jump in arrayJumpsRealm {
                sumHeight += Int(jump.height) ?? 0
            }

            let kilometers = sumHeight / 1000

            var heightMessage = ""
            switch sumHeight {
            case 0...1000:
                heightMessage = ""
            case 1000...4500:
                heightMessage = ""
            case 4500...11000:
                heightMessage = ""
            case 11000...30000:
                heightMessage = ""
            case 30000...345000:
                heightMessage = ""
            case 45000...60000:
                heightMessage = ""
            case 60000...75000:
                heightMessage = ""
            case 75000...105000:
                heightMessage = ""
            case 105000...150000:
                heightMessage = ""
            case 150000...195000:
                heightMessage = ""
            case 195000...255000:
                heightMessage = ""
            case 255000...300000:
                heightMessage = ""
            case 300000...360000:
                heightMessage = ""
            case 360000...450000:
                heightMessage = ""
            case 450000...900000:
                heightMessage = ""
            case 900000...1500000:
                heightMessage = ""
            case 1500000...2250000:
                heightMessage = ""
            case 2250000...3000000:
                heightMessage = ""
            case 3000000...4500000:
                heightMessage = ""
            case 4500000...6000000:
                heightMessage = ""
            case 6000000...9000000:
                heightMessage = ""
            case 9000000...12000000:
                heightMessage = ""
            case 12000000...18000000:
                heightMessage = ""
            case 18000000...21000000:
                heightMessage = ""
            case 21000000...30000000:
                heightMessage = ""
            case 30000000...:
                heightMessage = ""
            default:
                heightMessage = "none"
            }
            
            var sumTime = 0
            for jump in arrayJumpsRealm {
                sumTime += Int(jump.time) ?? 0
            }

            var timeMessage = ""
            switch sumTime {
            case 0...1:
                timeMessage = NSLocalizedString("Case 0-1", comment: "")
            case 1...150:
                timeMessage = NSLocalizedString("Case 1-150", comment: "")
            case 150...300:
                timeMessage = NSLocalizedString("Case 150-300", comment: "")
            case 300...600:
                timeMessage = NSLocalizedString("Case 300-600", comment: "")
            case 600...900:
                timeMessage = NSLocalizedString("Case 600-900", comment: "")
            case 900...1000:
                timeMessage = NSLocalizedString("Case 900-1000", comment: "")
            case 1000...1200:
                timeMessage = NSLocalizedString("Case 1000-1200", comment: "")
            case 1200...1500:
                timeMessage = NSLocalizedString("Case 1200-1500", comment: "")
            case 1500...2500:
                timeMessage = NSLocalizedString("Case 1500-2500", comment: "")
            case 2500...3000:
                timeMessage = NSLocalizedString("Case 2500-3000", comment: "")
            case 3000...3500:
                timeMessage = NSLocalizedString("Case 3000-3500", comment: "")
            case 3500...5000:
                timeMessage = NSLocalizedString("Case 3500-5000", comment: "")
            case 5000...6000:
                timeMessage = NSLocalizedString("Case 5000-6000", comment: "")
            case 6000...8000:
                timeMessage = NSLocalizedString("Case 6000-8000", comment: "")
            case 8000...10000:
                timeMessage = NSLocalizedString("Case 8000-10000", comment: "")
            case 10000...13000:
                timeMessage = NSLocalizedString("Case 10000-13000", comment: "")
            case 13000...17000:
                timeMessage = NSLocalizedString("Case 13000-17000", comment: "")
            case 17000...20000:
                timeMessage = NSLocalizedString("Case 17000-20000", comment: "")
            case 20000...25000:
                timeMessage = NSLocalizedString("Case 20000-25000", comment: "")
            case 25000...30000:
                timeMessage = NSLocalizedString("Case 25000-30000", comment: "")
            case 35000...40000:
                timeMessage = NSLocalizedString("Case 35000-40000", comment: "")
            case 40000...50000:
                timeMessage = NSLocalizedString("Case 40000-50000", comment: "")
            case 50000...100000:
                timeMessage = NSLocalizedString("Case 50000-100000", comment: "")
            case 100000...:
                timeMessage = NSLocalizedString("Case 100000-...", comment: "")
            default:
                timeMessage = NSLocalizedString("Case Default-Default", comment: "")
            }

            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()

            if arrayJumpsRealm.count == 0 {
                let alert = UIAlertController(title: NSLocalizedString("General info", comment: "") + ":",
                                              message: "\n" + NSLocalizedString("no jumps", comment: ""),
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
                self.present(alert, animated: true)
            } else {
                let generalInfoVC = GeneralInfoVC()
                if let sheetController = generalInfoVC.sheetPresentationController {
                    sheetController.prefersGrabberVisible = true
                    sheetController.preferredCornerRadius = cornerRadius15
                    sheetController.detents = [.large()]
                }

                generalInfoVC.heightpPosition = CGFloat(sumHeight / 1000)
                generalInfoVC.heightLabel.text = """
                \(kilometers)
                \(heightMessage)
                """
                generalInfoVC.timeLabel.text = """
                \(sumTime)
                \(timeMessage)
                """
                self.present(generalInfoVC, animated: true)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.layer.opacity = 1.0
                self.tabBarController?.tabBar.layer.opacity = 1.0
                self.effectOneLottie.layer.opacity = 1.0
                self.effectTwoLottie.layer.opacity = 1.0
                self.statisticLottie.layer.opacity = 1.0
                self.confettiLottie.layer.opacity = 1.0
            }
        }
    }

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
            timeMessage = NSLocalizedString("Case 1-150", comment: "")
        case 150...300:
            timeMessage = NSLocalizedString("Case 150-300", comment: "")
        case 300...600:
            timeMessage = NSLocalizedString("Case 300-600", comment: "")
        case 600...900:
            timeMessage = NSLocalizedString("Case 600-900", comment: "")
        case 900...1000:
            timeMessage = NSLocalizedString("Case 900-1000", comment: "")
        case 1000...1200:
            timeMessage = NSLocalizedString("Case 1000-1200", comment: "")
        case 1200...1500:
            timeMessage = NSLocalizedString("Case 1200-1500", comment: "")
        case 1500...2500:
            timeMessage = NSLocalizedString("Case 1500-2500", comment: "")
        case 2500...3000:
            timeMessage = NSLocalizedString("Case 2500-3000", comment: "")
        case 3000...3500:
            timeMessage = NSLocalizedString("Case 3000-3500", comment: "")
        case 3500...5000:
            timeMessage = NSLocalizedString("Case 3500-5000", comment: "")
        case 5000...6000:
            timeMessage = NSLocalizedString("Case 5000-6000", comment: "")
        case 6000...8000:
            timeMessage = NSLocalizedString("Case 6000-8000", comment: "")
        case 8000...10000:
            timeMessage = NSLocalizedString("Case 8000-10000", comment: "")
        case 10000...13000:
            timeMessage = NSLocalizedString("Case 10000-13000", comment: "")
        case 13000...17000:
            timeMessage = NSLocalizedString("Case 13000-17000", comment: "")
        case 17000...20000:
            timeMessage = NSLocalizedString("Case 17000-20000", comment: "")
        case 20000...25000:
            timeMessage = NSLocalizedString("Case 20000-25000", comment: "")
        case 25000...30000:
            timeMessage = NSLocalizedString("Case 25000-30000", comment: "")
        case 35000...40000:
            timeMessage = NSLocalizedString("Case 35000-40000", comment: "")
        case 40000...50000:
            timeMessage = NSLocalizedString("Case 40000-50000", comment: "")
        case 50000...100000:
            timeMessage = NSLocalizedString("Case 50000-100000", comment: "")
        case 100000...:
            timeMessage = NSLocalizedString("Case 100000-...", comment: "")
        default:
            timeMessage = NSLocalizedString("Case Default-Default", comment: "")
        }

        var sumHeight = 0
        for jump in arrayJumpsRealm {
            sumHeight += Int(jump.height) ?? 0
        }

        var heightMessage = ""
        switch sumHeight {
        case 0...1:
            heightMessage = ""
        case 0...150:
            heightMessage = ""
        case 150...300:
            heightMessage = ""
        default:
            heightMessage = ""
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = """
            \n\(NSLocalizedString("Total height", comment: "")): \(sumHeight) \(NSLocalizedString("m.", comment: ""))
            \(heightMessage)\n
            \n\(NSLocalizedString("Total time", comment: "")): \(sumTime) \(NSLocalizedString("s.", comment: ""))
            \(timeMessage)\n
            """
        }

        let alert = UIAlertController(title: NSLocalizedString("General info", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }

    // MARK: TOTAL JUMPS:

    func tapTotalButton() {
        let contentView = UIView()
        let imageLottie = LottieAnimationView(name: "Total")

        let alert = UIAlertController(title: NSLocalizedString("saving data", comment: "") + ":", message: "\n\n\n\n\n\n \(NSLocalizedString("saving data text", comment: ""))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
        imageLottie.animationSpeed = 0.5
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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }

    // MARK: CATEGORIES:

    func tapCategoryButton() {
        let alert = UIAlertController(title: NSLocalizedString("Categories USPA", comment: "") + ":",
                                      message: NSLocalizedString("Categories USPA List", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }

    // MARK: MAX HEIGHT:

    func tapMaxHeightButton() {
        var maxJumpHeight = 0
        var maxHeightDate = ""
        var location = ""
        var aircraft = ""
        var canopy = ""
        var mission = ""
        var heightMax = ""
        var time = ""
        var cutaway = ""

        for jump in arrayJumpsRealm {
            if let height = Int(jump.height), height > maxJumpHeight {
                maxJumpHeight = height
                maxHeightDate = NSLocalizedString("Date", comment: "") + ": " + jump.date
                location = NSLocalizedString("Location", comment: "") + ": " + jump.location
                aircraft = NSLocalizedString("Aircraft", comment: "") + ": " + jump.aircraft
                canopy = NSLocalizedString("Canopy", comment: "") + ": " + jump.canopy
                mission = NSLocalizedString("Mission", comment: "") + ": " + (jump.mission?.localizedValue ?? "")
                heightMax = NSLocalizedString("Height", comment: "") + ": " + jump.height + " " + NSLocalizedString("m.", comment: "")
                time = NSLocalizedString("Time", comment: "") + ": " + jump.time + " " + NSLocalizedString("s.", comment: "")
                cutaway = NSLocalizedString("Cutaway", comment: "") + ": " + (jump.cutaway?.localizedValue ?? "")
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Maximum height alert", comment: "")):\n\n \(maxHeightDate)\n\(location)\n\(aircraft)\n\(canopy)\n\(mission)\n\(heightMax)\n\(time)\n\(cutaway)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Maximum height", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }

    // MARK: MIN HEIGHT:

    func tapMinHeightButton() {
        var minJumpHeight = Int.max
        var minHeightDate = ""
        var location = ""
        var aircraft = ""
        var canopy = ""
        var mission = ""
        var heightMin = ""
        var time = ""
        var cutaway = ""

        for jump in arrayJumpsRealm {
            if let height = Int(jump.height), height < minJumpHeight {
                minJumpHeight = height
                minHeightDate = NSLocalizedString("Date", comment: "") + ": " + jump.date
                location = NSLocalizedString("Location", comment: "") + ": " + jump.location
                aircraft = NSLocalizedString("Aircraft", comment: "") + ": " + jump.aircraft
                canopy = NSLocalizedString("Canopy", comment: "") + ": " + jump.canopy
                mission = NSLocalizedString("Mission", comment: "") + ": " + (jump.mission?.localizedValue ?? "")
                heightMin = NSLocalizedString("Height", comment: "") + ": " + jump.height + " " + NSLocalizedString("m.", comment: "")
                time = NSLocalizedString("Time", comment: "") + ": " + jump.time + " " + NSLocalizedString("s.", comment: "")
                cutaway = NSLocalizedString("Cutaway", comment: "") + ": " + (jump.cutaway?.localizedValue ?? "")
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Minimum height alert", comment: "")):\n\n \(minHeightDate)\n\(location)\n\(aircraft)\n\(canopy)\n\(mission)\n\(heightMin)\n\(time)\n\(cutaway)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Minimum height", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }

    // MARK: DATE FIRST:

    func tapDateFirstButton() {
        var date = ""
        var location = ""
        var aircraft = ""
        var canopy = ""
        var mission = ""
        var heightMin = ""
        var time = ""
        var cutaway = ""

        if arrayJumpsRealm.count == 0 {
            let alert = UIAlertController(title: NSLocalizedString("Date first jump", comment: "") + ":",
                                          message: "\n" + NSLocalizedString("no jumps", comment: ""),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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

                guard let jump = arrayJumpsRealm.first else { return }

                date = NSLocalizedString("Date", comment: "") + ": " + jump.date
                location = NSLocalizedString("Location", comment: "") + ": " + jump.location
                aircraft = NSLocalizedString("Aircraft", comment: "") + ": " + jump.aircraft
                canopy = NSLocalizedString("Canopy", comment: "") + ": " + jump.canopy
                mission = NSLocalizedString("Mission", comment: "") + ": " + (jump.mission?.localizedValue ?? "")
                heightMin = NSLocalizedString("Height", comment: "") + ": " + jump.height + " " + NSLocalizedString("m.", comment: "")
                time = NSLocalizedString("Time", comment: "") + ": " + jump.time + " " + NSLocalizedString("s.", comment: "")
                cutaway = NSLocalizedString("Cutaway", comment: "") + ": " + (jump.cutaway?.localizedValue ?? "")

                var message = ""
                if arrayJumpsRealm.count == 0 {
                    message = "\n" + NSLocalizedString("no jumps", comment: "")
                } else {
                    message = "\n\(NSLocalizedString("First jump / statistic", comment: "")) \(year) \(NSLocalizedString("y.", comment: "")) \(month) \(NSLocalizedString("mon.", comment: "")) \(day) \(NSLocalizedString("d.", comment: "")) \(NSLocalizedString("ago", comment: ""))\n\n \(date)\n\(location)\n\(aircraft)\n\(canopy)\n\(mission)\n\(heightMin)\n\(time)\n\(cutaway)"
                }

                let alert = UIAlertController(title: NSLocalizedString("Date first jump", comment: "") + ":",
                                              message: message,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
                present(alert, animated: true)
            }
        }
    }

    // MARK: MAX TIME:

    func tapMaxTimeButton() {
        var maxJumpTime = 0
        var maxTimeDate = ""
        var location = ""
        var aircraft = ""
        var canopy = ""
        var mission = ""
        var height = ""
        var timeMax = ""
        var cutaway = ""

        for jump in arrayJumpsRealm {
            if let time = Int(jump.time), time > maxJumpTime {
                maxJumpTime = time
                maxTimeDate = NSLocalizedString("Date", comment: "") + ": " + jump.date
                location = NSLocalizedString("Location", comment: "") + ": " + jump.location
                aircraft = NSLocalizedString("Aircraft", comment: "") + ": " + jump.aircraft
                canopy = NSLocalizedString("Canopy", comment: "") + ": " + jump.canopy
                mission = NSLocalizedString("Mission", comment: "") + ": " + (jump.mission?.localizedValue ?? "")
                height = NSLocalizedString("Height", comment: "") + ": " + jump.height + " " + NSLocalizedString("m.", comment: "")
                timeMax = NSLocalizedString("Time", comment: "") + ": " + jump.time + " " + NSLocalizedString("s.", comment: "")
                cutaway = NSLocalizedString("Cutaway", comment: "") + ": " + (jump.cutaway?.localizedValue ?? "")
            }
        }

        var message = ""
        if arrayJumpsRealm.count == 0 {
            message = "\n" + NSLocalizedString("no jumps", comment: "")
        } else {
            message = "\n\(NSLocalizedString("Maximum time alert", comment: "")):\n\n \(maxTimeDate)\n\(location)\n\(aircraft)\n\(canopy)\n\(mission)\n\(height)\n\(timeMax)\n\(cutaway)"
        }

        let alert = UIAlertController(title: NSLocalizedString("Maximum time", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }

    // MARK: DATE LAST:

    func tapDateLastButton() {
        var date = ""
        var location = ""
        var aircraft = ""
        var canopy = ""
        var mission = ""
        var heightMin = ""
        var time = ""
        var cutaway = ""

        if arrayJumpsRealm.count == 0 {
            let alert = UIAlertController(title: NSLocalizedString("Date last jump", comment: "") + ":",
                                          message: "\n" + NSLocalizedString("no jumps", comment: ""),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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

                guard let jump = arrayJumpsRealm.last else { return }

                date = NSLocalizedString("Date", comment: "") + ": " + jump.date
                location = NSLocalizedString("Location", comment: "") + ": " + jump.location
                aircraft = NSLocalizedString("Aircraft", comment: "") + ": " + jump.aircraft
                canopy = NSLocalizedString("Canopy", comment: "") + ": " + jump.canopy
                mission = NSLocalizedString("Mission", comment: "") + ": " + (jump.mission?.localizedValue ?? "")
                heightMin = NSLocalizedString("Height", comment: "") + ": " + jump.height + " " + NSLocalizedString("m.", comment: "")
                time = NSLocalizedString("Time", comment: "") + ": " + jump.time + " " + NSLocalizedString("s.", comment: "")
                cutaway = NSLocalizedString("Cutaway", comment: "") + ": " + (jump.cutaway?.localizedValue ?? "")

                var message = ""
                if arrayJumpsRealm.count == 0 {
                    message = "\n" + NSLocalizedString("no jumps", comment: "")
                } else {
                    message = "\n\(NSLocalizedString("Last jump / statistic", comment: "")) \(year) \(NSLocalizedString("y.", comment: "")) \(month) \(NSLocalizedString("mon.", comment: "")) \(day) \(NSLocalizedString("d.", comment: "")) \(NSLocalizedString("ago", comment: ""))\n\n \(date)\n\(location)\n\(aircraft)\n\(canopy)\n\(mission)\n\(heightMin)\n\(time)\n\(cutaway)"
                }

                let alert = UIAlertController(title: NSLocalizedString("Date last jump", comment: "") + ":",
                                              message: message,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
                message += "\n\(aircraft): \(count)"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("List aircrafts", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
                message += "\n\(canopy): \(count)"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("List canopies", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
                message += "\n\(location): \(count)"
            }
        }

        let alert = UIAlertController(title: NSLocalizedString("List locations", comment: "") + ":",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }
}
