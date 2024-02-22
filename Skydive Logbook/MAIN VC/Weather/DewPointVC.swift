import Lottie
import UIKit

final class DewPointVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherDewPoint = LottieAnimationView(name: "WeatherDewPoint")
    private let weatherDewPointBackground = LottieAnimationView(name: "WeatherDewPointBackground")
    private let dewPointView = UIView()
    private let dewPointLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherDewPointBackground, weatherDewPoint, dewPointView)
        dewPointView.addSubviews(dewPointLabel)
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
        
        // MARK: DEW POINT VIEW:
        
        dewPointView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = dewPointView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = dewPointView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        dewPointView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dewPointView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: DEW POINT LABEL:
        
        dewPointLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointLabel.topAnchor.constraint(equalTo: dewPointView.topAnchor, constant: 20).isActive = true
        dewPointLabel.leadingAnchor.constraint(equalTo: dewPointView.leadingAnchor, constant: 10).isActive = true
        dewPointLabel.trailingAnchor.constraint(equalTo: dewPointView.trailingAnchor, constant: -10).isActive = true
        dewPointLabel.bottomAnchor.constraint(equalTo: dewPointView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: DEW POINT BACKGROUND:
        
        weatherDewPointBackground.play()
        weatherDewPointBackground.loopMode = .loop
        weatherDewPointBackground.contentMode = .scaleAspectFill
        
        // MARK: DEW POINT:
        
        weatherDewPoint.play()
        weatherDewPoint.loopMode = .loop
        weatherDewPoint.animationSpeed = 0.7
        
        // MARK: DEW POINT VIEW:

        dewPointView.layer.masksToBounds = true
        dewPointView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = dewPointView.bounds
        dewPointView.addSubviews(blurEffectView, dewPointLabel)
        
        // MARK: DEW POINT LABEL:
        
        dewPointLabel.textColor = .white
        dewPointLabel.font = fontMediumStandard14
        dewPointLabel.numberOfLines = 0
        dewPointLabel.adjustsFontSizeToFitWidth = true
        dewPointLabel.textAlignment = .center
        dewPointLabel.text = NSLocalizedString("Dew point weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
}

