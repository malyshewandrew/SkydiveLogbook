import RealmSwift
import UIKit
import UniformTypeIdentifiers

final class BackupVC: UIViewController {
    // MARK: - PROPERTIES:
        
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
        view.addSubviews(infoView, infoLabel, backupButton, restoreButton)
    }
        
    // MARK: - CONFIGURE CONSTRAINTS:
        
    private func configureConstraints() {
        // MARK: INFO LABEL:

        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
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
        backupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
            
        // MARK: RESTORE BUTTON:
            
        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restoreButton.centerYAnchor.constraint(equalTo: backupButton.bottomAnchor, constant: 50).isActive = true
    }
        
    // MARK: - CONFIGURE UI:
        
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground

        // MARK: NAVIAGTION CONTROLLER:

        navigationController?.navigationBar.isHidden = false
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""
        
        // MARK: INFO VIEW:
        
        infoView.backgroundColor = #colorLiteral(red: 0.04016558453, green: 0.1143882051, blue: 0.171395421, alpha: 1)
        infoView.layer.cornerRadius = 10
        infoView.layer.shadowRadius = 50
        infoView.layer.shadowColor = colorBlueCG
        infoView.layer.shadowOpacity = 0.5
            
        // MARK: INFO LABEL:

        infoLabel.textColor = .white
        infoLabel.font = .systemFont(ofSize: 12, weight: .regular, width: .standard)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.text = NSLocalizedString("Info / backup", comment: "")
        
        // MARK: BACKUP BUTTON:
        
        backupButton.backgroundColor = .red
        backupButton.setTitleColor(.green, for: .normal)
        backupButton.setTitle(NSLocalizedString("Backup / backup", comment: ""), for: .normal)
        backupButton.addTarget(self, action: #selector(createBackup), for: .touchUpInside)
            
        // MARK: RESTORE BUTTON:
            
        restoreButton.backgroundColor = .red
        restoreButton.setTitleColor(.green, for: .normal)
        restoreButton.setTitle(NSLocalizedString("Restore / backup", comment: ""), for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreBackup), for: .touchUpInside)
    }
        
    // MARK: - BACKUP AND RESTORE METHODS:
        
    @objc private func createBackup() {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: arrayJumpsRealm.map { $0.toDictionary() }, options: .prettyPrinted)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
            let currentDateTime = dateFormatter.string(from: Date())
            let fileName = "backup_\(currentDateTime).json"

            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let backupPath = documentsDirectory.appendingPathComponent(fileName)

            try jsonData.write(to: backupPath, options: .atomic)

            let activityViewController = UIActivityViewController(activityItems: [backupPath], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)

            print("Копия данных успешно создана и предоставлена пользователю для сохранения.")
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

        // Проверяем существование файла
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

            // Восстанавливаем данные из JSON
            let decodedData = unwrappedJsonArray.compactMap { JumpClassRealm(value: $0) }

            // Очищаем текущий массив и добавляем в него восстановленные данные
            arrayJumpsRealm.removeAll()
            arrayJumpsRealm.append(contentsOf: decodedData)

            print("Восстановленные данные: \(arrayJumpsRealm)")

            // Сохраняем восстановленные данные обратно в Realm
            try realmManager.localRealm.write {
                realmManager.localRealm.deleteAll() // Очищаем все существующие данные в Realm
                realmManager.localRealm.add(arrayJumpsRealm) // Добавляем восстановленные данные в Realm
            }

            // Обновите ваш интерфейс, как описано ранее
            // Например, если у вас есть таблица, то вызовите reloadData()
            // yourTableView.reloadData()
        } catch {
            print("Ошибка при операции с копией данных: \(error)")
        }
    }

    private func createBackupCopy(from sourceURL: URL) throws {
        // Получаем директорию для сохранения файла
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
        // Создаем уникальное имя файла на основе времени
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let currentDateTime = dateFormatter.string(from: Date())
        let fileName = "backup_\(currentDateTime).realm"
            
        // Создаем копию данных и сохраняем в Realm
        let backupPath = documentsDirectory.appendingPathComponent(fileName)
            
        try FileManager.default.copyItem(at: sourceURL, to: backupPath)
        try realmManager.localRealm.writeCopy(toFile: backupPath)
    }
        
    private func restoreBackupCopy(from sourceURL: URL) throws {
        // Получаем директорию для временного файла
        let tempDirectory = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
        // Создаем копию данных в директории приложения
        let destinationURL = tempDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        
        // Проверяем существование файла
        guard FileManager.default.fileExists(atPath: sourceURL.path) else {
            throw NSError(domain: "FileNotFoundError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Файл не найден"])
        }
        
        // Пытаемся скопировать файл
        do {
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
        } catch let copyError {
            print("Ошибка при копировании файла: \(copyError)")
            throw copyError
        }

        // Обновляем Realm с использованием скопированных данных
        do {
            var newConfiguration = realmManager.localRealm.configuration
            newConfiguration.fileURL = destinationURL
            
            let newRealm = try Realm(configuration: newConfiguration)
            
            try realmManager.localRealm.write {
                realmManager.localRealm.deleteAll() // Очищаем все существующие данные в Realm
                realmManager.localRealm.add(newRealm.objects(JumpClassRealm.self)) // Замените YourObjectType на тип объекта в вашей Realm-базе данных
            }
            
            print("Копия данных успешно восстановлена в Realm.")
        } catch let realmError {
            print("Ошибка при записи копии данных в Realm: \(realmError)")
            throw realmError
        }
    }
}
