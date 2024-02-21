import Lottie
import UIKit

final class PrecipitationVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherPrecipitation = LottieAnimationView(name: "WeatherPrecipitation")
    private let weatherPrecipitationBackground = LottieAnimationView(name: "WeatherPrecipitationBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherPrecipitationBackground, weatherPrecipitation)
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
        weatherPrecipitation.loopMode = .loop
        weatherPrecipitation.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
