import AlertKit
import Lottie
import RealmSwift
import UIKit
import ShimmerSwift

final class SystemVC: UIViewController {
    // MARK: - PROPERTIES:

    private let backgroundFlowersLottie = LottieAnimationView(name: "EmptyFlowersLottie")
    private let blackView = UIView()
    private let systemLottie = LottieAnimationView(name: "EmptySystem")
    private let confettiLottie = LottieAnimationView(name: "SystemConfetti")
    private let effectOneLottie = LottieAnimationView(name: "EffectSystem")
    private let emptyConfettiLottie = LottieAnimationView(name: "SystemConfetti")
    private let confettiButton = UIButton()
    private let emptyConfettiButton = UIButton()
    private let tableView = UITableView()
    private let emptySystemLottie = LottieAnimationView(name: "EmptySystem")
    private var emptySystemButton = UIButton()
    private let emptySystemShimmer = ShimmeringView()
    private let emptyNewSystemButton = UIButton()
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
        tabBarController?.tabBar.isHidden = false
        loadSystem()
        loadCanopies()
        startSystems()
        startConfigureGestures()
        tableView.reloadData()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(backgroundFlowersLottie, blackView, confettiLottie, effectOneLottie, emptyConfettiLottie, systemLottie, emptySystemLottie, confettiButton, emptyConfettiButton, tableView, emptySystemButton, emptyNewSystemButton, emptySystemShimmer, newSystemButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: BACKGROUND FLOWERS LOTTIE:
        
        backgroundFlowersLottie.translatesAutoresizingMaskIntoConstraints = false
        backgroundFlowersLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundFlowersLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: BLACK VIEW:

        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        blackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
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

        emptySystemLottie.translatesAutoresizingMaskIntoConstraints = false
        emptySystemLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptySystemLottie.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        emptySystemLottie.heightAnchor.constraint(equalToConstant: 125).isActive = true
        emptySystemLottie.widthAnchor.constraint(equalToConstant: 125).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: systemLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: systemLottie.centerYAnchor, constant: -10).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: START ANIMATION LOTTIE CONFETTI:

        emptyConfettiLottie.translatesAutoresizingMaskIntoConstraints = false
        emptyConfettiLottie.centerXAnchor.constraint(equalTo: emptySystemLottie.centerXAnchor).isActive = true
        emptyConfettiLottie.centerYAnchor.constraint(equalTo: emptySystemLottie.centerYAnchor, constant: -10).isActive = true
        emptyConfettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: systemLottie.centerXAnchor).isActive = true
        confettiButton.centerYAnchor.constraint(equalTo: systemLottie.centerYAnchor).isActive = true
        confettiButton.heightAnchor.constraint(equalTo: systemLottie.heightAnchor, multiplier: 1).isActive = true
        confettiButton.widthAnchor.constraint(equalTo: systemLottie.widthAnchor, multiplier: 1).isActive = true

        // MARK: START BUTTON FOR ANIMATION LOTTIE CONFETTI:

        emptyConfettiButton.translatesAutoresizingMaskIntoConstraints = false
        emptyConfettiButton.centerXAnchor.constraint(equalTo: emptySystemLottie.centerXAnchor).isActive = true
        emptyConfettiButton.centerYAnchor.constraint(equalTo: emptySystemLottie.centerYAnchor).isActive = true
        emptyConfettiButton.heightAnchor.constraint(equalTo: emptySystemLottie.heightAnchor, multiplier: 1).isActive = true
        emptyConfettiButton.widthAnchor.constraint(equalTo: emptySystemLottie.widthAnchor, multiplier: 1).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: systemLottie.bottomAnchor, constant: 5).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: NEW SYSTEM:

        newSystemButton.translatesAutoresizingMaskIntoConstraints = false
        newSystemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        newSystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // MARK: EMPTY SYSTEM BUTTON:

        emptySystemButton.translatesAutoresizingMaskIntoConstraints = false
        emptySystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptySystemButton.topAnchor.constraint(equalTo: emptySystemLottie.bottomAnchor, constant: 20).isActive = true
        emptySystemButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        emptySystemButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: EMPTY NEW SYSTEM BUTTON:
        
        emptyNewSystemButton.translatesAutoresizingMaskIntoConstraints = false
        emptyNewSystemButton.topAnchor.constraint(equalTo: emptySystemButton.bottomAnchor, constant: 15).isActive = true
        emptyNewSystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""
        
        // MARK: BACKGROUND FLOWERS LOTTIE:
        
        backgroundFlowersLottie.isHidden = true
        backgroundFlowersLottie.play()
        backgroundFlowersLottie.loopMode = .loop
        backgroundFlowersLottie.animationSpeed = 0.3
        backgroundFlowersLottie.contentMode = .scaleAspectFill
        
        // MARK: BLACK VIEW:

        blackView.backgroundColor = .black
        blackView.layer.opacity = 0.5

        // MARK: EFFECT LOTTIE:

        effectOneLottie.play()
        effectOneLottie.loopMode = .loop
        effectOneLottie.animationSpeed = 0.5
        effectOneLottie.layer.opacity = 0.7

        // MARK: ANIMATION SYSTEM LOTTIE:

        systemLottie.play()
        systemLottie.loopMode = .autoReverse

        // MARK: ANIMATION START SYSTEM LOTTIE:

        emptySystemLottie.play()
        emptySystemLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        emptyConfettiLottie.layer.shadowRadius = 15
        emptyConfettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        emptyConfettiLottie.layer.shadowOpacity = 1

        // MARK: NEW SYSTEM:

        newSystemButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: configurationImage), for: .normal)
        newSystemButton.tintColor = .colorWhite
        newSystemButton.addTarget(self, action: #selector(newSystemButtonTapped), for: .touchUpInside)

        // MARK: EMPTY SYSTEM VIEW:

        emptySystemButton.backgroundColor = .colorCell
        emptySystemButton.setTitle(NSLocalizedString("System empty message / system", comment: ""), for: .normal)
        emptySystemButton.setTitleColor(.colorWhite, for: .normal)
        emptySystemButton.setTitleColor(.systemBlue, for: .highlighted)
        emptySystemButton.titleLabel?.font = FontManager.medium(size: 12).uiFont
        emptySystemButton.titleLabel?.numberOfLines = 0
        emptySystemButton.titleLabel?.textAlignment = .center
        emptySystemButton.layer.cornerRadius = cornerRadius15
        emptySystemButton.layer.shadowRadius = 75
        emptySystemButton.layer.shadowColor = UIColor.colorLightBlue.cgColor
        emptySystemButton.layer.shadowOpacity = 0.5
        ShimmerManager.instance.addShimmerEffect(shimmerView: emptySystemShimmer, toView: emptySystemButton, speed: 75)
        
        // MARK: EMPTY NEW SYSTEM BUTTON:
        
        emptyNewSystemButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: configurationImage), for: .normal)
        emptyNewSystemButton.tintColor = .colorWhite
        emptyNewSystemButton.addTarget(self, action: #selector(newSystemButtonTapped), for: .touchUpInside)

        emptyConfettiLottie.isHidden = true
        emptySystemLottie.isHidden = true
        emptyConfettiButton.isHidden = true
        emptySystemButton.isHidden = true
        emptyNewSystemButton.isHidden = true
        newSystemButton.isHidden = true
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
        startConfettiGesture.numberOfTapsRequired = 1
        emptyConfettiButton.addGestureRecognizer(startConfettiGesture)
    }

    // MARK: CONFIGURE SYSTEMS:

    private func startSystems() {
        if arraySystemsRealm.count == 0 {
            backgroundFlowersLottie.isHidden = true
            blackView.isHidden = false
            
            emptyConfettiLottie.isHidden = false
            emptySystemLottie.isHidden = false
            emptyConfettiButton.isHidden = false
            emptySystemButton.isHidden = false
            emptyNewSystemButton.isHidden = false
            newSystemButton.isHidden = true

            effectOneLottie.isHidden = true
            confettiLottie.isHidden = true
            systemLottie.isHidden = true
            confettiButton.isHidden = true
            tableView.isHidden = true
        } else {
            backgroundFlowersLottie.isHidden = true
            blackView.isHidden = true
            
            emptyConfettiLottie.isHidden = true
            emptySystemLottie.isHidden = true
            emptyConfettiButton.isHidden = true
            emptySystemButton.isHidden = true
            emptyNewSystemButton.isHidden = true

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
        emptyConfettiLottie.play()
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
        
        if arrayCanopiesRealm.isEmpty {
            let alert = UIAlertController(title: NSLocalizedString("Error / alert kit", comment: "") + ":", message: "\n\(NSLocalizedString("Add new system alert / system", comment: ""))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            present(alert, animated: true)
            return
        }
        
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
