import UIKit
import UniformTypeIdentifiers
import RealmSwift

final class BackupVC: UIViewController {
    // MARK: - PROPERTIES:

    // Добавляем ссылку на Realm
    private let realm = try! Realm()

    // MARK: - UI ELEMENTS:

    private lazy var backupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать копию", for: .normal)
        button.addTarget(self, action: #selector(createBackup), for: .touchUpInside)
        return button
    }()

    private lazy var restoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Загрузить копию", for: .normal)
        button.addTarget(self, action: #selector(restoreBackup), for: .touchUpInside)
        return button
    }()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        backupButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restoreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - BACKUP AND RESTORE METHODS:

    @objc private func createBackup() {
        do {
            // Создаем уникальное имя файла на основе времени
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
            let currentDateTime = dateFormatter.string(from: Date())
            let fileName = "backup_\(currentDateTime).realm"

            // Получаем директорию для сохранения файла
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

            // Создаем копию данных и сохраняем в Realm
            let backupPath = documentsDirectory.appendingPathComponent(fileName)

            try realm.writeCopy(toFile: backupPath)

            // Создаем ActivityViewController для предоставления пользователю возможности сохранения файла
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

extension BackupVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let sourceURL = urls.first else { return }

        do {
            if controller.allowsMultipleSelection {
                // Режим сохранения копии данных
                try createBackupCopy(from: sourceURL)

                print("Копия данных успешно создана и предоставлена пользователю для сохранения.")
            } else {
                // Режим восстановления копии данных
                try restoreBackupCopy(from: sourceURL)

                print("Копия данных успешно восстановлена из \(sourceURL.absoluteString).")
            }
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
        try realm.writeCopy(toFile: backupPath)
    }

    private func restoreBackupCopy(from sourceURL: URL) throws {
        // Получаем директорию для временного файла
        let tempDirectory = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        // Создаем копию данных в директории приложения
        let destinationURL = tempDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)

        // Обновляем Realm с использованием скопированных данных
        try realm.writeCopy(toFile: destinationURL)
    }
}
