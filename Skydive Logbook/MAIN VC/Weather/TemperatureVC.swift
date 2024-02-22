import Lottie
import UIKit

final class TemperatureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherTemperature = LottieAnimationView(name: "WeatherTemperature")
    private let weatherTemperatureBackground = LottieAnimationView(name: "WeatherTemperatureBackground")
    private let temperatureView = UIView()
    private let temperatureLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherTemperatureBackground, weatherTemperature, temperatureView)
        temperatureView.addSubviews(temperatureLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: TEMPERATURE BACKGROUND:

        weatherTemperatureBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherTemperatureBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherTemperatureBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherTemperatureBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherTemperatureBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: TEMPERATURE:

        weatherTemperature.translatesAutoresizingMaskIntoConstraints = false
        weatherTemperature.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherTemperature.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: TEMPERATURE VIEW:

        temperatureView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = temperatureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = temperatureView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        temperatureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        temperatureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        // MARK: TEMPERATURE LABEL:
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.topAnchor.constraint(equalTo: temperatureView.topAnchor, constant: 20).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: temperatureView.leadingAnchor, constant: 10).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: temperatureView.trailingAnchor, constant: -10).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo: temperatureView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: TEMPERATURE BACKGROUND:
        
        weatherTemperatureBackground.play()
        weatherTemperatureBackground.loopMode = .loop
        weatherTemperatureBackground.contentMode = .scaleToFill
        
        // MARK: TEMPERATURE:
        
        weatherTemperature.play()
        weatherTemperature.loopMode = .loop
        weatherTemperature.animationSpeed = 0.7
        
        // MARK: TEMPERATURE VIEW:

        temperatureView.layer.masksToBounds = true
        temperatureView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = temperatureView.bounds
        temperatureView.addSubviews(blurEffectView, temperatureLabel)
        
        // MARK: TEMPERATURE LABEL:
        
        temperatureLabel.textColor = .white
        temperatureLabel.font = fontMediumStandard14
        temperatureLabel.numberOfLines = 0
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textAlignment = .center
        temperatureLabel.text = NSLocalizedString("Temperature weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
