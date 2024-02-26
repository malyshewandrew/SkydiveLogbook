import AlertKit
import Lottie
import RealmSwift
import UIKit
import UniformTypeIdentifiers

final class BackupVC: UIViewController {
    // MARK: - PROPERTIES:

    private let backupLottie = LottieAnimationView(name: "Backup")
    private let infoView = UIView()
    private let infoLabel = UILabel()
    private let backupButton = UIButton()
    private let restoreButton = UIButton()
    private let realmManager = RealmManager()
    private let vibrationOn = Vibration()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(backupLottie, infoView, infoLabel, backupButton, restoreButton)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: ANIMATION:

        backupLottie.translatesAutoresizingMaskIntoConstraints = false
        backupLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backupLottie.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: 0).isActive = true
        backupLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        backupLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true

        // MARK: INFO LABEL:

        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
        infoView.heightAnchor.constraint(greaterThanOrEqualTo: infoLabel.heightAnchor, constant: 10).isActive = true
        infoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: FIRST MESSAGE LABEL:

        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10).isActive = true

        // MARK: BACKUP BUTTON:

        backupButton.translatesAutoresizingMaskIntoConstraints = false
        backupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backupButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true
        backupButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        backupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: RESTORE BUTTON:

        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restoreButton.topAnchor.constraint(equalTo: backupButton.bottomAnchor, constant: 15).isActive = true
        restoreButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        restoreButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIAGTION CONTROLLER:

        navigationController?.navigationBar.isHidden = false
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""

        // MARK: ANIMATION:

        backupLottie.play()
        backupLottie.loopMode = .loop

        // MARK: INFO VIEW:

        infoView.backgroundColor = .colorCell
        infoView.layer.cornerRadius = cornerRadius15
        infoView.layer.shadowRadius = 50
        infoView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        infoView.layer.shadowOpacity = 0.3

        // MARK: INFO LABEL:

        infoLabel.textColor = .colorWhite
        infoLabel.font = .systemFont(ofSize: 12, weight: .regular, width: .standard)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.text = NSLocalizedString("Info / backup", comment: "")

        // MARK: BACKUP BUTTON:

        backupButton.setTitle(NSLocalizedString("Backup / backup", comment: ""), for: .normal)
        backupButton.setTitleColor(.colorWhite, for: .normal)
        backupButton.backgroundColor = .colorBlue
        backupButton.layer.cornerRadius = cornerRadius15
        backupButton.titleLabel?.font = fontMediumStandard14
        backupButton.titleLabel?.numberOfLines = 0
        backupButton.titleLabel?.textAlignment = .center
        backupButton.titleLabel?.adjustsFontSizeToFitWidth = true
        backupButton.addTarget(self, action: #selector(createBackup), for: .touchUpInside)

        // MARK: RESTORE BUTTON:

        restoreButton.setTitle(NSLocalizedString("Restore / backup", comment: ""), for: .normal)
        restoreButton.setTitleColor(.colorWhite, for: .normal)
        restoreButton.backgroundColor = .colorTabBar
        restoreButton.layer.cornerRadius = cornerRadius15
        restoreButton.titleLabel?.font = fontMediumStandard14
        restoreButton.titleLabel?.numberOfLines = 0
        restoreButton.titleLabel?.textAlignment = .center
        restoreButton.titleLabel?.adjustsFontSizeToFitWidth = true
        restoreButton.addTarget(self, action: #selector(restoreBackup), for: .touchUpInside)
    }
    
    // MARK: - ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Backup saved / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: - ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
    
    // MARK: - ALERT KIT UPLOAD:

    private func alertKitUpload() {
        AlertKitAPI.present(
            title: NSLocalizedString("Backup upload / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }

    // MARK: - BACKUP AND RESTORE METHODS:

    @objc private func createBackup() {
        vibrationOn.vibrationStandart()
        do {
            var combinedData: [String: Any] = [:]
            combinedData["jumps"] = arrayJumpsRealm.map { $0.toDictionary() }
            combinedData["notes"] = arrayNotesRealm.map { $0.toDictionary() }
            combinedData["account"] = arrayAccountRealm.map { $0.toDictionary() }
            combinedData["locations"] = arrayLocationsRealm.map { $0.toDictionary() }
            combinedData["aircrafts"] = arrayAircraftsRealm.map { $0.toDictionary() }
            combinedData["canopies"] = arrayCanopiesRealm.map { $0.toDictionary() }
            combinedData["systems"] = arraySystemsRealm.map { $0.toDictionary() }
            let combinedDataJSON = try JSONSerialization.data(withJSONObject: combinedData, options: .prettyPrinted)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let currentDateTime = dateFormatter.string(from: Date())
            let fileName = "\(arrayJumpsRealm.count) jumps: (\(currentDateTime)).json"
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let backupPath = documentsDirectory.appendingPathComponent(fileName)
            try combinedDataJSON.write(to: backupPath, options: .atomic)
            let activityViewController = UIActivityViewController(activityItems: [backupPath], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
                if completed {
                    self.alertKitSuccess()
                } else {
                    self.alertKitError()
                }
            }
            present(activityViewController, animated: true, completion: nil)
            print("КОПИЯ ДАННЫХ УСПЕШНО СОЗДАНА И ПРЕДОСТАВЛЕНА ПОЛЬЗОВАТЕЛЮ ДЛЯ СОХРАНЕНИЯ.")
        } catch {
            print("Ошибка при создании и сохранении копии данных: \(error)")
            self.alertKitError()
        }
    }

    @objc private func restoreBackup() {
        vibrationOn.vibrationStandart()
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data], asCopy: true)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
}

// MARK: - EXTENSION:

extension BackupVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let sourceURL = urls.first else {
            print("Ошибка: URL выбранного файла nil.")
            self.alertKitError()
            return
        }
        guard FileManager.default.fileExists(atPath: sourceURL.path) else {
            print("Ошибка: Файл по выбранному URL не существует.")
            self.alertKitError()
            return
        }
        do {
            let data = try Data(contentsOf: sourceURL)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let unwrappedJsonObject = jsonObject else {
                print("Ошибка: Неверный формат JSON.")
                self.alertKitError()
                return
            }
            if let jumpsData = unwrappedJsonObject["jumps"] as? [[String: Any]] {
                let decodedJumps = jumpsData.compactMap { JumpClassRealm(value: $0) }
                arrayJumpsRealm.removeAll()
                arrayJumpsRealm.append(contentsOf: decodedJumps)
            }
            if let notesData = unwrappedJsonObject["notes"] as? [[String: Any]] {
                let decodedNotes = notesData.compactMap { NoteClassRealm(value: $0) }
                arrayNotesRealm.removeAll()
                arrayNotesRealm.append(contentsOf: decodedNotes)
            }
            if let accountData = unwrappedJsonObject["account"] as? [[String: Any]] {
                let decodedAccount = accountData.compactMap { AccountClassRealm(value: $0) }
                arrayAccountRealm.removeAll()
                arrayAccountRealm.append(contentsOf: decodedAccount)
            }
            if let locationsData = unwrappedJsonObject["locations"] as? [[String: Any]] {
                let decodedLocations = locationsData.compactMap { LocationClassRealm(value: $0) }
                arrayLocationsRealm.removeAll()
                arrayLocationsRealm.append(contentsOf: decodedLocations)
            }
            if let aircraftsData = unwrappedJsonObject["aircrafts"] as? [[String: Any]] {
                let decodedAircrafts = aircraftsData.compactMap { AircraftClassRealm(value: $0) }
                arrayAircraftsRealm.removeAll()
                arrayAircraftsRealm.append(contentsOf: decodedAircrafts)
            }
            if let canopiesData = unwrappedJsonObject["canopies"] as? [[String: Any]] {
                let decodedCanopies = canopiesData.compactMap { CanopyClassRealm(value: $0) }
                arrayCanopiesRealm.removeAll()
                arrayCanopiesRealm.append(contentsOf: decodedCanopies)
            }
            if let systemsData = unwrappedJsonObject["systems"] as? [[String: Any]] {
                let decodedSystems = systemsData.compactMap { SystemClassRealm(value: $0) }
                arraySystemsRealm.removeAll()
                arraySystemsRealm.append(contentsOf: decodedSystems)
            }
            print("Восстановленные данные: \(arrayJumpsRealm) + \(arrayNotesRealm) + \(arrayAccountRealm) + \(arrayLocationsRealm) + \(arrayAircraftsRealm) + \(arrayCanopiesRealm) + \(arraySystemsRealm)")
            try realmManager.localRealm.write {
                realmManager.localRealm.deleteAll()
                realmManager.localRealm.add(arrayJumpsRealm)
                realmManager.localRealm.add(arrayNotesRealm)
                realmManager.localRealm.add(arrayAccountRealm)
                realmManager.localRealm.add(arrayLocationsRealm)
                realmManager.localRealm.add(arrayAircraftsRealm)
                realmManager.localRealm.add(arrayCanopiesRealm)
                realmManager.localRealm.add(arraySystemsRealm)
            }
            self.alertKitUpload()
        } catch {
            print("Ошибка при операции с копией данных: \(error)")
            self.alertKitError()
        }
    }
}
