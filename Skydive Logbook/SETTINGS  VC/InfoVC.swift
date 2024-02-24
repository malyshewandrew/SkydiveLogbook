import Lottie
import SafariServices
import UIKit
import WebKit
import RealmSwift

final class InfoVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let infoSettingsLottie = LottieAnimationView(name: "InfoSettings")
    private let infoTextView = UIView()
    private let infoTextLabel = UILabel()
    private let privacyButton = UIButton()
    private let termsButton = UIButton()
    private let versionButton = UIButton()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(infoTextView, infoSettingsLottie, privacyButton, termsButton, versionButton)
        infoTextView.addSubview(infoTextLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION:

        infoSettingsLottie.translatesAutoresizingMaskIntoConstraints = false
        infoSettingsLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoSettingsLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        infoSettingsLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        infoSettingsLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: INFO TEXT VIEW:
        
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoTextView.topAnchor.constraint(equalTo: infoSettingsLottie.bottomAnchor, constant: 20).isActive = true
        infoTextView.heightAnchor.constraint(greaterThanOrEqualTo: infoTextLabel.heightAnchor, constant: 10).isActive = true
        infoTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: INFO TEXT LABEL:

        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTextLabel.centerXAnchor.constraint(equalTo: infoTextView.centerXAnchor).isActive = true
        infoTextLabel.centerYAnchor.constraint(equalTo: infoTextView.centerYAnchor).isActive = true
        infoTextLabel.leadingAnchor.constraint(equalTo: infoTextView.leadingAnchor, constant: 10).isActive = true
        infoTextLabel.trailingAnchor.constraint(equalTo: infoTextView.trailingAnchor, constant: -10).isActive = true
        
        // MARK: PRIVACY BUTTON:

        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.topAnchor.constraint(equalTo: infoTextLabel.bottomAnchor, constant: 30).isActive = true
        privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        privacyButton.widthAnchor.constraint(equalTo: infoTextView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: TERMS BUTTON:

        termsButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.topAnchor.constraint(equalTo: privacyButton.bottomAnchor, constant: 15).isActive = true
        termsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        termsButton.widthAnchor.constraint(equalTo: infoTextView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: ALERT VERSION BUTTON:

        versionButton.translatesAutoresizingMaskIntoConstraints = false
        versionButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: 15).isActive = true
        versionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        versionButton.widthAnchor.constraint(equalTo: infoTextView.widthAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: NAVIGATION CONTROLLER
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: ANIMATION:

        infoSettingsLottie.play()
        infoSettingsLottie.loopMode = .loop
        
        // MARK: INFO TEXT VIEW:

        infoTextView.backgroundColor = .colorCell
        infoTextView.layer.cornerRadius = cornerRadius15
        infoTextView.layer.shadowRadius = 50
        infoTextView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        infoTextView.layer.shadowOpacity = 0.3
        
        // MARK: INFO TEXT LABEL:

        infoTextLabel.textColor = .colorWhite
        infoTextLabel.font = fontRegularStandard8
        infoTextLabel.numberOfLines = 0
        infoTextLabel.adjustsFontSizeToFitWidth = true
        infoTextLabel.text = NSLocalizedString("Info text", comment: "")
        
        // MARK: PRIVACY BUTTON:
        
        privacyButton.setTitle(NSLocalizedString("Privacy policy", comment: ""), for: .normal)
        privacyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        privacyButton.setTitleColor(.colorWhite, for: .normal)
        privacyButton.layer.cornerRadius = cornerRadius15
        privacyButton.backgroundColor = .colorCell
        privacyButton.titleLabel?.font = fontMediumStandard14
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        
        // MARK: TERMS BUTTON:
        
        termsButton.setTitle(NSLocalizedString("Terms of use", comment: ""), for: .normal)
        termsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        termsButton.setTitleColor(.colorWhite, for: .normal)
        termsButton.layer.cornerRadius = cornerRadius15
        termsButton.backgroundColor = .colorCell
        termsButton.titleLabel?.font = fontMediumStandard14
        termsButton.addTarget(self, action: #selector(termsButtonTapped), for: .touchUpInside)
        
        // MARK: ALERT VERSION BUTTON:

        versionButton.setTitle(NSLocalizedString("App version", comment: ""), for: .normal)
        versionButton.setTitleColor(.colorWhite, for: .normal)
        versionButton.layer.cornerRadius = cornerRadius15
        versionButton.backgroundColor = .colorCell
        versionButton.titleLabel?.font = fontMediumStandard14
        versionButton.addTarget(self, action: #selector(versionButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: FUNC FOR ALERT VERSION BUTTON:

    @objc private func versionButtonTapped() {
        vibrationOn.vibrationStandart()
        let imageView = UIImageView(image: UIImage(named: "AppIconVersion"))
        let versionSettingsLottie = LottieAnimationView(name: "VersionSettingsLottie")
        let alert = UIAlertController(title: "Skydive Logbook", message: "\n\n\n\niOS Developer Malyshew Andrew\n2023-2024 Minsk, Belarus\nmalyshewdeveloper@protonmail.com", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.addSubviews(versionSettingsLottie, imageView)
        
        versionSettingsLottie.translatesAutoresizingMaskIntoConstraints = false
        versionSettingsLottie.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        versionSettingsLottie.topAnchor.constraint(equalTo: alert.view.topAnchor).isActive = true
        versionSettingsLottie.heightAnchor.constraint(equalToConstant: 140).isActive = true
        versionSettingsLottie.widthAnchor.constraint(equalToConstant: 275).isActive = true
        versionSettingsLottie.play()
        versionSettingsLottie.loopMode = .loop
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -30).isActive = true
        imageView.layer.shadowRadius = 35
        imageView.layer.shadowColor = UIColor.colorWhite.cgColor
        imageView.layer.shadowOpacity = 1

        present(alert, animated: true)
    }
    
    // MARK: OPEN SAFARI PRIVACY:
    
    @objc private func privacyButtonTapped() {
        vibrationOn.vibrationStandart()
        guard let url = URL(string: "https://skydivelogbook.tilda.ws/privacysecurity") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
    
    // MARK: OPEN SAFARI TERMS:
    
    @objc private func termsButtonTapped() {
        vibrationOn.vibrationStandart()
        guard let url = URL(string: "https://skydivelogbook.tilda.ws/termsofuse") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
}

// MARK: - EXTENSION. SAFARI VIEW CONTROLLER DELEGATE:

extension InfoVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}
