import Adapty
import AdaptyUI
import AlertKit
import SafariServices
import UIKit
import WebKit

final class PaywallVC: UIViewController {
    // MARK: - PROPERTIES:

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - LIFYCYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        showPaywall()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews()
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {}

    // MARK: - CONFIGURE UI:

    private func configureUI() {}

    // MARK: - HELPERS:

    // MARK: SHOW PAYWALL VIEW:

    func showPaywall() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        Adapty.getPaywall(placementId: "PlacementID", locale: "en") { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(paywall):
                    Task { @MainActor in
                        do {
                            let configuration = try await AdaptyUI.getPaywallConfiguration(forPaywall: paywall)
                            let controller = try AdaptyUI.paywallController(with: configuration, delegate: self)
                            self.present(controller, animated: true)
                        } catch {
                            print(error)
                            let premium = PremiumVC()
                            self.navigationController?.pushViewController(premium, animated: true)
                        }
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
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

        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Ошибка при отправке сообщения в Telegram: \(error.localizedDescription)")
                return
            }
        }

        task.resume()
    }
}

// MARK: - EXTENSIONS:

// MARK: EXTENSION FOR SAFARI:

extension PaywallVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}

// MARK: - EXTENSION FOR ADAPTY:

extension PaywallVC: AdaptyPaywallControllerDelegate {
    // MARK: Вызывается при выполнении действия на контроллере оплаты. Метод обрабатывает различные actions:

    func paywallController(_ controller: AdaptyPaywallController, didPerform action: AdaptyUI.Action) {
        switch action {
        case .close:
            dismiss(animated: true)
            print(action)
            dismiss(animated: true)
        case let .custom(id):
            print(id)
        case .openURL(url: _):
            dismiss(animated: true) { [weak self] in
                guard self != nil else { return }
                VibrationManager.instance.vibrationStandart()
            }
        }
    }

    // MARK: - Вызывается при выборе продукта в контроллере оплаты:

    private func paywallController(_ controller: AdaptyPaywallController, didSelectProduct product: AdaptyPaywallProduct) {
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

    func paywallController(_ controller: AdaptyPaywallController, didFinishPurchase product: AdaptyPaywallProduct, purchaseResult: AdaptyPurchaseResult) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        alertKitSuccess()
        sendTelegramMessage(message: "Новая покупка: \(product.vendorProductId)")
        print("Finished purchase for product: \(product)")
        print("Purchase result: \(purchaseResult)")
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

        Adapty.getProfile { [weak self] result in
            guard let self else { return }

            let isPremium = (try? result.get())?
                .accessLevels["premium"]?
                .isActive ?? false

            Task { @MainActor in
                if isPremium {
                    self.dismiss(animated: true)

                    let alert = UIAlertController(
                        title: NSLocalizedString("Success / alert kit", comment: ""),
                        message: NSLocalizedString("Restore Successful", comment: ""),
                        preferredStyle: .alert
                    )

                    alert.addAction(
                        UIAlertAction(
                            title: NSLocalizedString("Close", comment: ""),
                            style: .default
                        )
                    )

                    self.present(alert, animated: true)
                    self.alertKitSuccess()

                    print("SAVE OK: I'm Premium!")
                } else {
                    self.dismiss(animated: true)

                    let alert = UIAlertController(
                        title: NSLocalizedString("Error / alert kit", comment: ""),
                        message: NSLocalizedString("No Purchases to Restore", comment: ""),
                        preferredStyle: .alert
                    )

                    alert.addAction(
                        UIAlertAction(
                            title: NSLocalizedString("Close", comment: ""),
                            style: .default
                        )
                    )

                    self.present(alert, animated: true)
                    self.alertKitError()

                    print("NOT SAVE: I'm NOT Premium!")
                }
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

    private func paywallController(_ controller: AdaptyPaywallController, didFailRenderingWith error: AdaptyError) {
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
