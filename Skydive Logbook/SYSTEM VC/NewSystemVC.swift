import Lottie
import UIKit

final class NewSystemVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let manualButton = UIBarButtonItem()
    private let newSystemLottie = LottieAnimationView(name: "NewParachute")
    private let tableView = UITableView()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewSystemCell.self, forCellReuseIdentifier: "NewSystemCell")
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - ADD SUBVIEWS:

    func addSubviews() {
        view.addSubviews(newSystemLottie, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
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

    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = colorBackground
        
        // MARK: NAVIGATION RIGHT BUTTON:

        let manualButton = UIBarButtonItem(image: UIImage(systemName: "book.pages.fill"), style: .plain, target: self, action: #selector(tapOnManualButton))
        navigationItem.rightBarButtonItem = manualButton
        navigationItem.backButtonTitle = ""
        
        // MARK: ANIMATION:
        
        newSystemLottie.play()
        newSystemLottie.loopMode = .loop
        
        // MARK: TABLE VIEW:
        
        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }
    
    // MARK: - MANUAL ALERT:

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
        6. Количество применений (в случае если парашют покупался не новым и на нем уже были совершены прыжки - укажите это количество)
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

extension NewSystemVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT CELLS:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewSystemCell", for: indexPath) as? NewSystemCell else { return UITableViewCell() }
        return cell
    }
}
