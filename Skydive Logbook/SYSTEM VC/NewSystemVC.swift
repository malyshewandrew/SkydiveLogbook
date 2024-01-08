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
        configureTableView()
        configureNotificationCenter()
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
        tableView.register(NewSystemCell.self, forCellReuseIdentifier: "NewSystemCell")
        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }
    
    // MARK: - NOTIFICATION CENTER:

    // MARK: UP AND DOWN KEYBOARD:

    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    // MARK: - MANUAL ALERT:

    @objc private func tapOnManualButton() {
        let alert = UIAlertController(title: NSLocalizedString("Add system alert", comment: "") + ":", message: """
        \n\(NSLocalizedString("Container alert", comment: "")):\n
        1. \(NSLocalizedString("Name and model container alert", comment: ""))
        2. \(NSLocalizedString("DOM alert", comment: ""))
        3. \(NSLocalizedString("Serial number alert", comment: ""))
        4. \(NSLocalizedString("Warranty resource container alert", comment: ""))
        \n\(NSLocalizedString("AAD alert", comment: "")):\n
        1. \(NSLocalizedString("Name and model AAD alert", comment: ""))
        2. \(NSLocalizedString("DOM alert", comment: ""))
        3. \(NSLocalizedString("Serial number alert", comment: ""))
        4. \(NSLocalizedString("Warranty resource AAD alert", comment: ""))
        \n\(NSLocalizedString("Main canopy alert", comment: "")):\n
        1. \(NSLocalizedString("Name and model main canopy alert", comment: ""))
        2. \(NSLocalizedString("DOM alert", comment: ""))
        3. \(NSLocalizedString("Serial number alert", comment: ""))
        4. \(NSLocalizedString("Warranty resource main canopy alert", comment: ""))
        5. Гарантийный ресурс по прыжкам (обычно производитель указывает 500 прыжков, либо по техническому состоянию до 1000 прыжков)
        6. Количество применений (в случае если парашют покупался не новым и на нем уже были совершены прыжки - укажите это количество). Для корректного подсчета - тут необходимо указать только то количество прыжков, которые не были ранее записаны в общий список прыжков этого приложения
        \n\(NSLocalizedString("Reserve canopy alert", comment: "")):\n
        1. \(NSLocalizedString("Name and model reserve canopy alert", comment: ""))
        2. \(NSLocalizedString("DOM alert", comment: ""))
        3. \(NSLocalizedString("Serial number alert", comment: ""))
        4. \(NSLocalizedString("Warranty resource reserve canopy alert", comment: ""))
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
