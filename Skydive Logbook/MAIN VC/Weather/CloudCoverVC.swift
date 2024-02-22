import Lottie
import UIKit

final class CloudCoverVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherCloudCover = LottieAnimationView(name: "WeatherCloudCover")
    private let weatherCloudCoverBackground = LottieAnimationView(name: "WeatherCloudCoverBackground")
    private let cloudCoverView = UIView()
    private let cloudCoverLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherCloudCoverBackground, weatherCloudCover, cloudCoverView)
        cloudCoverView.addSubviews(cloudCoverLabel)
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
        
//        // MARK: CLOUD COVER VIEW:
//
//        cloudCoverView.translatesAutoresizingMaskIntoConstraints = false
//        let bottomConstraint = cloudCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
//        bottomConstraint.isActive = true
//        let heightConstraint = cloudCoverView.heightAnchor.constraint(equalTo: cloudCoverLabel.heightAnchor, constant: 20)
//        heightConstraint.priority = .defaultHigh
//        heightConstraint.isActive = true
//        cloudCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        cloudCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        
//        // MARK: CLOUD COVER LABEL:
//        
//        cloudCoverLabel.translatesAutoresizingMaskIntoConstraints = false
//        cloudCoverLabel.topAnchor.constraint(equalTo: cloudCoverView.topAnchor, constant: 20).isActive = true
//        cloudCoverLabel.leadingAnchor.constraint(equalTo: cloudCoverView.leadingAnchor, constant: 10).isActive = true
//        cloudCoverLabel.trailingAnchor.constraint(equalTo: cloudCoverView.trailingAnchor, constant: -10).isActive = true
//        cloudCoverLabel.bottomAnchor.constraint(equalTo: cloudCoverView.bottomAnchor, constant: -20).isActive = true
        
        // MARK: CLOUD COVER VIEW:
        cloudCoverView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = cloudCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = cloudCoverView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        cloudCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cloudCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        // MARK: CLOUD COVER LABEL:
        cloudCoverLabel.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverLabel.topAnchor.constraint(equalTo: cloudCoverView.topAnchor, constant: 20).isActive = true
        cloudCoverLabel.leadingAnchor.constraint(equalTo: cloudCoverView.leadingAnchor, constant: 10).isActive = true
        cloudCoverLabel.trailingAnchor.constraint(equalTo: cloudCoverView.trailingAnchor, constant: -10).isActive = true
        cloudCoverLabel.bottomAnchor.constraint(equalTo: cloudCoverView.bottomAnchor, constant: -20).isActive = true

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
        
        // MARK: HUMIDITY VIEW:

        cloudCoverView.layer.masksToBounds = true
        cloudCoverView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = cloudCoverView.bounds
        cloudCoverView.addSubviews(blurEffectView, cloudCoverLabel)
        
        // MARK: HUMIDITY LABEL:
        
        cloudCoverLabel.textColor = .white
        cloudCoverLabel.font = fontMediumStandard14
        cloudCoverLabel.numberOfLines = 0
        cloudCoverLabel.adjustsFontSizeToFitWidth = true
        cloudCoverLabel.textAlignment = .center
        cloudCoverLabel.text = NSLocalizedString("Cloud cover weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: - EXTENSION:
}
