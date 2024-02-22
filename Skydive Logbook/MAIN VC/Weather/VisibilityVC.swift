import Lottie
import UIKit

final class VisibilityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherVisibility = LottieAnimationView(name: "WeatherVisibility")
    private let weatherVisibilityBackground = LottieAnimationView(name: "WeatherVisibilityBackground")
    private let visibilityView = UIView()
    private let visibilityLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherVisibilityBackground, weatherVisibility, visibilityView)
        visibilityView.addSubviews(visibilityLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: VISIBILITY BACKGROUND:

        weatherVisibilityBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherVisibilityBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherVisibilityBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherVisibilityBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherVisibilityBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: VISIBILITY:

        weatherVisibility.translatesAutoresizingMaskIntoConstraints = false
        weatherVisibility.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherVisibility.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherVisibility.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: VISIBILITY VIEW:

        visibilityView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = visibilityView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = visibilityView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        visibilityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visibilityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: VISIBILITY LABEL:
        
        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.topAnchor.constraint(equalTo: visibilityView.topAnchor, constant: 20).isActive = true
        visibilityLabel.leadingAnchor.constraint(equalTo: visibilityView.leadingAnchor, constant: 10).isActive = true
        visibilityLabel.trailingAnchor.constraint(equalTo: visibilityView.trailingAnchor, constant: -10).isActive = true
        visibilityLabel.bottomAnchor.constraint(equalTo: visibilityView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: VISIBILITY BACKGROUND:
        
        weatherVisibilityBackground.play()
        weatherVisibilityBackground.loopMode = .loop
        weatherVisibilityBackground.contentMode = .scaleAspectFill
        
        // MARK: VISIBILITY:
        
        weatherVisibility.play()
        weatherVisibility.loopMode = .loop
        weatherVisibility.animationSpeed = 0.7
        
        // MARK: VISIBILITY VIEW:

        visibilityView.layer.masksToBounds = true
        visibilityView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = visibilityView.bounds
        visibilityView.addSubviews(blurEffectView, visibilityLabel)
        
        // MARK: VISIBILITY LABEL:
        
        visibilityLabel.textColor = .white
        visibilityLabel.font = fontMediumStandard14
        visibilityLabel.numberOfLines = 0
        visibilityLabel.adjustsFontSizeToFitWidth = true
        visibilityLabel.textAlignment = .center
        visibilityLabel.text = NSLocalizedString("Visibility weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
