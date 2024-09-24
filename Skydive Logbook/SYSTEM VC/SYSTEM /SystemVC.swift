import AlertKit
import Lottie
import RealmSwift
import UIKit

final class SystemVC: UIViewController {
    // MARK: - PROPERTIES:

    private let systemLottie = LottieAnimationView(name: "Parachute")
    private let startSystemLottie = LottieAnimationView(name: "Parachute")
    private let confettiLottie = LottieAnimationView(name: "SystemConfetti")
    private let effectOneLottie = LottieAnimationView(name: "EffectSystem")
    private let startConfettiLottie = LottieAnimationView(name: "SystemConfetti")
    private let confettiButton = UIButton()
    private let startConfettiButton = UIButton()
    private let tableView = UITableView()
    private var emptySystemButton = UIButton()
    private let newSystemButton = UIButton()
    private var selectedSystem: SystemClassRealm?
    private var indexSysytem: Int = 0
    private let realmManager = RealmManager()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 30)

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
        loadSystem()
        loadCanopies()
        startSystems()
        startConfigureGestures()
        tableView.reloadData()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, effectOneLottie, startConfettiLottie, systemLottie, startSystemLottie, confettiButton, startConfettiButton, tableView, emptySystemButton, newSystemButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: EFFECT ONE LOTTIE:

        effectOneLottie.translatesAutoresizingMaskIntoConstraints = false
        effectOneLottie.centerXAnchor.constraint(equalTo: systemLottie.centerXAnchor).isActive = true
        effectOneLottie.centerYAnchor.constraint(equalTo: systemLottie.centerYAnchor, constant: -25).isActive = true
        effectOneLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: ANIMATION SYSTEM LOTTIE:

        systemLottie.translatesAutoresizingMaskIntoConstraints = false
        systemLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        systemLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        systemLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        systemLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: START ANIMATION SYSTEM LOTTIE:

        startSystemLottie.translatesAutoresizingMaskIntoConstraints = false
        startSystemLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startSystemLottie.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        startSystemLottie.heightAnchor.constraint(equalToConstant: 125).isActive = true
        startSystemLottie.widthAnchor.constraint(equalToConstant: 125).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: systemLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: systemLottie.centerYAnchor, constant: -10).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: START ANIMATION LOTTIE CONFETTI:

        startConfettiLottie.translatesAutoresizingMaskIntoConstraints = false
        startConfettiLottie.centerXAnchor.constraint(equalTo: startSystemLottie.centerXAnchor).isActive = true
        startConfettiLottie.centerYAnchor.constraint(equalTo: startSystemLottie.centerYAnchor, constant: -10).isActive = true
        startConfettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: systemLottie.centerXAnchor).isActive = true
        confettiButton.centerYAnchor.constraint(equalTo: systemLottie.centerYAnchor).isActive = true
        confettiButton.heightAnchor.constraint(equalTo: systemLottie.heightAnchor, multiplier: 1).isActive = true
        confettiButton.widthAnchor.constraint(equalTo: systemLottie.widthAnchor, multiplier: 1).isActive = true

        // MARK: START BUTTON FOR ANIMATION LOTTIE CONFETTI:

        startConfettiButton.translatesAutoresizingMaskIntoConstraints = false
        startConfettiButton.centerXAnchor.constraint(equalTo: startSystemLottie.centerXAnchor).isActive = true
        startConfettiButton.centerYAnchor.constraint(equalTo: startSystemLottie.centerYAnchor).isActive = true
        startConfettiButton.heightAnchor.constraint(equalTo: startSystemLottie.heightAnchor, multiplier: 1).isActive = true
        startConfettiButton.widthAnchor.constraint(equalTo: startSystemLottie.widthAnchor, multiplier: 1).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: systemLottie.bottomAnchor, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: NEW SYSTEM:

        newSystemButton.translatesAutoresizingMaskIntoConstraints = false
        newSystemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        newSystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // MARK: EMPTY SYSTEM:

        emptySystemButton.translatesAutoresizingMaskIntoConstraints = false
        emptySystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptySystemButton.topAnchor.constraint(equalTo: startSystemLottie.bottomAnchor, constant: 20).isActive = true
        emptySystemButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        emptySystemButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""

        // MARK: EFFECT LOTTIE:

        effectOneLottie.play()
        effectOneLottie.loopMode = .loop
        effectOneLottie.animationSpeed = 0.5
        effectOneLottie.layer.opacity = 0.7

        // MARK: ANIMATION SYSTEM LOTTIE:

        systemLottie.play()
        systemLottie.loopMode = .autoReverse

        // MARK: ANIMATION START SYSTEM LOTTIE:

        startSystemLottie.play()
        startSystemLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        startConfettiLottie.layer.shadowRadius = 15
        startConfettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        startConfettiLottie.layer.shadowOpacity = 1

        // MARK: NEW SYSTEM:

        newSystemButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: configurationImage), for: .normal)
        newSystemButton.tintColor = .colorWhite
        newSystemButton.addTarget(self, action: #selector(newSystemButtonTapped), for: .touchUpInside)

        // MARK: EMPTY SYSTEM VIEW:

        emptySystemButton.backgroundColor = .colorCell
        emptySystemButton.setTitle(NSLocalizedString("System empty message / system", comment: ""), for: .normal)
        emptySystemButton.setTitleColor(.colorWhite, for: .normal)
        emptySystemButton.setTitleColor(.systemBlue, for: .highlighted)
        emptySystemButton.titleLabel?.font = AppFont.medium(size: 12).uiFont
        emptySystemButton.titleLabel?.numberOfLines = 0
        emptySystemButton.titleLabel?.textAlignment = .center
        emptySystemButton.layer.cornerRadius = cornerRadius15
        emptySystemButton.layer.shadowRadius = 75
        emptySystemButton.layer.shadowColor = UIColor.colorLightBlue.cgColor
        emptySystemButton.layer.shadowOpacity = 0.5

        startConfettiLottie.isHidden = true
        startSystemLottie.isHidden = true
        startConfettiButton.isHidden = true
        emptySystemButton.isHidden = true
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SystemCell.self, forCellReuseIdentifier: "SystemCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }

    // MARK: - LOAD SYSTEM FROM REALM:

    private func loadSystem() {
        arraySystemsRealm = realmManager.localRealm.objects(SystemClassRealm.self).map { $0 }
    }

    // MARK: - LOAD CANOPIES FROM REALM:

    private func loadCanopies() {
        arrayCanopiesRealm = realmManager.localRealm.objects(CanopyClassRealm.self).map { $0 }
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(playConfetti))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    private func startConfigureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let startConfettiGesture = UITapGestureRecognizer(target: self, action: #selector(startPlayConfetti))
        startConfettiGesture.numberOfTapsRequired = 3
        startConfettiButton.addGestureRecognizer(startConfettiGesture)
    }

    // MARK: CONFIGURE SYSTEMS:

    private func startSystems() {
        if arraySystemsRealm.count == 0 {
            startConfettiLottie.isHidden = false
            startSystemLottie.isHidden = false
            startConfettiButton.isHidden = false
            emptySystemButton.isHidden = false

            effectOneLottie.isHidden = true
            confettiLottie.isHidden = true
            systemLottie.isHidden = true
            confettiButton.isHidden = true
            tableView.isHidden = true
            newSystemButton.isHidden = false
        } else {
            startConfettiLottie.isHidden = true
            startSystemLottie.isHidden = true
            startConfettiButton.isHidden = true
            emptySystemButton.isHidden = true

            confettiLottie.isHidden = false
            effectOneLottie.isHidden = false
            systemLottie.isHidden = false
            confettiButton.isHidden = false
            tableView.isHidden = false
            newSystemButton.isHidden = false
        }
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func playConfetti() {
        VibrationManager.instance.vibrationSucces()
        confettiLottie.play()
    }

    @objc private func startPlayConfetti() {
        VibrationManager.instance.vibrationSucces()
        startConfettiLottie.play()
    }

    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("System deleted / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }

    // MARK: TRANSITION ON NEW SYSTEM VC:

    @objc private func newSystemButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let navigationController = navigationController else { return }
        let newSystemVC = NewSystemVC()
        navigationController.pushViewController(newSystemVC, animated: true)
    }
}

// MARK: - EXTENSION:

extension SystemVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arraySystemsRealm.count
    }

    // MARK: COSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SystemCell", for: indexPath) as? SystemCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        let system = arraySystemsRealm[indexPath.row]
        cell.indexPath = indexPath
        cell.configure(system)

        // MARK: TRANSITION ON EDIT VIEW CONTROLLER:

        cell.tapEditButton = { [weak self] in
            guard let self = self else { return }
            let editSystemViewController = EditSystemVC()
            editSystemViewController.indexPath = indexPath.row
            self.navigationController?.pushViewController(editSystemViewController, animated: true)
        }
        cell.delegate = self
        return cell
    }

    // MARK: DELETE CELL:

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        VibrationManager.instance.vibrationStandart()
        let deleteSystem = arraySystemsRealm[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete system?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                try? self.realmManager.localRealm.write {
                    self.realmManager.localRealm.delete(deleteSystem)
                }
                self.loadSystem()
                self.startSystems()
                tableView.reloadData()
                VibrationManager.instance.vibrationSucces()
                self.alertKitSuccess()
            }))
            present(alertDelete, animated: true)
            completion(true)
        }
        if let trashImage = UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) {
            deleteAction.image = trashImage
        }
        deleteAction.backgroundColor = .colorBackground
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK: - EXTENSION:

extension SystemVC: SystemCellDelegate {
    func tapCommentButton(_ indexPath: IndexPath) {
        var comment = ""
        if arraySystemsRealm[indexPath.row].comment == "" {
            comment = NSLocalizedString("No comment", comment: "")
        } else {
            comment = arraySystemsRealm[indexPath.row].comment
        }

        let alert = UIAlertController(title: NSLocalizedString("Comment", comment: "") + ":",
                                      message: "\n" + comment,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }
}
