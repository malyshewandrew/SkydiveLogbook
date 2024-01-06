import Lottie
import SafariServices
import UIKit
import WebKit

final class AccountVC: UIViewController {
    // MARK: - PROPERTIES:

    private let accountLottie = LottieAnimationView(name: "Account")
    private let confettiLottie = LottieAnimationView(name: "AccountConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let tableView = UITableView()

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
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, accountLottie, confettiButton, tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION ACCOUNT LOTTIE:

        accountLottie.translatesAutoresizingMaskIntoConstraints = false
        accountLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accountLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        accountLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        accountLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: accountLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: accountLottie.centerYAnchor).isActive = true
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
        tableView.topAnchor.constraint(equalTo: accountLottie.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        view.backgroundColor = colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""

        // MARK: ANIMATIONS:

        accountLottie.play()
        accountLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = colorBlueCG
        confettiLottie.layer.shadowOpacity = 1
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = colorBackground
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

    @objc func tapOnConfettiButton() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}

// MARK: - EXTENSION:

extension AccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as? AccountCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
}

extension AccountVC: AccountCellDelegate {

    func tapEditAccountButton() {
        let editAccount = EditAccountVC()
        navigationController?.pushViewController(editAccount, animated: true)
    }

    func tapEditLocationsButton() {
        let editLocations = EditLocationsVC()
        navigationController?.pushViewController(editLocations, animated: true)
    }

    func tapEditAircraftsButton() {
        let editAircrafts = EditAircraftsVC()
        navigationController?.pushViewController(editAircrafts, animated: true)
    }

    func tapEditCanopiesButton() {
        let editCanopies = EditCanopiesVC()
        navigationController?.pushViewController(editCanopies, animated: true)
    }

    func tapBackupButton() {
        let backup = BackupVC()
        navigationController?.pushViewController(backup, animated: true)
    }

    func tapCalculatorButton() {
        let calculator = CalculatorVC()
        navigationController?.pushViewController(calculator, animated: true)
    }

    func tapInfoButton() {
        let info = InfoVC()
        navigationController?.pushViewController(info, animated: true)
    }

    func tapPremiumButton() {
        let premium = PremiumVC()
        navigationController?.pushViewController(premium, animated: true)
    }
}
