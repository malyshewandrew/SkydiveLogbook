import Lottie
import UIKit

final class HumidityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let humidityLottie = LottieAnimationView(name: "WeatherHumidity")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(humidityLottie)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: HUMIDITY:

        humidityLottie.translatesAutoresizingMaskIntoConstraints = false
        humidityLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        humidityLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        humidityLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: HUMIDITY:
        
        humidityLottie.play()
        humidityLottie.loopMode = .loop
        humidityLottie.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
