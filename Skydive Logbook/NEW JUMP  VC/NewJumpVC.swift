import Lottie
import UIKit

final class NewJumpVC: UIViewController {
    // MARK: - PROPERTIES:

    private let newJumpLottie = LottieAnimationView(name: "NewJump")
    private let confettiLottie = LottieAnimationView(name: "NewJumpConfetti")
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
        configureNotificationCenter()
        configureGestures()
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
        newJumpLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        newJumpLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        newJumpLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: newJumpLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: newJumpLottie.centerYAnchor).isActive = true
        confettiLottie.heightAnchor.constraint(equalToConstant: 300).isActive = true
        confettiLottie.widthAnchor.constraint(equalToConstant: 300).isActive = true

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
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true

        // MARK: ANIMATIONS:

        newJumpLottie.play()
        newJumpLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = colorBlueCG
        confettiLottie.layer.shadowOpacity = 1
    }
    
    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewJumpCell.self, forCellReuseIdentifier: "NewJumpCell")
        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }
    
    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnConfetti))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - NOTIFICATION CENTER:

    // MARK: UP AND DOWN KEYBOARD:

    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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

    // MARK: - FUNC FOR CONFETTI + VIBRATION:

    @objc private func tapOnConfetti() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension NewJumpVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewJumpCell", for: indexPath) as? NewJumpCell else { return UITableViewCell() }
        return cell
    }
}
