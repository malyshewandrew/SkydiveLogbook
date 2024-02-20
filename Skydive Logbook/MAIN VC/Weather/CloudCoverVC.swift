import Lottie
import UIKit

final class CloudCoverVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let cloudCoverLottie = LottieAnimationView(name: "WeatherCloudCover")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(cloudCoverLottie)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: CLOUD COVER:

        cloudCoverLottie.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        cloudCoverLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cloudCoverLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: CLOUD COVER:
        
        cloudCoverLottie.play()
        cloudCoverLottie.loopMode = .loop
        cloudCoverLottie.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
