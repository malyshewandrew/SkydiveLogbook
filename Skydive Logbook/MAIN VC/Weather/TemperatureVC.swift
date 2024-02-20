import Lottie
import UIKit

final class TemperatureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let temperatureLottie = LottieAnimationView(name: "WeatherTemperature")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(temperatureLottie)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: TEMPERATURE:

        temperatureLottie.translatesAutoresizingMaskIntoConstraints = false
        temperatureLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        temperatureLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: TEMPERATURE:
        
        temperatureLottie.play()
        temperatureLottie.loopMode = .loop
        temperatureLottie.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
