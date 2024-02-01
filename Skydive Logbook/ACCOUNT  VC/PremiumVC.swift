import Lottie
import RealmSwift
import SwiftyStoreKit
import UIKit

final class PremiumVC: UIViewController {
    // MARK: - PROPERTIES:

    private let premiumAccountLottie = LottieAnimationView(name: "PremiumAccount")
    private let infoTextView = UIView()
    private let infoTextLabel = UILabel()
    private let buy1Button = UIButton()
    private let buy12Button = UIButton()
    private let percentLabel = UILabel()
    private let restoreButton = UIButton()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(infoTextView, premiumAccountLottie, buy1Button, buy12Button, percentLabel, restoreButton)
        infoTextView.addSubviews(infoTextLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION:

        premiumAccountLottie.translatesAutoresizingMaskIntoConstraints = false
        premiumAccountLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        premiumAccountLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        premiumAccountLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        premiumAccountLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        // MARK: INFO TEXT VIEW:
        
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoTextView.topAnchor.constraint(equalTo: premiumAccountLottie.bottomAnchor, constant: 10).isActive = true
        infoTextView.heightAnchor.constraint(greaterThanOrEqualTo: infoTextLabel.heightAnchor, constant: 10).isActive = true
        infoTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: INFO TEXT LABEL:

        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTextLabel.centerXAnchor.constraint(equalTo: infoTextView.centerXAnchor).isActive = true
        infoTextLabel.centerYAnchor.constraint(equalTo: infoTextView.centerYAnchor).isActive = true
        infoTextLabel.leadingAnchor.constraint(equalTo: infoTextView.leadingAnchor, constant: 10).isActive = true
        infoTextLabel.trailingAnchor.constraint(equalTo: infoTextView.trailingAnchor, constant: -10).isActive = true
        
        // MARK: BUY 1 BUTTON:

        buy1Button.translatesAutoresizingMaskIntoConstraints = false
        buy1Button.centerXAnchor.constraint(equalTo: infoTextView.centerXAnchor).isActive = true
        buy1Button.topAnchor.constraint(equalTo: infoTextView.bottomAnchor, constant: 30).isActive = true
        buy1Button.heightAnchor.constraint(equalToConstant: height40).isActive = true
        buy1Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: BUY 12 BUTTON:

        buy12Button.translatesAutoresizingMaskIntoConstraints = false
        buy12Button.centerXAnchor.constraint(equalTo: infoTextView.centerXAnchor).isActive = true
        buy12Button.topAnchor.constraint(equalTo: buy1Button.bottomAnchor, constant: 15).isActive = true
        buy12Button.heightAnchor.constraint(equalToConstant: height40).isActive = true
        buy12Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: PERCENT LABEL:
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.centerXAnchor.constraint(equalTo: buy12Button.trailingAnchor).isActive = true
        percentLabel.centerYAnchor.constraint(equalTo: buy12Button.topAnchor, constant: 8).isActive = true
        percentLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: RESTORE BUTTON:

        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.topAnchor.constraint(equalTo: buy12Button.bottomAnchor, constant: 30).isActive = true
        restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restoreButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        restoreButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: ANIMATION:

        premiumAccountLottie.play()
        premiumAccountLottie.loopMode = .loop
        
        // MARK: INFO TEXT VIEW:

        infoTextView.backgroundColor = UIColor.colorCell
        infoTextView.layer.cornerRadius = 10
        infoTextView.layer.shadowRadius = 50
        infoTextView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        infoTextView.layer.shadowOpacity = 0.3
        
        // MARK: INFO TEXT LABEL:

        infoTextLabel.textColor = .colorWhite
        infoTextLabel.font = .systemFont(ofSize: 12, weight: .regular, width: .standard)
        infoTextLabel.numberOfLines = 0
        infoTextLabel.textAlignment = .center
        infoTextLabel.adjustsFontSizeToFitWidth = true
        infoTextLabel.text = NSLocalizedString("Premium info text", comment: "")
        
        // MARK: BUY 1 BUTTON:
        
        buy1Button.setTitle("\(NSLocalizedString("1 month", comment: ""))", for: .normal)
        buy1Button.setTitleColor(.colorWhite, for: .normal)
        buy1Button.backgroundColor = .colorBlue
        buy1Button.layer.cornerRadius = cornerRadius15
        buy1Button.titleLabel?.font = fontMediumStandard14
        buy1Button.titleLabel?.numberOfLines = 0
        buy1Button.titleLabel?.textAlignment = .center
        buy1Button.titleLabel?.adjustsFontSizeToFitWidth = true
        buy1Button.addTarget(self, action: #selector(buy1ButtonTapped), for: .touchUpInside)
        
        // MARK: BUY 12 BUTTON:
        
        buy12Button.setTitle("\(NSLocalizedString("12 months", comment: ""))", for: .normal)
        buy12Button.setTitleColor(.colorWhite, for: .normal)
        buy12Button.backgroundColor = .colorBlue
        buy12Button.layer.cornerRadius = cornerRadius15
        buy12Button.titleLabel?.font = fontMediumStandard14
        buy12Button.titleLabel?.numberOfLines = 0
        buy12Button.titleLabel?.textAlignment = .center
        buy12Button.titleLabel?.adjustsFontSizeToFitWidth = true
        buy12Button.addTarget(self, action: #selector(buy12ButtonTapped), for: .touchUpInside)
        
        // MARK: PERCENT LABEL:
        
        percentLabel.backgroundColor = .systemGreen
        percentLabel.layer.masksToBounds = true
        percentLabel.layer.cornerRadius = 15
        percentLabel.text = "-58%"
        percentLabel.textAlignment = .center
        percentLabel.font = .systemFont(ofSize: 12, weight: .bold, width: .standard)
        percentLabel.transform = CGAffineTransform(rotationAngle: 0.5)
        percentLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESTORE BUTTON:

        restoreButton.setTitle(NSLocalizedString("Restore purchases", comment: ""), for: .normal)
        restoreButton.layer.cornerRadius = cornerRadius15
        restoreButton.backgroundColor = .colorTabBar
        restoreButton.titleLabel?.font = fontMediumStandard14
        restoreButton.setTitleColor(.colorWhite, for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: FUNC FOR BUY 1:
    
    @objc private func buy1ButtonTapped() {
        print("TEST 1")
        purchaseProduct()
    }
    
    // MARK: FUNC FOR BUY 12:
    
    @objc private func buy12ButtonTapped() {
        print("TEST 12")
        purchaseProduct()
    }
    
    // MARK: PURCHASE PRODUCT:

    func purchaseProduct() {
        let productId = "your_product_id" // Замените на свой идентификатор товара

        SwiftyStoreKit.purchaseProduct(productId) { result in
            switch result {
            case .success(let purchase):
                // Покупка успешно завершена
                print("Purchase Success: \(purchase.productId)")
            // Добавьте код для предоставления пользователю доступа к функциональности после покупки
            case .error(let error):
                // Произошла ошибка при покупке
                print("Purchase Failed: \(error)")
            // Добавьте код для обработки ошибки
            case .deferred(purchase: let purchase):
                print("Purchase \(purchase)")
            }
        }
    }
    
    // MARK: FUNC FOR ALERT RESTORE BUTTON:

    @objc private func restoreButtonTapped() {
        SwiftyStoreKit.restorePurchases { results in
            if results.restoreFailedPurchases.isEmpty {
                // Восстановление завершено успешно
                self.showRestoreSuccessAlert()
            } else if results.restoreFailedPurchases.count > 0 {
                // Произошла ошибка при восстановлении каких-то покупок
                self.showRestoreErrorAlert()
            } else {
                // Нет предыдущих покупок для восстановления
                self.showNoPurchasesToRestoreAlert()
            }
        }
    }

    private func showRestoreSuccessAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Restore Successful", comment: ""), message: NSLocalizedString("All purchases have been successfully restored.", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func showRestoreErrorAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Restore Failed", comment: ""), message: NSLocalizedString("Some purchases could not be restored. Please try again later.", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }

    private func showNoPurchasesToRestoreAlert() {
        let alert = UIAlertController(title: NSLocalizedString("No Purchases to Restore", comment: ""), message: NSLocalizedString("There are no previous purchases to restore.", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }
}
