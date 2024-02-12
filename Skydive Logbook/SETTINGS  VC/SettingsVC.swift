import Lottie
import RealmSwift
import SafariServices
import UIKit
import WebKit

final class SettingsVC: UIViewController {
    // MARK: - PROPERTIES:

    private let settingsLottie = LottieAnimationView(name: "Settings")
    private let confettiLottie = LottieAnimationView(name: "SettingsConfetti")
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
        view.addSubviews(confettiLottie, settingsLottie, confettiButton, tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION SETTINGS LOTTIE:

        settingsLottie.translatesAutoresizingMaskIntoConstraints = false
        settingsLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        settingsLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        settingsLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: settingsLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: settingsLottie.centerYAnchor).isActive = true
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
        tableView.topAnchor.constraint(equalTo: settingsLottie.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""

        // MARK: ANIMATIONS:

        settingsLottie.play()
        settingsLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorBackground
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

    @objc func confettiButtonTapped() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}

// MARK: - EXTENSION:

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
}

extension SettingsVC: SettingsCellDelegate {
    
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

    func tapInfoButton() {
        let info = InfoVC()
        navigationController?.pushViewController(info, animated: true)
    }

    func tapPremiumButton() {
        let premium = PremiumVC()
        navigationController?.pushViewController(premium, animated: true)
    }
    
    func tapInstagramButton() {
        guard let url = URL(string: "https://instagram.com/skydivelogbook") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true)
    }
}

// MARK: - EXTENSION. SAFARI VIEW CONTROLLER DELEGATE:

extension SettingsVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}
