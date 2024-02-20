import Lottie
import UIKit

final class DewPointVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let dewPointLottie = LottieAnimationView(name: "WeatherDewPoint")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(dewPointLottie)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: DEW POINT:

        dewPointLottie.translatesAutoresizingMaskIntoConstraints = false
        dewPointLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        dewPointLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dewPointLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: DEW POINT:
        
        dewPointLottie.play()
        dewPointLottie.loopMode = .loop
        dewPointLottie.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
