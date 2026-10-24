import Lottie
import UIKit

final class EditJumpVC: UIViewController {
    // MARK: - PROPERTIES:

    private let newJumpLottie = LottieAnimationView(name: "EditJump")
    private let confettiLottie = LottieAnimationView(name: "NewJumpConfetti")
    private let confettiButton = UIButton()
    private let tableView = UITableView()
    private let realmManager = RealmManager()
    var indexPath: Int = 0

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        configureGestures()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNotificationCenter()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, tableView, newJumpLottie, confettiButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION NEW JUMP LOTTIE:

        newJumpLottie.translatesAutoresizingMaskIntoConstraints = false
        newJumpLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newJumpLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        newJumpLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newJumpLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: newJumpLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: newJumpLottie.centerYAnchor).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: newJumpLottie.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false

        // MARK: ANIMATIONS:

        newJumpLottie.play()
        newJumpLottie.loopMode = .autoReverse
        
        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1
    }

    // MARK: CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditJumpCell.self, forCellReuseIdentifier: "EditJumpCell")
        tableView.backgroundColor = .colorBackground
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confettiButtonTapped))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - NOTIFICATION CENTER:

    // MARK: UP AND DOWN KEYBOARD:

    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: KEYBOARD UP:

    @objc private func keyboardShow(_ notification: Notification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.cgRectValue.height, right: 0)
            tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                self.view.layoutIfNeeded()
            }
        }
    }

    // MARK: KEYBOARD DOWN:

    @objc private func keyboardHide() {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func confettiButtonTapped() {
        VibrationManager.instance.vibrationSucces()
        confettiLottie.play()
    }

    // MARK: - LOAD JUMPS FROM REALM:

    private func loadJumps() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map { $0 }
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension EditJumpVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditJumpCell", for: indexPath) as? EditJumpCell else { return UITableViewCell() }
        cell.configure(arrayJumpsRealm[self.indexPath])
        cell.delegate = self
        return cell
    }
}

// MARK: EXTENSION FOR UPDATE EDIT JUMP:

extension EditJumpVC: EditJumpCellDelegate {
    func saveJump(_ jump: JumpClassRealm) {
        let deleteJump = arrayJumpsRealm[indexPath]
        try? realmManager.localRealm.write {
            realmManager.localRealm.delete(deleteJump)
        }
        try? realmManager.localRealm.write {
            realmManager.localRealm.add(jump, update: .modified)
        }
        loadJumps()
        navigationController?.popViewController(animated: true)
    }
}
