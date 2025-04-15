import Lottie
import SafariServices
import UIKit
import WebKit

final class InfoVC: UIViewController {
    // MARK: - PROPERTIES:

    private let infoBackground = LottieAnimationView(name: "InfoBackground")
    private let infoBackgroundView = UIView()
    private let appleButtonLottie = LottieAnimationView(name: "Apple")
    private let appleButton = UIButton(type: .system)
    private let scrollView = UIScrollView()
    private let privacyButton = UIButton(type: .system)
    private let termsButton = UIButton(type: .system)
    private let faqButton = UIButton(type: .system)
    private let languagesButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let feedbackButton = UIButton(type: .system)
    private let mailButton = UIButton(type: .system)
    private let versionButton = UIButton(type: .system)
    private var buildVersion = ""
    private var appVersion = ""
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(infoBackground, infoBackgroundView, appleButtonLottie, appleButton, scrollView)
        scrollView.addSubviews(privacyButton, termsButton, faqButton, languagesButton, shareButton, feedbackButton, mailButton, versionButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: INFO BACKGROUND:

        infoBackground.translatesAutoresizingMaskIntoConstraints = false
        infoBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        infoBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        infoBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: INFO BACKGROUND VIEW:

        infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        infoBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: -5).isActive = true
        infoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        infoBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: APPLE BUTTON LOTTIE:
        
        appleButtonLottie.translatesAutoresizingMaskIntoConstraints = false
        appleButtonLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        appleButtonLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appleButtonLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        appleButtonLottie.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        // MARK: APPLE BUTTON:
        
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.topAnchor.constraint(equalTo: appleButtonLottie.topAnchor).isActive = true
        appleButton.bottomAnchor.constraint(equalTo: appleButtonLottie.bottomAnchor).isActive = true
        appleButton.leadingAnchor.constraint(equalTo: appleButtonLottie.leadingAnchor).isActive = true
        appleButton.trailingAnchor.constraint(equalTo: appleButtonLottie.trailingAnchor).isActive = true
        
        // MARK: SCROLL VIEW:
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 25).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: PRIVACY BUTTON:

        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        privacyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: TERMS BUTTON:

        termsButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.topAnchor.constraint(equalTo: privacyButton.bottomAnchor, constant: 15).isActive = true
        termsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        termsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: FAQ BUTTON:

        faqButton.translatesAutoresizingMaskIntoConstraints = false
        faqButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: 15).isActive = true
        faqButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        faqButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: LANGUAGES BUTTON (ALERT):
        
        languagesButton.translatesAutoresizingMaskIntoConstraints = false
        languagesButton.topAnchor.constraint(equalTo: faqButton.bottomAnchor, constant: 15).isActive = true
        languagesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        languagesButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        languagesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: SHARE:

        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.topAnchor.constraint(equalTo: languagesButton.bottomAnchor, constant: 15).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        shareButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: FEEDBACK:

        feedbackButton.translatesAutoresizingMaskIntoConstraints = false
        feedbackButton.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 15).isActive = true
        feedbackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        feedbackButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        feedbackButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: MAIL:
        
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        mailButton.topAnchor.constraint(equalTo: feedbackButton.bottomAnchor, constant: 15).isActive = true
        mailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mailButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        mailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: VERSION BUTTON (ALERT):

        versionButton.translatesAutoresizingMaskIntoConstraints = false
        versionButton.topAnchor.constraint(equalTo: mailButton.bottomAnchor, constant: 15).isActive = true
        versionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        versionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: NAVIGATION CONTROLLER
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: INFO BACKGROUND:
        
        infoBackground.play()
        infoBackground.loopMode = .loop
        infoBackground.animationSpeed = 1
        infoBackground.contentMode = .scaleAspectFill
        infoBackground.isHidden = true
        
        // MARK: INFO BACKGROUND VIEW:
        
        infoBackgroundView.backgroundColor = .black
        infoBackgroundView.layer.opacity = 0.5
        
        // MARK: APPLE BUTTON LOTTIE:
        
        appleButtonLottie.play()
        appleButtonLottie.loopMode = .playOnce
        appleButtonLottie.animationSpeed = 1
        appleButtonLottie.contentMode = .scaleAspectFill
        
        // MARK: APPLE BUTTON:
        
        appleButton.backgroundColor = .clear
        appleButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        
        // MARK: SCROLL VIEW:
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.isScrollEnabled = true
        
        // MARK: PRIVACY BUTTON:
        
        privacyButton.setTitle(NSLocalizedString("Privacy policy", comment: ""), for: .normal)
        privacyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        privacyButton.setTitleColor(.colorWhite, for: .normal)
        privacyButton.setTitleColor(.systemBlue, for: .highlighted)
        privacyButton.layer.cornerRadius = cornerRadius15
        privacyButton.backgroundColor = .colorCell
        privacyButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        privacyButton.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        
        // MARK: TERMS BUTTON:
        
        termsButton.setTitle(NSLocalizedString("Terms of use", comment: ""), for: .normal)
        termsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        termsButton.setTitleColor(.colorWhite, for: .normal)
        termsButton.setTitleColor(.systemBlue, for: .highlighted)
        termsButton.layer.cornerRadius = cornerRadius15
        termsButton.backgroundColor = .colorCell
        termsButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        termsButton.addTarget(self, action: #selector(termsButtonTapped), for: .touchUpInside)
        
        // MARK: FAQ BUTTON:

        faqButton.setTitle(NSLocalizedString("FAQ", comment: ""), for: .normal)
        faqButton.titleLabel?.adjustsFontSizeToFitWidth = true
        faqButton.setTitleColor(.colorWhite, for: .normal)
        faqButton.setTitleColor(.systemBlue, for: .highlighted)
        faqButton.layer.cornerRadius = cornerRadius15
        faqButton.backgroundColor = .colorCell
        faqButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        faqButton.addTarget(self, action: #selector(faqButtonTapped), for: .touchUpInside)
        
        // MARK: LANGUAGES BUTTON (ALERT):
        
        languagesButton.setTitle(NSLocalizedString("App language / info", comment: ""), for: .normal)
        languagesButton.setTitleColor(.colorWhite, for: .normal)
        languagesButton.setTitleColor(.systemBlue, for: .highlighted)
        languagesButton.layer.cornerRadius = cornerRadius15
        languagesButton.backgroundColor = .colorCell
        languagesButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        languagesButton.addTarget(self, action: #selector(languagesButtonTapped), for: .touchUpInside)
        
        // MARK: SHARE:

        shareButton.setTitle(NSLocalizedString("Share the app", comment: ""), for: .normal)
        shareButton.setTitleColor(.colorWhite, for: .normal)
        shareButton.setTitleColor(.systemBlue, for: .highlighted)
        shareButton.layer.cornerRadius = cornerRadius15
        shareButton.backgroundColor = .colorCell
        shareButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        shareButton.titleLabel?.adjustsFontSizeToFitWidth = true
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        // MARK: FEEDBAcK:

        feedbackButton.setTitle(NSLocalizedString("Feedback", comment: ""), for: .normal)
        feedbackButton.setTitleColor(.colorWhite, for: .normal)
        feedbackButton.setTitleColor(.systemBlue, for: .highlighted)
        feedbackButton.layer.cornerRadius = cornerRadius15
        feedbackButton.backgroundColor = .colorCell
        feedbackButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        feedbackButton.titleLabel?.adjustsFontSizeToFitWidth = true
        feedbackButton.addTarget(self, action: #selector(feedbackButtonTapped), for: .touchUpInside)
        
        // MARK: MAIL:
        
        mailButton.setTitle(NSLocalizedString("Send mail", comment: ""), for: .normal)
        mailButton.setTitleColor(.colorWhite, for: .normal)
        mailButton.setTitleColor(.systemBlue, for: .highlighted)
        mailButton.layer.cornerRadius = cornerRadius15
        mailButton.backgroundColor = .colorCell
        mailButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        mailButton.titleLabel?.adjustsFontSizeToFitWidth = true
        mailButton.addTarget(self, action: #selector(mailButtonTapped), for: .touchUpInside)
        
        // MARK: VERSION BUTTON (ALERT):

        versionButton.setTitle(NSLocalizedString("App version", comment: ""), for: .normal)
        versionButton.setTitleColor(.colorWhite, for: .normal)
        versionButton.setTitleColor(.systemBlue, for: .highlighted)
        versionButton.layer.cornerRadius = cornerRadius15
        versionButton.backgroundColor = .colorCell
        versionButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        versionButton.addTarget(self, action: #selector(versionButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: FUNC FOR LANGUAGES BUTTON (ALERT):

    @objc private func languagesButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("App language / info", comment: ""), message: NSLocalizedString("App language text / info", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }
    
    // MARK: FUNC FOR VERSION BUTTON (ALERT):

    @objc private func versionButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        if let infoDictionary = Bundle.main.infoDictionary {
            if let buildVersion = infoDictionary["CFBundleVersion"] as? String {
                self.buildVersion = buildVersion
            }
            if let appVersion = infoDictionary["CFBundleShortVersionString"] as? String {
                self.appVersion = appVersion
            }
        }
        let versionMessage = NSLocalizedString("Version / info", comment: "") + ": " + appVersion
        let buildMessage = NSLocalizedString("Build / info", comment: "") + ": " + buildVersion
        let imageView = UIImageView(image: UIImage(named: "AppIconVersion"))
        let versionSettingsLottie = LottieAnimationView(name: "VersionSettingsLottie")
        let currentYear = Calendar.current.component(.year, from: Date())
        let alert = UIAlertController(title: "SkydiveBook™", message: "\n\n\n\(versionMessage). \(buildMessage)\n© Malyshew Andrew\nApp Store, 2023-\(currentYear)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
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
        imageView.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -35).isActive = true
        imageView.layer.shadowRadius = 35
        imageView.layer.shadowColor = UIColor.colorWhite.cgColor
        imageView.layer.shadowOpacity = 1

        present(alert, animated: true)
    }
    
    // MARK: APPLE BUTTON TAPPED:
    
    @objc private func appleButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let alert = UIAlertController(title: "Skydive Book", message: NSLocalizedString("Info text", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: OPEN SAFARI PRIVACY:
    
    @objc private func privacyButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let url = URL(string: "https://skydivebook.tilda.ws/privacysecurity") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
    
    // MARK: OPEN SAFARI TERMS:
    
    @objc private func termsButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let url = URL(string: "https://skydivebook.tilda.ws/termsofuse") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
    
    // MARK: OPEN SAFARI FAQ:
    
    @objc private func faqButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let url = URL(string: "https://skydivebook.tilda.ws/faq") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
    
    // MARK: FUNC FOR SHARE BUTTON:
    
    @objc private func shareButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let appURL = URL(string: "https://apps.apple.com/app/skydivebook/id6478469415") else { return }
        UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
    }
    
    // MARK: FUNC FOR FEEDBACK BUTTON:
    
    @objc private func feedbackButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let feedbackURL = URL(string: "itms-apps://itunes.apple.com/app/id6478469415?action=write-review") else { return }
        UIApplication.shared.open(feedbackURL, options: [:], completionHandler: nil)
    }
    
    // MARK: FUNC FOR MAIL BUTTON:
    
    @objc private func mailButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let email = "malyshewdeveloper@protonmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - EXTENSION. SAFARI VIEW CONTROLLER DELEGATE:

extension InfoVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}
