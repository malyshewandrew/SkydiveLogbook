import RealmSwift
import UIKit
import Lottie
import UniformTypeIdentifiers
import AlertKit

final class BackupVC: UIViewController {
    // MARK: - PROPERTIES:
        
    private let backupLottie = LottieAnimationView(name: "Backup")
    private let infoView = UIView()
    private let infoLabel = UILabel()
    private let backupButton = UIButton()
    private let restoreButton = UIButton()
    private let realmManager = RealmManager()
        
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
        backupLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
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
        infoView.layer.cornerRadius = 10
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
        backupButton.layer.cornerRadius = cornerRadius10
        backupButton.titleLabel?.font = fontMediumStandart14
        backupButton.titleLabel?.numberOfLines = 0
        backupButton.titleLabel?.textAlignment = .center
        backupButton.titleLabel?.adjustsFontSizeToFitWidth = true
        backupButton.addTarget(self, action: #selector(createBackup), for: .touchUpInside)
        
        // MARK: RESTORE BUTTON:
            
        restoreButton.setTitle(NSLocalizedString("Restore / backup", comment: ""), for: .normal)
        restoreButton.setTitleColor(.colorWhite, for: .normal)
        restoreButton.backgroundColor = .colorTabBar
        restoreButton.layer.cornerRadius = cornerRadius10
        restoreButton.titleLabel?.font = fontMediumStandart14
        restoreButton.titleLabel?.numberOfLines = 0
        restoreButton.titleLabel?.textAlignment = .center
        restoreButton.titleLabel?.adjustsFontSizeToFitWidth = true
        restoreButton.addTarget(self, action: #selector(restoreBackup), for: .touchUpInside)
    }
        
    // MARK: - BACKUP AND RESTORE METHODS:
        
    @objc private func createBackup() {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: arrayJumpsRealm.map { $0.toDictionary() }, options: .prettyPrinted)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy, HH.mm.ss"
            let currentDateTime = dateFormatter.string(from: Date())
            let fileName = "JUMPS (\(currentDateTime)).json"

            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let backupPath = documentsDirectory.appendingPathComponent(fileName)

            try jsonData.write(to: backupPath, options: .atomic)

            let activityViewController = UIActivityViewController(activityItems: [backupPath], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)

            print("КОПИЯ ДАННЫХ УСПЕШНО СОЗДАНА И ПРЕДОСТАВЛЕНА ПОЛЬЗОВАТЕЛЮ ДЛЯ СОХРАНЕНИЯ.")
        } catch {
            print("Ошибка при создании и сохранении копии данных: \(error)")
        }
    }
        
    @objc private func restoreBackup() {
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
            return
        }

        guard FileManager.default.fileExists(atPath: sourceURL.path) else {
            print("Ошибка: Файл по выбранному URL не существует.")
            return
        }

        do {
            let data = try Data(contentsOf: sourceURL)
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]

            guard let unwrappedJsonArray = jsonArray else {
                print("Ошибка: Неверный формат JSON.")
                return
            }

            let decodedData = unwrappedJsonArray.compactMap { JumpClassRealm(value: $0) }

            arrayJumpsRealm.removeAll()
            arrayJumpsRealm.append(contentsOf: decodedData)

            print("Восстановленные данные: \(arrayJumpsRealm)")
            
            AlertKitAPI.present(
                title: NSLocalizedString("Success / cell new jump", comment: ""),
                icon: .done,
                style: .iOS17AppleMusic,
                haptic: .success
            )
            try realmManager.localRealm.write {
                realmManager.localRealm.deleteAll()
                realmManager.localRealm.add(arrayJumpsRealm)
            }
        } catch {
            print("Ошибка при операции с копией данных: \(error)")
        }
    }

    private func createBackupCopy(from sourceURL: URL) throws {
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let currentDateTime = dateFormatter.string(from: Date())
        let fileName = "backup_\(currentDateTime).realm"
        let backupPath = documentsDirectory.appendingPathComponent(fileName)
            
        try FileManager.default.copyItem(at: sourceURL, to: backupPath)
        try realmManager.localRealm.writeCopy(toFile: backupPath)
    }
        
    private func restoreBackupCopy(from sourceURL: URL) throws {
        let tempDirectory = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destinationURL = tempDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        guard FileManager.default.fileExists(atPath: sourceURL.path) else {
            throw NSError(domain: "FileNotFoundError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл не найден"])
        }
        do {
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
        } catch let copyError {
            print("Ошибка при копировании файла: \(copyError)")
            throw copyError
        }
        do {
            var newConfiguration = realmManager.localRealm.configuration
            newConfiguration.fileURL = destinationURL
            
            let newRealm = try Realm(configuration: newConfiguration)
            
            try realmManager.localRealm.write {
                realmManager.localRealm.deleteAll()
                realmManager.localRealm.add(newRealm.objects(JumpClassRealm.self))
            }
            print("Копия данных успешно восстановлена в Realm.")
        } catch let realmError {
            print("Ошибка при записи копии данных в Realm: \(realmError)")
            throw realmError
        }
    }
}
