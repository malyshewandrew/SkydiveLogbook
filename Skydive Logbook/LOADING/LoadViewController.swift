import Lottie
import UIKit
import ShimmerSwift

final class LoadViewController: UIViewController {
    // MARK: - PROPERTIES:

    private let loadingView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    // MARK: - LIFYCYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        perform(#selector(hideAnimation), with: nil, afterDelay: 0.3)
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(loadingView)
        loadingView.addSubviews(iconImageView, titleLabel)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: LOADING VIEW:

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // MARK: ICON IMAGE VIEW:
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: -50).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: loadingView.widthAnchor, multiplier: 0.2).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: TITLE LABEL:
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: LOADING VIEW:

        loadingView.backgroundColor = .colorBackground
        
        // MARK: ICON IMAGE VIEW:
        
        iconImageView.image = UIImage(resource: .appIconVersion)
        
        // MARK: TITLE LABEL:
        
        titleLabel.text = "SkydiveBook"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = FontManager.black(size: 20).uiFont
    }

    // MARK: - HELPERS:

    // HIDE ANIMATION:
    @objc private func hideAnimation() {
        UIView.animate(withDuration: 0, animations: { [weak self] in
            guard let self = self else { return }
            let tabBarController = TabBarController()
            tabBarController.modalTransitionStyle = .crossDissolve
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true)
        })
    }
}
