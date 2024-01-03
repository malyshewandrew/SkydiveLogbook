import Lottie
import SafariServices
import UIKit
import WebKit

final class InfoVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let infoAccountLottie = LottieAnimationView(name: "InfoAccount")
    private let infoTextView = UIView()
    private let infoTextLabel = UILabel()
    private let privacyButton = UIButton()
    private let termsButton = UIButton()
    private let versionButton = UIButton()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(infoTextView, infoAccountLottie, privacyButton, termsButton, versionButton)
        infoTextView.addSubview(infoTextLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION:

        infoAccountLottie.translatesAutoresizingMaskIntoConstraints = false
        infoAccountLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoAccountLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        infoAccountLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        infoAccountLottie.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: INFO TEXT VIEW:
        
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoTextView.topAnchor.constraint(equalTo: infoAccountLottie.bottomAnchor, constant: 20).isActive = true
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
        versionButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: 30).isActive = true
        versionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        versionButton.widthAnchor.constraint(equalTo: infoTextView.widthAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground
        
        // MARK: NAVIGATION CONTROLLER
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: ANIMATION:

        infoAccountLottie.play()
        infoAccountLottie.loopMode = .loop
        
        // MARK: INFO TEXT VIEW:

        infoTextView.backgroundColor = colorCell
        infoTextView.layer.cornerRadius = cornerRadius10
        infoTextView.layer.shadowRadius = 50
        infoTextView.layer.shadowColor = colorBlueCG
        infoTextView.layer.shadowOpacity = 0.3
        
        // MARK: INFO TEXT LABEL:

        infoTextLabel.textColor = .white
        infoTextLabel.font = fontRegularStandart8
        infoTextLabel.numberOfLines = 0
        infoTextLabel.adjustsFontSizeToFitWidth = true
        infoTextLabel.text = NSLocalizedString("Info text", comment: "")
        
        // MARK: PRIVACY BUTTON:
        
        privacyButton.setTitle(NSLocalizedString("Privacy policy", comment: ""), for: .normal)
        privacyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        privacyButton.setTitleColor(.white, for: .normal)
        privacyButton.layer.cornerRadius = cornerRadius10
        privacyButton.backgroundColor = colorCell
        privacyButton.titleLabel?.font = fontMediumStandart14
        privacyButton.addTarget(self, action: #selector(tapOnPrivacyButton), for: .touchUpInside)
        
        // MARK: TERMS BUTTON:
        
        termsButton.setTitle(NSLocalizedString("Terms of use", comment: ""), for: .normal)
        termsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        termsButton.setTitleColor(.white, for: .normal)
        termsButton.layer.cornerRadius = cornerRadius10
        termsButton.backgroundColor = colorCell
        termsButton.titleLabel?.font = fontMediumStandart14
        termsButton.addTarget(self, action: #selector(tapOnTermsButton), for: .touchUpInside)
        
        // MARK: ALERT VERSION BUTTON:

        versionButton.setTitle(NSLocalizedString("App version", comment: ""), for: .normal)
        versionButton.setTitleColor(.white, for: .normal)
        versionButton.layer.cornerRadius = cornerRadius10
        versionButton.backgroundColor = colorCell
        versionButton.titleLabel?.font = fontMediumStandart14
        versionButton.addTarget(self, action: #selector(tapOnVersionButton), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: FUNC FOR ALERT VERSION BUTTON:

    @objc private func tapOnVersionButton() {
        let imageView = UIImageView(image: UIImage(named: "AppIconVersion"))
        let versionAccountLottie = LottieAnimationView(name: "VersionAccountLottie")
        let alert = UIAlertController(title: "Skydive Logbook", message: "\n\n\nVersion 1.0\niOS Developer Malyshew Andrew", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        alert.view.addSubviews(versionAccountLottie, imageView)
        alert.view.backgroundColor = .black
        alert.view.layer.masksToBounds = true
        alert.view.layer.cornerRadius = 20
        
        versionAccountLottie.translatesAutoresizingMaskIntoConstraints = false
        versionAccountLottie.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        versionAccountLottie.topAnchor.constraint(equalTo: alert.view.topAnchor).isActive = true
        versionAccountLottie.heightAnchor.constraint(equalToConstant: 140).isActive = true
        versionAccountLottie.widthAnchor.constraint(equalToConstant: 275).isActive = true
        versionAccountLottie.play()
        versionAccountLottie.loopMode = .loop
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -30).isActive = true
        imageView.layer.shadowRadius = 35
        imageView.layer.shadowColor = colorWhiteCG
        imageView.layer.shadowOpacity = 1

        present(alert, animated: true)
    }
    
    // MARK: OPEN SAFARI PRIVACY:
    
    @objc private func tapOnPrivacyButton() {
        guard let url = URL(string: "http://malyshewandrew.tilda.ws/privacysecurity") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
    
    // MARK: OPEN SAFARI TERMS:
    
    @objc private func tapOnTermsButton() {
        guard let url = URL(string: "http://malyshewandrew.tilda.ws/termsofuse") else { return }
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
