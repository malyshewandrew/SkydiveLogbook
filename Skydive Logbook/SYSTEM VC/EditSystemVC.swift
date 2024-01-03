import Lottie
import UIKit

final class EditSystemVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let manualButton = UIBarButtonItem()
    private let newSystemLottie = LottieAnimationView(name: "NewParachute")
    private let tableView = UITableView()
    var indexPath: Int = 0

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureNotificationCenter()
        configureTableView()
    }
    
    // MARK: - ADD SUBVIEWS:

    func addSubviews() {
        view.addSubviews(newSystemLottie, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: ANIMATION:
        
        newSystemLottie.translatesAutoresizingMaskIntoConstraints = false
        newSystemLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        newSystemLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newSystemLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        newSystemLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: newSystemLottie.bottomAnchor, constant: 10).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = colorBackground
        
        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false
        let manualButton = UIBarButtonItem(image: UIImage(systemName: "book.pages.fill"), style: .plain, target: self, action: #selector(tapOnManualButton))
        navigationItem.rightBarButtonItem = manualButton
        navigationItem.backButtonTitle = ""
        
        // MARK: ANIMATION:
        
        newSystemLottie.play()
        newSystemLottie.loopMode = .loop
    }
    
    // MARK: - CONFIGURE TABLE VIEW:
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditSystemCell.self, forCellReuseIdentifier: "EditSystemCell")
        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
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
    
    // MARK: - HELPERS:
    
    // MARK: MANUAL ALERT:

    @objc private func tapOnManualButton() {
        let alert = UIAlertController(title: "Добавление системы:", message: """
        \nРанец:\n
        1. Название и модель ранца
        2. Дата изготовления
        3. Серийный номер
        4. Гарантийный ресурс (обычно производитель указывает 10-20 лет, либо по техническому состоянию)
        \nСтрахующий прибор:\n
        1. Название и модель прибора
        2. Дата изготовления
        3. Серийный номер
        4. Гарантийный ресурс (гарантийное количество лет, либо количество лет до регламентных работ)
        \nОсновной парашют:\n
        1. Название и модель парашюта
        2. Дата изготовления
        3. Серийный номер
        4. Гарантийный ресурс по годам (обычно производитель указывает 10-20 лет, либо по техническому состоянию)
        5. Гарантийный ресурс по прыжкам (обычно производитель указывает 500 прыжков, либо по техническому состоянию до 1000 прыжков)
        6. Количество применений (в случае если парашют покупался не новым и на нем уже были совершены прыжки - укажите это количество). Для корректного подсчета - тут необходимо указать только то количество прыжков, которые не были ранее записаны в общий список прыжков этого приложения
        \nЗапасной парашют:\n
        1. Название и модель парашюта
        2. Дата изготовления
        3. Серийный номер
        4. Гарантийный ресурс (обычно производитель указывает 10-20 лет, либо по техническому состоянию)
        5. В случае если парашют покупался не новым и на нем уже были совершены укладки - укажите это количество
        6. Дата укладки
        """, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - EXTENSION:

extension EditSystemVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT CELLS:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditSystemCell", for: indexPath) as? EditSystemCell else { return UITableViewCell() }
        cell.configure(arraySystem[self.indexPath])
        cell.delegate = self
        return cell
    }
}

// MARK: EXTENSION FOR UPDATE SYSTEM:

extension EditSystemVC: EditSystemCellDelegate {
    func saveSystem(_ system: SystemStructure) {
        arraySystem.remove(at: indexPath)
        arraySystem.insert(system, at: indexPath)
        navigationController?.popViewController(animated: true)
    }
}
