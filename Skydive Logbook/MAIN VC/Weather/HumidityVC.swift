import Lottie
import UIKit

final class HumidityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherHumidity = LottieAnimationView(name: "WeatherHumidity")
    private let weatherHumidityBackground = LottieAnimationView(name: "WeatherHumidityBackground")
    private let humidityView = UIView()
    private let humidityLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherHumidityBackground, weatherHumidity, humidityView)
        humidityView.addSubviews(humidityLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: HUMIDITY BACKGROUND:

        weatherHumidityBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherHumidityBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherHumidityBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherHumidityBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherHumidityBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: HUMIDITY:

        weatherHumidity.translatesAutoresizingMaskIntoConstraints = false
        weatherHumidity.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherHumidity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherHumidity.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: HUMIDITY VIEW:
        
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = humidityView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = humidityView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        humidityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        humidityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: HUMIDITY LABEL:
        
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.topAnchor.constraint(equalTo: humidityView.topAnchor, constant: 20).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor, constant: 10).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: humidityView.trailingAnchor, constant: -10).isActive = true
        humidityLabel.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: HUMIDITY BACKGROUND:
        
        weatherHumidityBackground.play()
        weatherHumidityBackground.loopMode = .loop
        weatherHumidityBackground.contentMode = .scaleToFill
        
        // MARK: HUMIDITY:
        
        weatherHumidity.play()
        weatherHumidity.loopMode = .loop
        weatherHumidity.animationSpeed = 0.7
        
        // MARK: HUMIDITY VIEW:

        humidityView.layer.masksToBounds = true
        humidityView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = humidityView.bounds
        humidityView.addSubviews(blurEffectView, humidityLabel)
        
        // MARK: HUMIDITY LABEL:
        
        humidityLabel.textColor = .white
        humidityLabel.font = fontMediumStandard14
        humidityLabel.numberOfLines = 0
        humidityLabel.adjustsFontSizeToFitWidth = true
        humidityLabel.textAlignment = .center
        humidityLabel.text = NSLocalizedString("Humidity weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
