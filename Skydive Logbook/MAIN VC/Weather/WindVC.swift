import Lottie
import UIKit

final class WindVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let windLottie = LottieAnimationView(name: "WeatherWind")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(windLottie)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WIND:

        windLottie.translatesAutoresizingMaskIntoConstraints = false
        windLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        windLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        windLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: WIND:
        
        windLottie.play()
        windLottie.loopMode = .loop
        windLottie.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
