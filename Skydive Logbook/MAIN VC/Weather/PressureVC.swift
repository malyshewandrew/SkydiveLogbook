import Lottie
import UIKit

final class PressureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherPressure = LottieAnimationView(name: "WeatherPressure")
    private let weatherPressureBackground = LottieAnimationView(name: "WeatherPressureBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherPressureBackground, weatherPressure)
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
        weatherPressure.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherPressure.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherPressure.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
