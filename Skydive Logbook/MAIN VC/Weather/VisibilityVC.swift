import Lottie
import UIKit

final class VisibilityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherVisibility = LottieAnimationView(name: "WeatherVisibility")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherVisibility)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
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
        
        // MARK: VISIBILITY:
        
        weatherVisibility.play()
        weatherVisibility.loopMode = .loop
        weatherVisibility.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
