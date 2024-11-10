import Adapty
import AdaptyUI
import AlertKit
import Lottie
import RealmSwift
import SafariServices
import UIKit
import WebKit
import PDFKit

final class SettingsVC: UIViewController {
    // MARK: - PROPERTIES:

    private let settingsLottie = LottieAnimationView(name: "Settings")
    private let confettiLottie = LottieAnimationView(name: "SettingsConfetti")
    private let effectOneLottie = LottieAnimationView(name: "EffectSettings")
    private let effectTwoLottie = LottieAnimationView(name: "EffectSettings")
    private let backgroundFlowersLottie = LottieAnimationView(name: "EmptyFlowersLottie")
    private let blackView = UIView()
    private let confettiButton = UIButton()
    private let realmManager = RealmManager()
    private let tableView = UITableView()
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
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(backgroundFlowersLottie, blackView, confettiLottie, effectOneLottie, effectTwoLottie, settingsLottie, confettiButton, tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: BACKGROUND FLOWERS LOTTIE:
        
        backgroundFlowersLottie.translatesAutoresizingMaskIntoConstraints = false
        backgroundFlowersLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundFlowersLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: BLACK VIEW:

        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        blackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // MARK: EFFECT ONE LOTTIE:

        effectOneLottie.translatesAutoresizingMaskIntoConstraints = false
        effectOneLottie.centerXAnchor.constraint(equalTo: settingsLottie.centerXAnchor).isActive = true
        effectOneLottie.centerYAnchor.constraint(equalTo: settingsLottie.centerYAnchor, constant: 10).isActive = true
        effectOneLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: EFFECT TWO LOTTIE:

        effectTwoLottie.translatesAutoresizingMaskIntoConstraints = false
        effectTwoLottie.centerXAnchor.constraint(equalTo: settingsLottie.centerXAnchor).isActive = true
        effectTwoLottie.centerYAnchor.constraint(equalTo: settingsLottie.centerYAnchor, constant: 10).isActive = true
        effectTwoLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: ANIMATION SETTINGS LOTTIE:

        settingsLottie.translatesAutoresizingMaskIntoConstraints = false
        settingsLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        settingsLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        settingsLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: settingsLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: settingsLottie.centerYAnchor).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: settingsLottie.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""
        
        // MARK: BACKGROUND FLOWERS LOTTIE:
        
        backgroundFlowersLottie.play()
        backgroundFlowersLottie.loopMode = .loop
        backgroundFlowersLottie.animationSpeed = 0.3
        backgroundFlowersLottie.contentMode = .scaleAspectFill
        
        // MARK: BLACK VIEW:

        blackView.backgroundColor = .black
        blackView.layer.opacity = 0.5

        // MARK: EFFECT ONE LOTTIE:

        effectOneLottie.play()
        effectOneLottie.loopMode = .loop
        effectOneLottie.animationSpeed = 0.5
        effectOneLottie.transform = CGAffineTransform(scaleX: -1, y: -1)

        // MARK: EFFECT TWO LOTTIE:

        effectTwoLottie.play()
        effectTwoLottie.loopMode = .loop
        effectTwoLottie.animationSpeed = 0.5
        effectTwoLottie.transform = CGAffineTransform(scaleX: 1, y: 1)

        // MARK: ANIMATIONS:

        settingsLottie.play()
        settingsLottie.loopMode = .loop

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confettiButtonTapped))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR CONFETTI + VIBRATION:

    @objc private func confettiButtonTapped() {
        VibrationManager.instance.vibrationSucces()
        confettiLottie.play()
    }

    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
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
    
    // MARK: SEND TELEGRAM MESSAGE:
    
    func sendTelegramMessage(message: String) {
        let botToken = "7264425174:AAGOBEeZrrYhQSwrWPcwMURy90kfW65UlSg"
        let chatID = "298098804,"
        
        let messageText = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.telegram.org/bot\(botToken)/sendMessage?chat_id=\(chatID)&text=\(messageText)"
        
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка при отправке сообщения в Telegram: \(error.localizedDescription)")
                return
            }
        }
        
        task.resume()
    }
}

// MARK: - EXTENSION:

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
}

// MARK: - EXTENSIONS:

extension SettingsVC: SettingsCellDelegate {
    
    // MARK: - TAP EDIT ACCOUNT BUTTON:
    
    func tapEditDataButton() {
        let editVC = EditVC()
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    // MARK: - TAP BACKUP BUTTON:

    func tapBackupButton() {
        let backup = BackupVC()
        navigationController?.pushViewController(backup, animated: true)
    }
    
    // MARK: - TAP PRINT BUTTON:
    
    func tapPrintButton() {
        VibrationManager.instance.vibrationStandart()
        let printVC = PrintVC()
        if let sheetController = printVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(printVC, animated: true)
    }
    
    // MARK: - TAP INFO BUTTON:

    func tapInfoButton() {
        let info = InfoVC()
        navigationController?.pushViewController(info, animated: true)
    }

    // MARK: - TAP PREMIUM BUTTON:
    
    func tapPremiumButton() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        Adapty.getPaywall(placementId: "PlacementID", locale: "en") { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(paywall):
                    if paywall.hasViewConfiguration {
                        AdaptyUI.getViewConfiguration(forPaywall: paywall, locale: "en") { result in
                            switch result {
                            case let .success(viewConfiguration):
                                let visualPaywall = AdaptyUI.paywallController(
                                    for: paywall,
                                    viewConfiguration: viewConfiguration,
                                    delegate: self
                                )
                                self.present(visualPaywall, animated: true)
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.removeFromSuperview()
                            case let .failure(error):
                                let premium = PremiumVC()
                                self.navigationController?.pushViewController(premium, animated: true)
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.removeFromSuperview()
                                print(error)
                            }
                        }
                    } else {
                        print("messageError")
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - TAP NOTIFICATIONS BUTTON:
    
    func tapNotificationsButton() {
        let notifications = NotificationsVS()
        if let sheetController = notifications.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(notifications, animated: true, completion: nil)
    }
    
    // MARK: - TAP GAME BUTTON:
    
    func tapGameButton() {
        let game = GameVC()
        navigationController?.pushViewController(game, animated: true)
    }

    // MARK: - TAP INSTAGRAM BUTTON:
    
    func tapInstagramButton() {
        guard let url = URL(string: "https://instagram.com/skydivebook") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
}

// MARK: - EXTENSION FOR SAFARI:

extension SettingsVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}

// MARK: - EXTENSION FOR ADAPTY:

extension SettingsVC: AdaptyPaywallControllerDelegate {
    // MARK: Вызывается при выполнении действия на контроллере оплаты. Метод обрабатывает различные actions:

    func paywallController(_ controller: AdaptyPaywallController, didPerform action: AdaptyUI.Action) {
        switch action {
        case .close:
            dismiss(animated: true)
            print(action)
        case let .custom(id):
            print(id)
        case let .openURL(url: url):
            dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                VibrationManager.instance.vibrationStandart()
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.delegate = self
                self.present(safariViewController, animated: true)
            }
        }
    }

    // MARK: - Вызывается при выборе продукта в контроллере оплаты:

    func paywallController(_ controller: AdaptyPaywallController, didSelectProduct product: AdaptyPaywallProduct) {
        VibrationManager.instance.vibrationStandart()
        print("Selected product: \(product)")
    }

    // MARK: - Вызывается при начале процесса покупки определенного продукта:

    func paywallController(_ controller: AdaptyPaywallController, didStartPurchase product: AdaptyPaywallProduct) {
        VibrationManager.instance.vibrationStandart()
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        print("Started purchase for product: \(product)")
    }

    // MARK: - Вызывается при завершении процесса покупки продукта. Включает информацию о совершенной покупке (purchasedInfo*):

    func paywallController(_ controller: AdaptyPaywallController, didFinishPurchase product: AdaptyPaywallProduct, purchasedInfo: AdaptyPurchasedInfo) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        alertKitSuccess()
        sendTelegramMessage(message: "Новая покупка: \(product.vendorProductId.description)")
        print("Finished purchase for product: \(product)")
        print("Purchased info: \(purchasedInfo)")
    }

    // MARK: - Вызывается при ошибке во время покупки продукта:

    func paywallController(_ controller: AdaptyPaywallController, didFailPurchase product: AdaptyPaywallProduct, error: AdaptyError) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        alertKitError()
        print("Failed to purchase product: \(product)")
        print("Error: \(error)")
    }

    // MARK: - Вызывается при отмене процесса покупки:

    func paywallController(_ controller: AdaptyPaywallController, didCancelPurchase product: AdaptyPaywallProduct) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        alertKitError()
        print("Cancelled purchase for product: \(product)")
    }

    // MARK: - Вызывается при начале восстановления ранее совершенных покупок:

    func paywallControllerDidStartRestore(_ controller: AdaptyPaywallController) {
        VibrationManager.instance.vibrationStandart()
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        print("Started restoring purchases")
    }

    // MARK: - Вызывается после завершения процесса восстановления ранее совершенных покупок. Включает информацию о профиле пользователя ('profile'):

    func paywallController(_ controller: AdaptyPaywallController, didFinishRestoreWith profile: AdaptyProfile) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        print("Finished restoring purchases with profile: \(profile)")
        Adapty.getProfile { result in
            if let profile = try? result.get(),
               profile.accessLevels["premium"]?.isActive ?? false
            {
                self.dismiss(animated: true)
                let alert = UIAlertController(title: NSLocalizedString("Success / alert kit", comment: ""), message: NSLocalizedString("Restore Successful", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
                self.alertKitSuccess()
                print("SAVE OK: I'm Premium!")
            } else {
                self.dismiss(animated: true)
                let alert = UIAlertController(title: NSLocalizedString("Error / alert kit", comment: ""), message: NSLocalizedString("No Purchases to Restore", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
                self.present(alert, animated: true)
                self.alertKitError()
                print("NOT SAVE: I'm NOT Premium!")
            }
        }
    }

    // MARK: - Вызывается при ошибке восстановления ранее совершенных покупок.

    func paywallController(_ controller: AdaptyPaywallController, didFailRestoreWith error: AdaptyError) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        alertKitError()
        print("Failed to restore purchases")
        print("Error: \(error)")
    }

    // MARK: - Вызывается при ошибке отображения контроллера оплаты:

    func paywallController(_ controller: AdaptyPaywallController, didFailRenderingWith error: AdaptyError) {
        alertKitError()
        print("Failed to render paywall")
        print("Error: \(error)")
    }

    // MARK: - Вызывается при ошибке загрузки продуктов для отображения в контроллере оплаты. Метод возвращает 'true', если следует продолжить выполнение действий по умолчанию, и 'false' в противном случае:

    func paywallController(_ controller: AdaptyPaywallController, didFailLoadingProductsWith error: AdaptyError) -> Bool {
        alertKitError()
        print("Failed to load products")
        print("Error: \(error)")
        return true
    }
}
