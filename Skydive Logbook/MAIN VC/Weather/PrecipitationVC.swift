import Lottie
import UIKit

final class PrecipitationVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherPrecipitation = LottieAnimationView(name: "WeatherPrecipitation")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherPrecipitation)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
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
        
        // MARK: PRECIPITATION:
        
        weatherPrecipitation.play()
        weatherPrecipitation.loopMode = .loop
        weatherPrecipitation.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
