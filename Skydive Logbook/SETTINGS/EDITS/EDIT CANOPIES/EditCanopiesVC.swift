import AVFoundation
import Lottie
import UIKit
import RealmSwift
import AlertKit

final class EditCanopiesVC: UIViewController {
    // MARK: - PROPERTIES:

    private let editCanopyLottie = LottieAnimationView(name: "Canopies")
    private let editCanopyButton = UIButton(type: .system)
    private let enterTextTextField = UITextField()
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
        enterTextTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCanopies()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(editCanopyLottie, editCanopyButton, editCanopyButton, enterTextTextField, saveButton, cleanButton, tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: EDIT CANOPY LOTTIE:

        editCanopyLottie.translatesAutoresizingMaskIntoConstraints = false
        editCanopyLottie.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        editCanopyLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editCanopyLottie.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        editCanopyLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        // MARK: EDIT CANOPY BUTTON:
        
        editCanopyButton.translatesAutoresizingMaskIntoConstraints = false
        editCanopyButton.topAnchor.constraint(equalTo: editCanopyLottie.topAnchor).isActive = true
        editCanopyButton.bottomAnchor.constraint(equalTo: editCanopyLottie.bottomAnchor).isActive = true
        editCanopyButton.leadingAnchor.constraint(equalTo: editCanopyLottie.leadingAnchor).isActive = true
        editCanopyButton.trailingAnchor.constraint(equalTo: editCanopyLottie.trailingAnchor).isActive = true

        // MARK: TEXT VIEW:

        enterTextTextField.translatesAutoresizingMaskIntoConstraints = false
        enterTextTextField.topAnchor.constraint(equalTo: editCanopyLottie.bottomAnchor, constant: 5).isActive = true
        enterTextTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enterTextTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        enterTextTextField.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true

        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.topAnchor.constraint(equalTo: enterTextTextField.bottomAnchor, constant: 15).isActive = true
        cleanButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true
        
        // MARK: SAVE BUTTON:

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: enterTextTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false

        // MARK: EDIT CANOPY LOTTIE:

        editCanopyLottie.loopMode = .loop
        editCanopyLottie.play()
        
        // MARK: EDIT CANOPY BUTTON:
        
        editCanopyButton.addTarget(self, action: #selector(editCanopyButtonTapped), for: .touchUpInside)

        // MARK: TEXT VIEW:

        enterTextTextField.backgroundColor = .colorTabBar
        enterTextTextField.textColor = .colorWhite
        enterTextTextField.layer.cornerRadius = cornerRadius15
        enterTextTextField.textAlignment = textAligmentCenter
        enterTextTextField.placeholder = NSLocalizedString("Enter canopy", comment: "")

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
        tableView.register(EditCanopiesCell.self, forCellReuseIdentifier: "EditCanopiesCell")
        tableView.backgroundColor = .colorBackground
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - LOAD CANOPIES FROM REALM:
    
    private func loadCanopies() {
        arrayCanopiesRealm = realmManager.localRealm.objects(CanopyClassRealm.self).map { $0 }
    }

    // MARK: - HELPERS:
    
    // MARK: EDIT CANOPY BUTTON TAPPED:
    
    @objc private func editCanopyButtonTapped() {
        VibrationManager.instance.vibrationStandart()
    }

    // MARK: ACTION FOR TAP ON SAVE BUTTON:

    @objc private func saveButtonTapped() {
        guard enterTextTextField.text != "" else {
            actionButtonSaveRedColor()
            alertKitError()
            return
        }
        saveNewCanopy()
    }
    
    // MARK: SAVE AND ADD NEW CANOPY IN ARRAY CANOPIES:

    private func saveNewCanopy() {
        let newCanopy = CanopyClassRealm()
        newCanopy.canopy = enterTextTextField.text ?? ""
        try? realmManager.localRealm.write {
            realmManager.localRealm.add(newCanopy, update: .all)
        }
        actionButtonSaveGreenColor()
        enterTextTextField.resignFirstResponder()
        enterTextTextField.text = ""
        tableView.reloadData()
        playSoundSucces()
        alertKitSuccess()
        loadCanopies()
        tableView.reloadData()
    }

    // MARK: ACTION FOR TAP ON CLEAN BUTTON:

    @objc private func cleanButtonTapped() {
        enterTextTextField.text = ""
        actionButtonCleanChangeColor()
        tableView.reloadData()
        alertKitClear()
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
    
    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Canopy added / alert kit", comment: ""),
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
            haptic: .error
        )
    }
    
    // MARK: ALERT KIT DELETED:
    
    private func alertKitDeleted() {
        AlertKitAPI.present(
            title: NSLocalizedString("Canopy deleted / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
}

// MARK: - EXTENSIONS:

extension EditCanopiesVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNTS OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCanopiesRealm.count
    }

    // MARK: COSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditCanopiesCell", for: indexPath) as? EditCanopiesCell else { return UITableViewCell() }

        let canopy = arrayCanopiesRealm[indexPath.row]
        cell.configure(text: canopy.canopy)

        return cell
    }

    // MARK: DELETE CELL:

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        VibrationManager.instance.vibrationStandart()
        let deleteCanopy = arrayCanopiesRealm[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete canopy?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                try? self.realmManager.localRealm.write {
                    self.realmManager.localRealm.delete(deleteCanopy)
                }
                self.loadCanopies()
                VibrationManager.instance.vibrationSucces()
                tableView.reloadData()
                self.alertKitDeleted()
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

// MARK: - EXTENSION FOR TEXT FIELD DELEGATE: MAX COUNT OF CHARECTERS:

extension EditCanopiesVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let range = Range(range, in: text) else {
            return false
        }
        let newText = text.replacingCharacters(in: range, with: string)
        return newText.count <= 20
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        VibrationManager.instance.vibrationStandart()
    }
}
