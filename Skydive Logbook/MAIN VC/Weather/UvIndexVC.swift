import Lottie
import UIKit

final class UvIndexVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherUvIndex = LottieAnimationView(name: "WeatherUvIndex")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherUvIndex)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: UVINDEX:

        weatherUvIndex.translatesAutoresizingMaskIntoConstraints = false
        weatherUvIndex.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherUvIndex.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherUvIndex.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: UVINDEX:
        
        weatherUvIndex.play()
        weatherUvIndex.loopMode = .loop
        weatherUvIndex.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
