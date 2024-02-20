import Lottie
import UIKit

final class WindVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let windIndicatorLottie = LottieAnimationView(name: "WindIndicator")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(windIndicatorLottie)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WIND INDICATOR:

        windIndicatorLottie.translatesAutoresizingMaskIntoConstraints = false
        windIndicatorLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        windIndicatorLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        windIndicatorLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: WIND INDICATOR LOTTIE:
        
        windIndicatorLottie.play()
        windIndicatorLottie.loopMode = .loop
        windIndicatorLottie.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
