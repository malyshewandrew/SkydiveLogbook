import Lottie
import UIKit

final class TemperatureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherTemperature = LottieAnimationView(name: "WeatherTemperature")
    private let weatherTemperatureBackground = LottieAnimationView(name: "WeatherTemperatureBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherTemperatureBackground, weatherTemperature)
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
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
