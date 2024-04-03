import Adapty
import Lottie
import RealmSwift
import UIKit

final class NewJumpVC: UIViewController {
    // MARK: - PROPERTIES:

    private let newJumpLottie = LottieAnimationView(name: "NewJump")
    private let confettiLottie = LottieAnimationView(name: "NewJumpConfetti")
    private let effectOneLottie = LottieAnimationView(name: "")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let oneJump: String = NSLocalizedString("One jump / cell new jump", comment: "")
    private let moreJumps: String = NSLocalizedString("Few jumps / cell new jump", comment: "")
    private var segmentControl = UISegmentedControl()
    private let firstTableView = UITableView()
    private let secondTableView = UITableView()

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
        segmentControl.selectedSegmentIndex = 0
        segmentedControlValueChanged(segmentControl)
        configureNotificationCenter()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, effectOneLottie, segmentControl, firstTableView, secondTableView, newJumpLottie, confettiButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: EFFECT ONE LOTTIE:
        
        effectOneLottie.translatesAutoresizingMaskIntoConstraints = false
        effectOneLottie.centerXAnchor.constraint(equalTo: newJumpLottie.centerXAnchor).isActive = true
        effectOneLottie.centerYAnchor.constraint(equalTo: newJumpLottie.centerYAnchor).isActive = true
        effectOneLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.5).isActive = true
        
        // MARK: ANIMATION NEW JUMP LOTTIE:

        newJumpLottie.translatesAutoresizingMaskIntoConstraints = false
        newJumpLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newJumpLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        newJumpLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        newJumpLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: newJumpLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: newJumpLottie.centerYAnchor).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: SEGMENT CONTROL:

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: newJumpLottie.bottomAnchor).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: TABLE VIEW:

        firstTableView.translatesAutoresizingMaskIntoConstraints = false
        firstTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15).isActive = true
        firstTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        firstTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        firstTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: MORE TABLE VIEW:

        secondTableView.translatesAutoresizingMaskIntoConstraints = false
        secondTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15).isActive = true
        secondTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        secondTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        secondTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        
        // MARK: EFFECT LOTTIE:
        
        effectOneLottie.play()
        effectOneLottie.loopMode = .loop
        effectOneLottie.animationSpeed = 0.2

        // MARK: ANIMATIONS:

        newJumpLottie.play()
        newJumpLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        // MARK: SEGMENT CONTROL:

        segmentControl.insertSegment(withTitle: oneJump, at: 0, animated: true)
        segmentControl.insertSegment(withTitle: moreJumps, at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .colorCell
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        firstTableView.delegate = self
        firstTableView.dataSource = self
        firstTableView.register(NewJumpCell.self, forCellReuseIdentifier: "NewJumpCell")
        firstTableView.backgroundColor = .colorBackground
        firstTableView.separatorStyle = .none

        secondTableView.delegate = self
        secondTableView.dataSource = self
        secondTableView.register(NewMoreJumpCell.self, forCellReuseIdentifier: "NewMoreJumpCell")
        secondTableView.backgroundColor = .colorBackground
        secondTableView.separatorStyle = .none
        secondTableView.isHidden = true
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confettiTapped))
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
            firstTableView.contentInset = contentInsets
            firstTableView.scrollIndicatorInsets = contentInsets
            secondTableView.contentInset = contentInsets
            secondTableView.scrollIndicatorInsets = contentInsets
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                self.view.layoutIfNeeded()
            }
        }
    }

    // MARK: KEYBOARD DOWN:

    @objc private func keyboardHide() {
        firstTableView.contentInset = .zero
        firstTableView.scrollIndicatorInsets = .zero
        secondTableView.contentInset = .zero
        secondTableView.scrollIndicatorInsets = .zero
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - HELPERS:

    // MARK: SEGMENT CONTROL VALUE CHANGED:

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstTableView.isHidden = false
            secondTableView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            secondTableView.isHidden = false
            firstTableView.isHidden = true
        }
    }

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func confettiTapped() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension NewJumpVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return 1
        } else {
            return 1
        }
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewJumpCell", for: indexPath) as? NewJumpCell else { return UITableViewCell() }
            cell.showAlert = { [weak self] in
                let alert = UIAlertController(title: NSLocalizedString("Add new jump / new jump", comment: "") + ":", message: "\n\(NSLocalizedString("Manual / new jump", comment: ""))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
                self?.present(alert, animated: true)
            }
            cell.showPaymentAlert = { [weak self] in
                let alert = UIAlertController(title: NSLocalizedString("Alert / adapty status", comment: ""), message: "\n\(NSLocalizedString("Message / adapty status", comment: ""))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
                    cell.resignFirstResponder()
                }))
                self?.present(alert, animated: true)
            }
            return cell
        } else if tableView == secondTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewMoreJumpCell", for: indexPath) as? NewMoreJumpCell else { return UITableViewCell() }
            cell.showAlert = { [weak self] in
                let alert = UIAlertController(title: NSLocalizedString("Add new jump / new jump", comment: "") + ":", message: "\n\(NSLocalizedString("Manual / new jump", comment: ""))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
                self?.present(alert, animated: true)
            }
            cell.showPaymentAlert = { [weak self] in
                let alert = UIAlertController(title: NSLocalizedString("Alert / adapty status", comment: ""), message: "\n\(NSLocalizedString("Message / adapty status", comment: ""))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
                    cell.resignFirstResponder()
                }))
                self?.present(alert, animated: true)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
