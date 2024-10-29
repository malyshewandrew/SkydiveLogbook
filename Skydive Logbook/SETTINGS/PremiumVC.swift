import Adapty
import Lottie
import StoreKit
import UIKit

final class PremiumVC: UIViewController {
    // MARK: - PROPERTIES:

    private let premiumSettingsLottie = LottieAnimationView(name: "PremiumSettings")
    private let imageView = UIImageView()
    private let internetButton = UIButton()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        internetButtonTapped()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(imageView)
        imageView.addSubviews(premiumSettingsLottie, internetButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: IMAGE VIEW:

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // MARK: INTERNET BUTTON:

        internetButton.translatesAutoresizingMaskIntoConstraints = false
        internetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        internetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        internetButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        internetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true

        // MARK: ANIMATION:

        premiumSettingsLottie.translatesAutoresizingMaskIntoConstraints = false
        premiumSettingsLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        premiumSettingsLottie.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 225).isActive = true
        premiumSettingsLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        premiumSettingsLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false

        // MARK: IMAGE VIEW:

        imageView.image = UIImage(named: "noInternet")
        imageView.contentMode = .scaleAspectFill

        // MARK: INTERNET BUTTON:

        internetButton.layer.masksToBounds = true
        internetButton.layer.cornerRadius = cornerRadius15
        internetButton.setTitle(NSLocalizedString("No connection / adapty", comment: ""), for: .normal)
        internetButton.setTitleColor(.colorWhite, for: .normal)
        internetButton.setTitleColor(.systemBlue, for: .highlighted)
        internetButton.backgroundColor = .colorTabBar
        internetButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        internetButton.addTarget(self, action: #selector(internetButtonTapped), for: .touchUpInside)

        // MARK: ANIMATION:

        premiumSettingsLottie.play()
        premiumSettingsLottie.loopMode = .loop
    }

    // MARK: - HELPERS:

    @objc private func internetButtonTapped() {
        let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: NSLocalizedString("Message / adapty", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
