import AudioToolbox
import AVFoundation
import Lottie
import UIKit

final class MainVC: UIViewController {
    // MARK: - PROPERTIES:

    private let loadingView = UIView()
    private let loadingLottie = LottieAnimationView(name: "Loading")
    private let mainLottie = LottieAnimationView(name: "Main")
    private let mainStartLottie = LottieAnimationView(name: "Main")
    private let confettiLottie = LottieAnimationView(name: "MainConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let stackView = UIStackView()
    private let medicineLabel = UILabel()
    private let insuranceLabel = UILabel()
    private let reserveCanopyLabel = UILabel()
    private let notesImage = UIImageView()
    private let notesButton = UIButton()
    private let nicknameLabel = UILabel()
    private let tableView = UITableView()
    private let firstMessageView = UIView()
    private let firstMessageLabel = UILabel()
    private var selectedJump: JumpStructure?

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        configureGestures()
        firstMessage()
        configureAccount()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureAccount()
        firstMessage()
        tableView.reloadData()
        sortArray()
        arrayJumps.reverse()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(mainLottie, confettiLottie, confettiButton, stackView, notesImage, notesButton, nicknameLabel, tableView, firstMessageView, firstMessageLabel, mainStartLottie, loadingView)
        stackView.addArrangedSubviews(medicineLabel, insuranceLabel, reserveCanopyLabel)
        loadingView.addSubview(loadingLottie)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: LOADING VIEW:

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // MARK: LOADING LOTTIE:

        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingLottie.topAnchor.constraint(equalTo: loadingView.topAnchor).isActive = true
        loadingLottie.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor).isActive = true
        loadingLottie.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor).isActive = true
        loadingLottie.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor).isActive = true

        // MARK: ANIMATION MAIN LOTTIE:

        mainLottie.translatesAutoresizingMaskIntoConstraints = false
        mainLottie.translatesAutoresizingMaskIntoConstraints = false
        mainLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        mainLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        mainLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: mainLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor).isActive = true
        confettiLottie.heightAnchor.constraint(equalToConstant: 300).isActive = true
        confettiLottie.widthAnchor.constraint(equalToConstant: 300).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: STACK VIEW:

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -2).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true

        // MARK: MEDICINE LABEL:

        medicineLabel.translatesAutoresizingMaskIntoConstraints = false
        medicineLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        medicineLabel.heightAnchor.constraint(equalToConstant: 8).isActive = true

        // MARK: INSURANCE LABEL:

        insuranceLabel.translatesAutoresizingMaskIntoConstraints = false
        insuranceLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        insuranceLabel.heightAnchor.constraint(equalToConstant: 8).isActive = true

        // MARK: RESERVE CANOPY LABEL:

        reserveCanopyLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        reserveCanopyLabel.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        // MARK: NOTES IMAGE:
        
        notesImage.translatesAutoresizingMaskIntoConstraints = false
        notesImage.bottomAnchor.constraint(equalTo: nicknameLabel.topAnchor, constant: -5).isActive = true
        notesImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: NOTES BUTTON:
        notesButton.translatesAutoresizingMaskIntoConstraints = false
        notesButton.bottomAnchor.constraint(equalTo: nicknameLabel.topAnchor, constant: 5).isActive = true
        notesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        notesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        notesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        

        // MARK: NICKNAME LABEL:

        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -2).isActive = true
        nicknameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nicknameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        nicknameLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mainLottie.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: LOADING VIEW:

        loadingView.backgroundColor = colorBackground

        // MARK: LOADING LOTTIE:

        loadingLottie.play()
        loadingLottie.loopMode = .loop
        loadingLottie.contentMode = .center
        loadingLottie.layer.shadowRadius = 100
        loadingLottie.layer.shadowColor = colorBlueCG
        loadingLottie.layer.shadowOpacity = 0.5
        perform(#selector(hideAnimation), with: nil, afterDelay: 2) // closed loading lottie after 2.5 sec.

        // MARK: CONFETTI LOTTIE:
        
        confettiLottie.layer.shadowRadius = 20
        confettiLottie.layer.shadowColor = colorBlueCG
        confettiLottie.layer.shadowOpacity = 1
        
        // MARK: MAIN LOTTIE:

        mainLottie.play()
        mainLottie.loopMode = .autoReverse

        // MARK: VIEW:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = colorBackground

        // MARK: STACK VIEW:

        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .bottom
        stackView.distribution = .equalSpacing

        // MARK: MEDICINE LABEL:

        medicineLabel.font = fontStackView
        medicineLabel.textColor = colorWhite
        medicineLabel.textAlignment = .left
        medicineLabel.adjustsFontSizeToFitWidth = true

        // MARK: INSURANCE LABEL:

        insuranceLabel.font = fontStackView
        insuranceLabel.textColor = colorWhite
        insuranceLabel.textAlignment = .left
        insuranceLabel.adjustsFontSizeToFitWidth = true

        // MARK: RESERVE CANOPY LABEL:

        reserveCanopyLabel.font = fontStackView
        reserveCanopyLabel.textColor = colorWhite
        reserveCanopyLabel.textAlignment = .left
        reserveCanopyLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: NOTES IMAGE:
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        notesImage.image = UIImage(systemName: "book.pages.fill", withConfiguration: configuration)
        notesImage.tintColor = colorWhite
        
        // MARK: NOTES BUTTON:
        notesButton.addTarget(self, action: #selector(tapOnNotesButton), for: .touchUpInside)

        // MARK: NICKNAME LABEL:

        nicknameLabel.font = fontBoldStandart10
        nicknameLabel.textColor = colorWhite
        nicknameLabel.textAlignment = .right
        nicknameLabel.adjustsFontSizeToFitWidth = true

        // MARK: TABLE VIEW:

        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.isHidden = true
    }
    
    // MARK: - TRANSITION ON NOTES VIEW CONTROLLER:
    
    @objc private func tapOnNotesButton() {
        let notesViewController = NotesVC()
        present(notesViewController, animated: true, completion: nil)
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR PLAY ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confetti))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - FIRST MESSAGE:

    private func firstMessage() {
        mainLottie.isHidden = true
        confettiLottie.isHidden = true
        confettiButton.isHidden = true
        stackView.isHidden = true
        nicknameLabel.isHidden = true
        notesImage.isHidden = true
        notesButton.isHidden = true

        // MARK: ANIMATION MAIN LOTTIE:

        mainStartLottie.translatesAutoresizingMaskIntoConstraints = false
        mainStartLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStartLottie.bottomAnchor.constraint(equalTo: firstMessageView.topAnchor, constant: -30).isActive = true
        mainStartLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        mainStartLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true

        // MARK: FIRST MESSAGE VIEW:

        firstMessageView.translatesAutoresizingMaskIntoConstraints = false
        firstMessageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstMessageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        firstMessageView.heightAnchor.constraint(greaterThanOrEqualTo: firstMessageLabel.heightAnchor, constant: 10).isActive = true
        firstMessageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true

        firstMessageView.backgroundColor = #colorLiteral(red: 0.04016558453, green: 0.1143882051, blue: 0.171395421, alpha: 1)
        firstMessageView.layer.cornerRadius = 10
        firstMessageView.layer.shadowRadius = 100
        firstMessageView.layer.shadowColor = colorBlueCG
        firstMessageView.layer.shadowOpacity = 0.5

        // MARK: FIRST MESSAGE LABEL:

        firstMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        firstMessageLabel.centerXAnchor.constraint(equalTo: firstMessageView.centerXAnchor).isActive = true
        firstMessageLabel.centerYAnchor.constraint(equalTo: firstMessageView.centerYAnchor).isActive = true
        firstMessageLabel.leadingAnchor.constraint(equalTo: firstMessageView.leadingAnchor, constant: 10).isActive = true
        firstMessageLabel.trailingAnchor.constraint(equalTo: firstMessageView.trailingAnchor, constant: -10).isActive = true

        firstMessageLabel.textColor = .white
        firstMessageLabel.font = .systemFont(ofSize: 12, weight: .regular, width: .standard)
        firstMessageLabel.numberOfLines = 0
        firstMessageLabel.textAlignment = .center
        firstMessageLabel.adjustsFontSizeToFitWidth = true
        firstMessageLabel.text = NSLocalizedString("First Message", comment: "")

        if arrayJumps.count == 0 {
            firstMessageView.isHidden = false
            firstMessageLabel.isHidden = false
            mainStartLottie.isHidden = false
            mainStartLottie.play()
            mainStartLottie.loopMode = .autoReverse
        } else {
            mainStartLottie.isHidden = true
            firstMessageView.isHidden = true
            firstMessageLabel.isHidden = true

            mainLottie.isHidden = false
            confettiLottie.isHidden = false
            confettiButton.isHidden = false
            stackView.isHidden = false
            nicknameLabel.isHidden = false
            notesImage.isHidden = false
            notesButton.isHidden = false
        }
    }
    


    // MARK: - CONFIGURE USER:

    // MARK: NICKNAME LABEL:

    private func configureAccount() {
        if arrayAccount.count == 0 {
            nicknameLabel.text = ""
        } else {
            if arrayAccount[0].nickname.isEmpty {
                nicknameLabel.isHidden = true
            } else {
                nicknameLabel.isHidden = false
                nicknameLabel.text = arrayAccount[0].nickname
            }
        }

        // MARK: MEDICINE LABEL:

        if arrayAccount.count == 0 {
            medicineLabel.text = ""
        } else {
            if arrayAccount[0].medicine == "" {
                medicineLabel.isHidden = true
            } else {
                medicineLabel.isHidden = false
                medicineLabel.text = "Медицина до: " + arrayAccount[0].medicine
            }
        }

        // MARK: INSURANCE LABEL:

        if arrayAccount.count == 0 {
            insuranceLabel.text = ""
        } else {
            if arrayAccount[0].insurance == "" {
                insuranceLabel.isHidden = true
            } else {
                insuranceLabel.isHidden = false
                insuranceLabel.text = "Страховка до: " + arrayAccount[0].insurance
            }
        }

        // MARK: RESERVE CANOPY LABEL:

        if arrayAccount.count == 0 {
            reserveCanopyLabel.text = ""
        } else {
            if arrayAccount[0].reserveCanopy == "" {
                reserveCanopyLabel.isHidden = true
            } else {
                reserveCanopyLabel.isHidden = false
                reserveCanopyLabel.text = "Запасной до: " + arrayAccount[0].reserveCanopy
            }
        }
    }

    // MARK: SORT ARRAY:

    private func sortArray() {
        arrayJumps.sort { jump1, jump2 -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let date1 = dateFormatter.date(from: jump1.date), let date2 = dateFormatter.date(from: jump2.date) {
                return date1 < date2
            }
            return false
        }
    }
        
    // MARK: - HELPERS:

    // MARK: FUNC FOR PLAY CONFETTI + VIBRATION:

    @objc private func confetti() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
    
    // MARK: FUNC FOR CLOSED LOADING LOTTIE:

    @objc private func hideAnimation() {
        tableView.isHidden = false
        tabBarController?.tabBar.isHidden = false
        loadingView.removeFromSuperview()
        loadingLottie.removeFromSuperview()
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayJumps.count
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else { return UITableViewCell() }

        let jump = arrayJumps[indexPath.row]
        cell.configure(number: String(arrayJumps.count - indexPath.row), date: jump.date, location: jump.location, aircraft: jump.aircraft, canopy: jump.canopy, mission: jump.mission, height: jump.height, time: jump.time, cutaway: jump.cutaway, comment: jump.comment)
        return cell
    }

    // MARK: TRANSSITION ON "JUMP VIEW CONTROLLER":

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jump = arrayJumps[indexPath.row]
        let jumpViewController = JumpVC(selectedJump: jump)
        selectedJump = jump
        jumpViewController.jumpNumber = arrayJumps.count - indexPath.row
        let navigationController = UINavigationController(rootViewController: jumpViewController)
        present(navigationController, animated: true, completion: nil)
        print("test")
    }

    // MARK: COSTUM SWIPE RIGHT (DELETE AND EDIT):

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: DELETE JUMP:

        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            
            // MARK: DELETE JUMP:
            
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete jump?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                arrayJumps.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .middle)
                self.vibrationOn.vibrationSucces()
                tableView.reloadData()
                self.firstMessage()
            }))
            self.present(alertDelete, animated: true)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed

        // MARK: EDIT JUMP:

        let editAction = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            let editJumpViewController = EditJumpVC()
            editJumpViewController.indexPath = indexPath.row
            self.navigationController?.pushViewController(editJumpViewController, animated: true)
            completion(true)
        }
        editAction.image = UIImage(systemName: "slider.horizontal.2.square")
        editAction.backgroundColor = .systemBlue

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }
}
