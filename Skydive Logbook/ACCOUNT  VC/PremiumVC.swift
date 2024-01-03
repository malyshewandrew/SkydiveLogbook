import Lottie
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
        buy12Button.topAnchor.constraint(equalTo: buy1Button.bottomAnchor, constant: 30).isActive = true
        buy12Button.heightAnchor.constraint(equalToConstant: height40).isActive = true
        buy12Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: PERCENT LABEL:
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.centerXAnchor.constraint(equalTo: buy12Button.trailingAnchor).isActive = true
        percentLabel.centerYAnchor.constraint(equalTo: buy12Button.topAnchor, constant: 8).isActive = true
        percentLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        percentLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        percentLabel.backgroundColor = .systemGreen
        percentLabel.layer.masksToBounds = true
        percentLabel.layer.cornerRadius = 15
        percentLabel.text = "-85%"
        percentLabel.textAlignment = .center
        percentLabel.font = .systemFont(ofSize: 12, weight: .bold, width: .standard)
        percentLabel.transform = CGAffineTransform(rotationAngle: 0.5)
        percentLabel.adjustsFontSizeToFitWidth = true
        
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

        view.backgroundColor = colorBackground
        
        // NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: ANIMATION:

        premiumAccountLottie.play()
        premiumAccountLottie.loopMode = .loop
        
        // MARK: INFO TEXT VIEW:

        infoTextView.backgroundColor = #colorLiteral(red: 0.04016558453, green: 0.1143882051, blue: 0.171395421, alpha: 1)
        infoTextView.layer.cornerRadius = 10
        infoTextView.layer.shadowRadius = 50
        infoTextView.layer.shadowColor = colorBlueCG
        infoTextView.layer.shadowOpacity = 0.3
        
        // MARK: INFO TEXT LABEL:

        infoTextLabel.textColor = .white
        infoTextLabel.font = .systemFont(ofSize: 12, weight: .regular, width: .standard)
        infoTextLabel.numberOfLines = 0
        infoTextLabel.textAlignment = .center
        infoTextLabel.adjustsFontSizeToFitWidth = true
        infoTextLabel.text = NSLocalizedString("Premium info text", comment: "")
        
        // MARK: BUY 1 BUTTON:
        
        buy1Button.setTitle("\(NSLocalizedString("1 month", comment: ""))", for: .normal)
        buy1Button.setTitleColor(colorWhite, for: .normal)
        buy1Button.backgroundColor = colorBlue
        buy1Button.layer.cornerRadius = cornerRadius10
        buy1Button.titleLabel?.font = fontMediumStandart14
        buy1Button.titleLabel?.numberOfLines = 0
        buy1Button.titleLabel?.textAlignment = .center
        buy1Button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // MARK: BUY 12 BUTTON:
        
        buy12Button.setTitle("\(NSLocalizedString("12 months", comment: ""))", for: .normal)
        buy12Button.setTitleColor(colorWhite, for: .normal)
        buy12Button.backgroundColor = colorBlue
        buy12Button.layer.cornerRadius = cornerRadius10
        buy12Button.titleLabel?.font = fontMediumStandart14
        buy12Button.titleLabel?.numberOfLines = 0
        buy12Button.titleLabel?.textAlignment = .center
        buy12Button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // MARK: RESTORE BUTTON:

        restoreButton.setTitle(NSLocalizedString("Restore purchases", comment: ""), for: .normal)
        restoreButton.layer.cornerRadius = cornerRadius10
        restoreButton.backgroundColor = colorTabBar
        restoreButton.titleLabel?.font = fontMediumStandart14
        restoreButton.setTitleColor(.white, for: .normal)
        restoreButton.addTarget(self, action: #selector(tapOnRestoreButton), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: FUNC FOR ALERT RESTORE BUTTON:

    @objc private func tapOnRestoreButton() {
        let alertAboutApplicationButton = UIAlertController(title: NSLocalizedString("Restore purchases", comment: ""), message: NSLocalizedString("Buy status", comment: ""), preferredStyle: .alert)
        alertAboutApplicationButton.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alertAboutApplicationButton, animated: true)
    }
}
