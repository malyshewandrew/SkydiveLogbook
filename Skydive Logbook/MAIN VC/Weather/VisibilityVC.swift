import Lottie
import UIKit

final class VisibilityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherVisibility = LottieAnimationView(name: "WeatherVisibility")
    private let weatherVisibilityBackground = LottieAnimationView(name: "WeatherVisibilityBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherVisibilityBackground, weatherVisibility)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: VISIBILITY BACKGROUND:

        weatherVisibilityBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherVisibilityBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherVisibilityBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherVisibilityBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherVisibilityBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: VISIBILITY:

        weatherVisibility.translatesAutoresizingMaskIntoConstraints = false
        weatherVisibility.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherVisibility.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherVisibility.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: VISIBILITY BACKGROUND:
        
        weatherVisibilityBackground.play()
        weatherVisibilityBackground.loopMode = .loop
        weatherVisibilityBackground.contentMode = .scaleAspectFill
        
        // MARK: VISIBILITY:
        
        weatherVisibility.play()
        weatherVisibility.loopMode = .loop
        weatherVisibility.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
