import Lottie
import UIKit

final class CloudCoverVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherCloudCover = LottieAnimationView(name: "WeatherCloudCover")
    private let weatherCloudCoverBackground = LottieAnimationView(name: "WeatherCloudCoverBackground")
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherCloudCoverBackground, weatherCloudCover)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: CLOUD COVER BACKGROUND:

        weatherCloudCoverBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherCloudCoverBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherCloudCoverBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherCloudCoverBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherCloudCoverBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: CLOUD COVER:

        weatherCloudCover.translatesAutoresizingMaskIntoConstraints = false
        weatherCloudCover.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherCloudCover.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherCloudCover.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: CLOUD COVER BACKGROUND:
        
        weatherCloudCoverBackground.play()
        weatherCloudCoverBackground.loopMode = .loop
        weatherCloudCoverBackground.contentMode = .scaleToFill
        
        // MARK: CLOUD COVER:
        
        weatherCloudCover.play()
        weatherCloudCover.loopMode = .loop
        weatherCloudCover.animationSpeed = 0.7
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
