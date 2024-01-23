import AlertKit
import AVFoundation
import Lottie
import RealmSwift
import UIKit

final class NotesVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let notesLottie = LottieAnimationView(name: "Notes")
    private let confettiLottie = LottieAnimationView(name: "NotesConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let noteButton = UIButton()
    private let noteTextView = UITextView()
    private let saveButton = UIButton()
    private let cleanButton = UIButton()
    private let tableView = UITableView()
    private var player = AVAudioPlayer()
    private let realmManager = RealmManager()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        configureGestures()
        loadNotes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, notesLottie, confettiButton, noteButton, noteTextView, tableView, saveButton, cleanButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION NOTES LOTTIE:

        notesLottie.translatesAutoresizingMaskIntoConstraints = false
        notesLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notesLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        notesLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        notesLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: notesLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: notesLottie.centerYAnchor).isActive = true
        confettiLottie.heightAnchor.constraint(equalToConstant: 300).isActive = true
        confettiLottie.widthAnchor.constraint(equalToConstant: 300).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: NOTE BUTTON:

        noteButton.translatesAutoresizingMaskIntoConstraints = false
        noteButton.topAnchor.constraint(equalTo: notesLottie.bottomAnchor, constant: 10).isActive = true
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
        tableView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 30).isActive = true
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

        // MARK: ANIMATIONS:

        notesLottie.play()
        notesLottie.loopMode = .autoReverse

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        // MARK: NOTE BUTTON:

        noteButton.backgroundColor = .colorCell
        noteButton.setTitle("\(NSLocalizedString("New note", comment: "") + ":")", for: .normal)
        noteButton.setTitleColor(.colorLightGray, for: .normal)
        noteButton.contentVerticalAlignment = textAligmentTop
        noteButton.titleLabel?.font = fontBoldStandard14
        noteButton.layer.cornerRadius = cornerRadius10

        // MARK: TEXT VIEW:

        noteTextView.backgroundColor = .colorTabBar
        noteTextView.layer.cornerRadius = cornerRadius10
        noteTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        noteTextView.font = fontMediumStandard14
        noteTextView.textColor = .colorWhite

        // MARK: SAVE BUTTON:

        saveButton.backgroundColor = .colorCell
        saveButton.titleLabel?.font = fontMediumStandard14
        saveButton.setTitleColor(.colorWhite, for: .normal)
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = cornerRadius10
        saveButton.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)

        // MARK: CLEAN BUTTON:

        cleanButton.backgroundColor = .colorTabBar
        cleanButton.titleLabel?.font = fontMediumStandard14
        cleanButton.setTitleColor(.colorWhite, for: .normal)
        cleanButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
        cleanButton.layer.cornerRadius = cornerRadius10
        cleanButton.addTarget(self, action: #selector(tapOnCleanButton), for: .touchUpInside)
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotesCell.self, forCellReuseIdentifier: "NotesCell")
        tableView.backgroundColor = .colorBackground
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)

        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnConfettiButton))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - HELPERS:

    // MARK: ACTION FOR TAP ON SAVE BUTTON:

    @objc private func tapOnSaveButton() {
        guard noteTextView.text != "" else {
            actionButtonSaveRedColor()
            alertKitError()
            return
        }
        saveNewNote()
    }

    // MARK: SAVE AND ADD NEW NOTE IN ARRAY NOTES:

    private func saveNewNote() {
        let newNote = NoteClassRealm()
        
        newNote.note = noteTextView.text ?? ""
        
        actionButtonSaveGreenColor()
        noteTextView.resignFirstResponder()
        noteTextView.text = ""
        tableView.reloadData()
        playSoundSucces()
        alertKitSuccess()
        
        try? realmManager.localRealm.write {
            realmManager.localRealm.add(newNote, update: .all)
        }
        
        loadNotes()
        tableView.reloadData()
    }

    // MARK: ACTION FOR TAP ON CLEAN BUTTON:

    @objc private func tapOnCleanButton() {
        noteTextView.text = ""
        actionButtonCleanChangeColor()
        tableView.reloadData()
        noteTextView.resignFirstResponder()
        alertKitSuccess()
    }
    
    // MARK: - LOAD NOTES FROM REALM:
    
    private func loadNotes() {
        arrayNotesRealm = realmManager.localRealm.objects(NoteClassRealm.self).map {
            $0
        }
    }

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func tapOnConfettiButton() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
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
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }

    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc func tapGestureDone() {
        view.endEditing(true)
    }

    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / cell new jump", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }

    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / cell new jump", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
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
        cell.configure(text: note.note)
        return cell
    }

    // MARK: DELETE CELL:

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteNote = arrayNotesRealm[indexPath.row]
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete note?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                
                try? self.realmManager.localRealm.write {
                    self.realmManager.localRealm.delete(deleteNote)
                }
                
                self.loadNotes()

                self.vibrationOn.vibrationSucces()
                tableView.reloadData()
                self.alertKitSuccess()
            }))
            present(alertDelete, animated: true)
        }
    }
}
