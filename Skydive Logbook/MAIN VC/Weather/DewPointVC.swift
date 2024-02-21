import Lottie
import UIKit

final class DewPointVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherDewPoint = LottieAnimationView(name: "WeatherDewPoint")
    private let weatherDewPointBackground = LottieAnimationView(name: "WeatherDewPointBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherDewPointBackground, weatherDewPoint)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: DEW POINT BACKGROUND:

        weatherDewPointBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherDewPointBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherDewPointBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherDewPointBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherDewPointBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: DEW POINT:

        weatherDewPoint.translatesAutoresizingMaskIntoConstraints = false
        weatherDewPoint.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherDewPoint.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherDewPoint.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: DEW POINT BACKGROUND:
        
        weatherDewPointBackground.play()
        weatherDewPointBackground.loopMode = .loop
        weatherDewPointBackground.contentMode = .scaleToFill
        
        // MARK: DEW POINT:
        
        weatherDewPoint.play()
        weatherDewPoint.loopMode = .loop
        weatherDewPoint.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
}

