import Lottie
import UIKit

final class WindVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherWind = LottieAnimationView(name: "WeatherWind")
    private let weatherWindBackground = LottieAnimationView(name: "WeatherWindBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherWindBackground, weatherWind)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: WIND BACKGROUND:

        weatherWindBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherWindBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherWindBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherWindBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherWindBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: WIND:

        weatherWind.translatesAutoresizingMaskIntoConstraints = false
        weatherWind.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherWind.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherWind.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: WIND BACKGROUND:
        
        weatherWindBackground.play()
        weatherWindBackground.loopMode = .loop
        weatherWindBackground.contentMode = .scaleAspectFill
        
        // MARK: WIND:
        
        weatherWind.play()
        weatherWind.loopMode = .loop
        weatherWind.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
