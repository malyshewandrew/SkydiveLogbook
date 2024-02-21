import Lottie
import UIKit

final class HumidityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherHumidity = LottieAnimationView(name: "WeatherHumidity")
    private let weatherHumidityBackground = LottieAnimationView(name: "WeatherHumidityBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherHumidityBackground, weatherHumidity)
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
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
