import Lottie
import UIKit

final class PrecipitationVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherPrecipitation = LottieAnimationView(name: "WeatherPrecipitation")
    private let weatherPrecipitationBackground = LottieAnimationView(name: "WeatherPrecipitationBackground")
    private let precipitationView = UIView()
    private let precipitationLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherPrecipitationBackground, weatherPrecipitation, precipitationView)
        precipitationView.addSubviews(precipitationLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: PRECIPITATION BACKGROUND:

        weatherPrecipitationBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherPrecipitationBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherPrecipitationBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherPrecipitationBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherPrecipitationBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: PRECIPITATION:

        weatherPrecipitation.translatesAutoresizingMaskIntoConstraints = false
        weatherPrecipitation.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherPrecipitation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherPrecipitation.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: PRECIPITATION VIEW:
        
        precipitationView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = precipitationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = precipitationView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        precipitationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        precipitationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: PRECIPITATION LABEL:
        
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationLabel.topAnchor.constraint(equalTo: precipitationView.topAnchor, constant: 20).isActive = true
        precipitationLabel.leadingAnchor.constraint(equalTo: precipitationView.leadingAnchor, constant: 10).isActive = true
        precipitationLabel.trailingAnchor.constraint(equalTo: precipitationView.trailingAnchor, constant: -10).isActive = true
        precipitationLabel.bottomAnchor.constraint(equalTo: precipitationView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: PRECIPITATION BACKGROUND:
        
        weatherPrecipitationBackground.play()
        weatherPrecipitationBackground.loopMode = .loop
        weatherPrecipitationBackground.contentMode = .scaleAspectFill
        
        // MARK: PRECIPITATION:
        
        weatherPrecipitation.play()
        weatherPrecipitation.loopMode = .autoReverse
        weatherPrecipitation.animationSpeed = 0.7
        
        // MARK: PRECIPITATION VIEW:

        precipitationView.layer.masksToBounds = true
        precipitationView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = precipitationView.bounds
        precipitationView.addSubviews(blurEffectView, precipitationLabel)
        
        // MARK: PRECIPITATION LABEL:
        
        precipitationLabel.textColor = .white
        precipitationLabel.font = fontMediumStandard14
        precipitationLabel.numberOfLines = 0
        precipitationLabel.adjustsFontSizeToFitWidth = true
        precipitationLabel.textAlignment = .center
        precipitationLabel.text = NSLocalizedString("Precipitation weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
