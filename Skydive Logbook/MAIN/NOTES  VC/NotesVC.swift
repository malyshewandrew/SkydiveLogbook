import Adapty
import AlertKit
import AVFoundation
import Lottie
import RealmSwift
import UIKit
import Network

final class NotesVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let confettiButton = UIButton()
    private let noteButton = UIButton()
    private let noteTextView = UITextView()
    private let saveButton = UIButton()
    private let cleanButton = UIButton()
    private let tableView = UITableView()
    private var player = AVAudioPlayer()
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
        loadNotes()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(noteButton, noteTextView, tableView, cleanButton, saveButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {

        // MARK: NOTE BUTTON:

        noteButton.translatesAutoresizingMaskIntoConstraints = false
        noteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        noteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        noteButton.heightAnchor.constraint(equalTo: noteButton.widthAnchor, multiplier: 0.3).isActive = true

        // MARK: TEXT VIEW:

        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.bottomAnchor.constraint(equalTo: noteButton.bottomAnchor, constant: 0).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: noteButton.leadingAnchor).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: noteButton.trailingAnchor).isActive = true
        noteTextView.heightAnchor.constraint(equalTo: noteButton.heightAnchor, multiplier: 0.70).isActive = true

        // MARK: SAVE BUTTON:

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 15).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.39).isActive = true

        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 15).isActive = true
        cleanButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.39).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true

        // MARK: NOTE BUTTON:

        noteButton.backgroundColor = .colorCell
        noteButton.setTitle("\(NSLocalizedString("New note", comment: "") + ":")", for: .normal)
        noteButton.setTitleColor(.colorLightGray, for: .normal)
        noteButton.contentVerticalAlignment = textAligmentTop
        noteButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        noteButton.layer.cornerRadius = 30

        // MARK: TEXT VIEW:

        noteTextView.backgroundColor = .colorTabBar
        noteTextView.layer.cornerRadius = cornerRadius15
        noteTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        noteTextView.font = FontManager.medium(size: 14).uiFont
        noteTextView.textColor = .colorWhite

        // MARK: CLEAN BUTTON:

        cleanButton.backgroundColor = .colorTabBar
        cleanButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        cleanButton.setTitleColor(.colorWhite, for: .normal)
        cleanButton.setTitleColor(.systemBlue, for: .highlighted)
        cleanButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
        cleanButton.layer.cornerRadius = cornerRadius15
        cleanButton.addTarget(self, action: #selector(cleanButtonTapped), for: .touchUpInside)

        // MARK: SAVE BUTTON:

        saveButton.backgroundColor = .colorCell
        saveButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        saveButton.setTitleColor(.colorWhite, for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .highlighted)
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = cornerRadius15
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotesCell.self, forCellReuseIdentifier: "NotesCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - HELPERS:

    // MARK: ACTION FOR TAP ON SAVE BUTTON:

    @objc private func saveButtonTapped() {
        guard noteTextView.text != "" else {
            actionButtonSaveRedColor()
            alertKitError()
            return
        }
        if arrayNotesRealm.count < 10 {
            saveNewNote()
            DispatchQueue.main.async {
                self.actionButtonSaveGreenColor()
                self.noteTextView.resignFirstResponder()
                self.noteTextView.text = ""
                self.playSoundSucces()
                self.alertKitSuccess()
            }
        } else {
            checkPaymentStatus()
        }
    }

    // MARK: CHECK PAYMENT STATUS:

    private func checkPaymentStatus() {
        Adapty.getProfile { result in
            Task { @MainActor in
                if let profile = try? result.get(),
                   profile.accessLevels["premium"]?.isActive ?? false
                {
                    self.saveNewNote()

                    self.actionButtonSaveGreenColor()
                    self.noteTextView.resignFirstResponder()
                    self.noteTextView.text = ""
                    self.playSoundSucces()
                    self.alertKitSuccess()

                    print("SAVE OK: I'm Premium!")
                } else {
                    self.noteTextView.text = ""
                    self.noteTextView.resignFirstResponder()

                    self.alertKitError()
                    self.actionButtonSaveRedColor()
                    self.showPaymentAlert()

                    print("NOT SAVE: I'm NOT Premium!")
                }
            }
        }
    }

    // MARK: SAVE AND ADD NEW NOTE IN ARRAY NOTES:

    private func saveNewNote() {
        let newNote = NoteClassRealm()
        newNote.note = noteTextView.text ?? ""
        try? realmManager.localRealm.write {
            realmManager.localRealm.add(newNote, update: .all)
        }
        loadNotes()
        tableView.reloadData()
    }

    // MARK: ACTION FOR TAP ON CLEAN BUTTON:

    @objc private func cleanButtonTapped() {
        noteTextView.text = ""
        actionButtonCleanChangeColor()
        tableView.reloadData()
        noteTextView.resignFirstResponder()
        alertKitClear()
    }

    // MARK: - LOAD NOTES FROM REALM:

    private func loadNotes() {
        arrayNotesRealm = realmManager.localRealm.objects(NoteClassRealm.self).map { $0 }
    }

    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = .colorCell
        }
    }

    private func actionButtonSaveRedColor() {
        saveButton.backgroundColor = .colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = .colorCell
        }
    }

    private func actionButtonCleanChangeColor() {
        cleanButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanButton.backgroundColor = .colorTabBar
        }
    }

    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc private func tapGestureDone() {
        view.endEditing(true)
    }

    // MARK: SHOW PAYMENT ALERT:

    private func showPaymentAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Alert / adapty status", comment: ""), message: "\n\(NSLocalizedString("Message / adapty status", comment: ""))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            checkInternetConnection { [weak self] isConnected in
                guard let self = self else { return }
                if !isConnected {
                    DispatchQueue.main.async {
                        let premiumViewController = PremiumVC()
                        self.present(premiumViewController, animated: true)
                        self.alertKitError()
                    }
                    return
                }
                DispatchQueue.main.async {
                    let paywallViewController = PaywallVC()
                    self.present(paywallViewController, animated: true)
                }
            }
        }))
        present(alert, animated: true)
    }

    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Note added / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }

    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / alert kit", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }

    // MARK: ALERT KIT CLEAR:

    private func alertKitClear() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }

    // MARK: ALERT KIT DELETED:

    private func alertKitDeleted() {
        AlertKitAPI.present(
            title: NSLocalizedString("Note deleted / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: SHOW ALERT WITH MESSAGE:

    private func showAlertWithMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: CHECK INTERNET CONNECTION:
    
    private func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
            monitor.cancel()
        }
        
        monitor.start(queue: queue)
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension NotesVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayNotesRealm.count
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as? NotesCell else { return UITableViewCell() }
        let note = arrayNotesRealm[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(text: note.note, background: .clear)
        return cell
    }

    // MARK: DELETE CELL:
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        VibrationManager.instance.vibrationStandart()
        let deleteNote = arrayNotesRealm[indexPath.row]
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            let alertDelete = UIAlertController(
                title: NSLocalizedString("Delete note?", comment: ""),
                message: NSLocalizedString("This action cannot be undone.", comment: ""),
                preferredStyle: .alert
            )
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                try? self.realmManager.localRealm.write {
                    self.realmManager.localRealm.delete(deleteNote)
                }
                self.loadNotes()
                tableView.reloadData()
                self.alertKitDeleted()
            }))
            self.present(alertDelete, animated: true)
            completion(true)
        }
        if let trashImage = UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) {
            deleteAction.image = trashImage
        }
        let cellRect = tableView.rectForRow(at: indexPath)
        let cellHeight = cellRect.height
        let actionWidth = cellRect.width
        let size = CGSize(width: actionWidth / 5.5, height: cellHeight)
        let renderer = UIGraphicsImageRenderer(size: size)
        let roundedImage = renderer.image { ctx in }
        deleteAction.backgroundColor = UIColor(patternImage: roundedImage)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
