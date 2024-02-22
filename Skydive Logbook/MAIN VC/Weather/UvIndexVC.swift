import Lottie
import UIKit

final class UvIndexVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherUvIndex = LottieAnimationView(name: "WeatherUvIndex")
    private let weatherUvIndexBackground = LottieAnimationView(name: "WeatherUvIndexBackground")
    private let uvIndexView = UIView()
    private let uvIndexLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherUvIndexBackground, weatherUvIndex, uvIndexView)
        uvIndexView.addSubviews(uvIndexLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: UVINDEX BACKGROUND:

        weatherUvIndexBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherUvIndexBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherUvIndexBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherUvIndexBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherUvIndexBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: UVINDEX:

        weatherUvIndex.translatesAutoresizingMaskIntoConstraints = false
        weatherUvIndex.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherUvIndex.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherUvIndex.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: UVINDEX VIEW:

        uvIndexView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = uvIndexView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = uvIndexView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        uvIndexView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        uvIndexView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: UVINDEX LABEL:
        
        uvIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        uvIndexLabel.topAnchor.constraint(equalTo: uvIndexView.topAnchor, constant: 20).isActive = true
        uvIndexLabel.leadingAnchor.constraint(equalTo: uvIndexView.leadingAnchor, constant: 10).isActive = true
        uvIndexLabel.trailingAnchor.constraint(equalTo: uvIndexView.trailingAnchor, constant: -10).isActive = true
        uvIndexLabel.bottomAnchor.constraint(equalTo: uvIndexView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: UVINDEX BACKGROUND:
        
        weatherUvIndexBackground.play()
        weatherUvIndexBackground.loopMode = .loop
        weatherUvIndexBackground.contentMode = .scaleAspectFill
        
        // MARK: UVINDEX:
        
        weatherUvIndex.play()
        weatherUvIndex.loopMode = .loop
        weatherUvIndex.animationSpeed = 0.7
        
        // MARK: UVINDEX VIEW:

        uvIndexView.layer.masksToBounds = true
        uvIndexView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = uvIndexView.bounds
        uvIndexView.addSubviews(blurEffectView, uvIndexLabel)
        
        // MARK: UVINDEX LABEL:
        
        uvIndexLabel.textColor = .white
        uvIndexLabel.font = fontMediumStandard14
        uvIndexLabel.numberOfLines = 0
        uvIndexLabel.adjustsFontSizeToFitWidth = true
        uvIndexLabel.textAlignment = .center
        uvIndexLabel.text = NSLocalizedString("UvIndex weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
