import Lottie
import UIKit

final class PressureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherPressure = LottieAnimationView(name: "WeatherPressure")
    private let weatherPressureBackground = LottieAnimationView(name: "WeatherPressureBackground")
    private let pressureView = UIView()
    private let pressureLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherPressureBackground, weatherPressure, pressureView)
        pressureView.addSubviews(pressureLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: PRESSURE BACKGROUND:

        weatherPressureBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherPressureBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherPressureBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherPressureBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherPressureBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: PRESSURE:

        weatherPressure.translatesAutoresizingMaskIntoConstraints = false
        weatherPressure.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        weatherPressure.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherPressure.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        // MARK: PRESSURE VIEW:

        pressureView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = pressureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = pressureView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        pressureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pressureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: PRESSURE LABEL:
        
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.topAnchor.constraint(equalTo: pressureView.topAnchor, constant: 20).isActive = true
        pressureLabel.leadingAnchor.constraint(equalTo: pressureView.leadingAnchor, constant: 10).isActive = true
        pressureLabel.trailingAnchor.constraint(equalTo: pressureView.trailingAnchor, constant: -10).isActive = true
        pressureLabel.bottomAnchor.constraint(equalTo: pressureView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: PRESSURE BACKGROUND:
        
        weatherPressureBackground.play()
        weatherPressureBackground.loopMode = .loop
        weatherPressureBackground.animationSpeed = 0.7
        weatherPressureBackground.contentMode = .scaleAspectFill
        
        // MARK: PRESSURE:
        
        weatherPressure.play()
        weatherPressure.loopMode = .loop
        weatherPressure.animationSpeed = 0.7
        
        // MARK: PRESSURE VIEW:

        pressureView.layer.masksToBounds = true
        pressureView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = pressureView.bounds
        pressureView.addSubviews(blurEffectView, pressureLabel)
        
        // MARK: PRESSURE LABEL:
        
        pressureLabel.textColor = .white
        pressureLabel.font = fontMediumStandard14
        pressureLabel.numberOfLines = 0
        pressureLabel.adjustsFontSizeToFitWidth = true
        pressureLabel.textAlignment = .center
        pressureLabel.text = NSLocalizedString("Pressure weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
