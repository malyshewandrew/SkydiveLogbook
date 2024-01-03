import Lottie
import UIKit

final class SystemVC: UIViewController {
    // MARK: - PROPERTIES:

    private let systemLottie = LottieAnimationView(name: "Parachute")
    private let confettiLottie = LottieAnimationView(name: "SystemConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let tableView = UITableView()
    private let newSystemButton = UIButton()
    private var selectedSystem: SystemStructure?
    private var indexSysytem: Int = 0

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
        navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, systemLottie, confettiButton, tableView, newSystemButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION SYSTEM LOTTIE:

        systemLottie.translatesAutoresizingMaskIntoConstraints = false
        systemLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        systemLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        systemLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        systemLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: systemLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: systemLottie.centerYAnchor, constant: -10).isActive = true
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
        tableView.topAnchor.constraint(equalTo: systemLottie.bottomAnchor, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: newSystemButton.topAnchor, constant: -10).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: NEW SYSTEM:

        newSystemButton.translatesAutoresizingMaskIntoConstraints = false
        newSystemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        newSystemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newSystemButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        newSystemButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""

        // MARK: ANIMATIONS:

        systemLottie.play()
        systemLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = colorBlueCG
        confettiLottie.layer.shadowOpacity = 1

        // MARK: NEW SYSTEM:

        newSystemButton.backgroundColor = colorCell
        newSystemButton.layer.cornerRadius = 10
        newSystemButton.setTitle("Добавить новую систему", for: .normal)
        newSystemButton.titleLabel?.font = fontMediumStandart14
        newSystemButton.setTitleColor(.white, for: .normal)
        newSystemButton.addTarget(self, action: #selector(tapOnNewSystemButton), for: .touchUpInside)
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SystemCell.self, forCellReuseIdentifier: "SystemCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = colorBackground
    }
    
    // MARK: - CONFIGURE GESTURES:
    
    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(playConfetti))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - TRANSITION ON NEW SYSTEM VC:
    
    @objc private func tapOnNewSystemButton() {
        let newSystemVC = NewSystemVC()
        navigationController?.pushViewController(newSystemVC, animated: true)
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func playConfetti() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}

// MARK: - EXTENSION:

extension SystemVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arraySystem.count
    }

    // MARK: COSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SystemCell", for: indexPath) as? SystemCell else { return UITableViewCell() }
        let system = arraySystem[indexPath.row]
        cell.indexPath = indexPath
        cell.configure(system)

        // MARK: TRANSITION ON EDIT VIEW CONTROLLER:

        cell.tapEditButton = { [weak self] in
            let editSystemViewController = EditSystemVC()
            editSystemViewController.indexPath = indexPath.row
            self?.navigationController?.pushViewController(editSystemViewController, animated: true)
        }
        cell.delegate = self
        return cell
    }
    
    // MARK: DELETE CELL:

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete system?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                arraySystem.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.vibrationOn.vibrationSucces()
                tableView.reloadData()
            }))
            present(alertDelete, animated: true)
        }
    }
}

extension SystemVC: SystemCellDelegate {
    func tapCommentButton(_ indexPath: IndexPath) {
        var comment = ""

        if arraySystem[indexPath.row].comment == "" {
            comment = "Комментариев нет"
        } else {
            comment = arraySystem[indexPath.row].comment
        }

        let alert = UIAlertController(title: "Комментарий:",
                                      message: "\n" + comment,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in

        }))
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        present(alert, animated: true)
    }
}
