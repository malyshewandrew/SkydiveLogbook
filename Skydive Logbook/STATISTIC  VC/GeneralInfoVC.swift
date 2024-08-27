import Lottie
import UIKit

final class GeneralInfoVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let lineEarthView = UIView()
    private let earthLabel = UILabel()
    private let zeroView = UIView()
    private let flyView = UIView()
    private let flyLabel = UILabel()
    private let amazonLiew = UIView()
    private let amazonLabel = UILabel()
    private let moonView = UIView()
    private let moonLabel = UILabel()
    private let zeroLabel = UILabel()
    private let backgroundGeneralInfoLottie = LottieAnimationView(name: "BackgroundGeneralInfo")
    private let effectEarthLottie = LottieAnimationView(name: "EffectEarth")
    private let blurEarthLottie = LottieAnimationView(name: "BlurEarth")
    private let earthLottie = LottieAnimationView(name: "EarthLottie")
    private let earthButton = UIButton()
    private let positionView = UIView()
    private let positionLabel = UILabel()
    private var heightEarthLottie: CGFloat = 0.0
    var heightpPosition: CGFloat = 0.0
    var heightLabel = UILabel()
    var timeLabel = UILabel()
    private let vibration = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        heightEarthLottie = earthLottie.frame.height / 2.25
        
        let ratio: CGFloat = heightpPosition / 12710
        let positionOffset = heightEarthLottie * ratio
        
        lineEarthView.centerYAnchor.constraint(equalTo: earthLottie.centerYAnchor, constant: -heightEarthLottie - (heightEarthLottie / 2)).isActive = true
        positionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -heightEarthLottie/2 + -positionOffset).isActive = true
        zeroView.centerYAnchor.constraint(equalTo: earthLottie.centerYAnchor, constant: -heightEarthLottie/2).isActive = true
        amazonLiew.centerYAnchor.constraint(equalTo: earthLottie.centerYAnchor, constant: -heightEarthLottie).isActive = true
        flyView.centerYAnchor.constraint(equalTo: earthLottie.centerYAnchor, constant: -heightEarthLottie - (heightEarthLottie/4)).isActive = true
        moonView.centerYAnchor.constraint(equalTo: earthLottie.centerYAnchor, constant: -heightEarthLottie/2 - (heightEarthLottie/4)).isActive = true
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(backgroundGeneralInfoLottie, blurEarthLottie, effectEarthLottie, earthLottie, earthButton, lineEarthView, earthLabel, flyView, flyLabel, amazonLiew, amazonLabel, moonView, moonLabel, zeroView, zeroLabel, positionView, positionLabel, heightLabel, timeLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // BACKGROUND GENERAL INFO LOTTIE:
        backgroundGeneralInfoLottie.translatesAutoresizingMaskIntoConstraints = false
        backgroundGeneralInfoLottie.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundGeneralInfoLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundGeneralInfoLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundGeneralInfoLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // BLUR EARTH:
        blurEarthLottie.translatesAutoresizingMaskIntoConstraints = false
        blurEarthLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blurEarthLottie.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        blurEarthLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        blurEarthLottie.heightAnchor.constraint(equalTo: blurEarthLottie.widthAnchor, multiplier: 1).isActive = true
        
        // EFFECT EARTH:
        effectEarthLottie.translatesAutoresizingMaskIntoConstraints = false
        effectEarthLottie.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        effectEarthLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        effectEarthLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        effectEarthLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // EARTH LOTTIE:
        earthLottie.translatesAutoresizingMaskIntoConstraints = false
        earthLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        earthLottie.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        earthLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        earthLottie.heightAnchor.constraint(equalTo: earthLottie.widthAnchor, multiplier: 1).isActive = true
        
        // EARTH BUTTON:
        earthButton.translatesAutoresizingMaskIntoConstraints = false
        earthButton.topAnchor.constraint(equalTo: earthLottie.topAnchor).isActive = true
        earthButton.bottomAnchor.constraint(equalTo: earthLottie.bottomAnchor).isActive = true
        earthButton.leadingAnchor.constraint(equalTo: earthLottie.leadingAnchor).isActive = true
        earthButton.trailingAnchor.constraint(equalTo: earthLottie.trailingAnchor).isActive = true
        
        // HEIGHT LABEL:
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heightLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        // TIME LABEL:
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        // LINE EARTH VIEW:
        lineEarthView.translatesAutoresizingMaskIntoConstraints = false
        lineEarthView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        lineEarthView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineEarthView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        // EARTH LABEL:
        earthLabel.translatesAutoresizingMaskIntoConstraints = false
        earthLabel.trailingAnchor.constraint(equalTo: lineEarthView.leadingAnchor, constant: -5).isActive = true
        earthLabel.centerYAnchor.constraint(equalTo: lineEarthView.centerYAnchor).isActive = true
        
        // POSITION VIEW:
        positionView.translatesAutoresizingMaskIntoConstraints = false
        positionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        positionView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        positionView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // FLY VIEW:
        flyView.translatesAutoresizingMaskIntoConstraints = false
        flyView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        flyView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        flyView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        // FLY LABEL:
        flyLabel.translatesAutoresizingMaskIntoConstraints = false
        flyLabel.trailingAnchor.constraint(equalTo: flyView.leadingAnchor, constant: -5).isActive = true
        flyLabel.centerYAnchor.constraint(equalTo: flyView.centerYAnchor).isActive = true
        
        // AMAZON VIEW:
        amazonLiew.translatesAutoresizingMaskIntoConstraints = false
        amazonLiew.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        amazonLiew.heightAnchor.constraint(equalToConstant: 1).isActive = true
        amazonLiew.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        // AMAZON LABEL:
        amazonLabel.translatesAutoresizingMaskIntoConstraints = false
        amazonLabel.trailingAnchor.constraint(equalTo: amazonLiew.leadingAnchor, constant: -5).isActive = true
        amazonLabel.centerYAnchor.constraint(equalTo: amazonLiew.centerYAnchor).isActive = true
        
        // MOON VIEW:
        moonView.translatesAutoresizingMaskIntoConstraints = false
        moonView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        moonView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        moonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        // MOON LABEL:
        moonLabel.translatesAutoresizingMaskIntoConstraints = false
        moonLabel.trailingAnchor.constraint(equalTo: moonView.leadingAnchor, constant: -5).isActive = true
        moonLabel.centerYAnchor.constraint(equalTo: moonView.centerYAnchor).isActive = true
        
        // ZERO VIEW:
        zeroView.translatesAutoresizingMaskIntoConstraints = false
        zeroView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        zeroView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        zeroView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        // ZERO LABEL:
        zeroLabel.translatesAutoresizingMaskIntoConstraints = false
        zeroLabel.trailingAnchor.constraint(equalTo: zeroView.leadingAnchor, constant: -5).isActive = true
        zeroLabel.centerYAnchor.constraint(equalTo: zeroView.centerYAnchor).isActive = true
        
        // POSITION LABEL:
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.leadingAnchor.constraint(equalTo: positionView.trailingAnchor, constant: 5).isActive = true
        positionLabel.centerYAnchor.constraint(equalTo: positionView.centerYAnchor).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // BACKGROUND GENERAL INFO LOTTIE:
        backgroundGeneralInfoLottie.play()
        backgroundGeneralInfoLottie.loopMode = .loop
        backgroundGeneralInfoLottie.layer.opacity = 0.5
        backgroundGeneralInfoLottie.contentMode = .scaleAspectFill
        
        // MARK: BLUR EARTH:
        
        blurEarthLottie.play()
        blurEarthLottie.loopMode = .loop
        blurEarthLottie.animationSpeed = 1
        blurEarthLottie.layer.opacity = 0.5
        
        // EFFECT EARTH:
        effectEarthLottie.loopMode = .playOnce
        effectEarthLottie.isHidden = true
        
        // MARK: EARTH LOTTIE:
        
        earthLottie.play()
        earthLottie.loopMode = .loop
        earthLottie.animationSpeed = 0.7
        
        // MARK: EARTH BUTTON:
        
        earthButton.addTarget(self, action: #selector(earthButtonTapped), for: .touchUpInside)
        
        // MARK: HEIGHT LABEL:
        
        heightLabel.textColor = .colorWhite
        heightLabel.textAlignment = .center
        heightLabel.numberOfLines = 1
        heightLabel.font = fontBoldStandard30
        heightLabel.layer.opacity = 0.5
        heightLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: TIME LABEL:
        timeLabel.textColor = .colorWhite
        timeLabel.textAlignment = .center
        timeLabel.numberOfLines = 1
        timeLabel.font = fontBoldStandard30
        timeLabel.layer.opacity = 0.5
        timeLabel.adjustsFontSizeToFitWidth = true
        
        // LINE EARTH VIEW:
        lineEarthView.backgroundColor = .colorLineEarth
        
        // EARTH LABEL:
        earthLabel.textColor = .colorWhite
        earthLabel.font = fontThinStandard10
        earthLabel.text = NSLocalizedString("Height of the Earth", comment: "")
        earthLabel.adjustsFontSizeToFitWidth = true
        
        // POSITION VIEW:
        positionView.backgroundColor = .red
        positionView.layer.cornerRadius = 2.5
        
        // FLY VIEW:
        flyView.backgroundColor = .colorLineEarth
        
        // FLY LABEL:
        flyLabel.textColor = .colorWhite
        flyLabel.font = fontThinStandard10
        flyLabel.text = NSLocalizedString("NASA ships", comment: "")
        flyLabel.adjustsFontSizeToFitWidth = true
        
        // AMAZON VIEW:
        amazonLiew.backgroundColor = .colorLineEarth
        
        // AMAZON LABEL:
        amazonLabel.textColor = .colorWhite
        amazonLabel.font = fontThinStandard10
        amazonLabel.text = NSLocalizedString("Height of the Mars", comment: "")
        amazonLabel.adjustsFontSizeToFitWidth = true
        
        // MOON VIEW:
        moonView.backgroundColor = .colorLineEarth
        
        // MOON LABEL:
        moonLabel.textColor = .colorWhite
        moonLabel.font = fontThinStandard10
        moonLabel.text = NSLocalizedString("Height of the Moon", comment: "")
        moonLabel.adjustsFontSizeToFitWidth = true
        
        // ZERO VIEW:
        zeroView.backgroundColor = .colorLineEarth
        
        // ZERO LABEL:
        zeroLabel.textColor = .colorWhite
        zeroLabel.font = fontThinStandard10
        zeroLabel.text = NSLocalizedString("Ground of the Earth", comment: "")
        zeroLabel.adjustsFontSizeToFitWidth = true
        
        // POSITION LABEL:
        positionLabel.textColor = .colorWhite
        positionLabel.font = fontThinStandard10
        positionLabel.text = NSLocalizedString("Your position", comment: "")
        positionLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - HELPERS:
    
    // EARTH BUTTON:
    @objc private func earthButtonTapped() {
        vibration.vibrationStandart()
        positionView.layer.opacity = 0.0
        positionLabel.layer.opacity = 0.0
        blurEarthLottie.layer.opacity = 1.0
        effectEarthLottie.isHidden = false
        effectEarthLottie.play()
        let randomSpeed: Double = Double.random(in: 0.5...3.5)
        let randomEffectSpeed: Double = Double.random(in: 0.1...1)
        UIView.animate(withDuration: 2) { [weak self] in
            guard let self = self else { return }
            self.earthLottie.animationSpeed = randomSpeed
            blurEarthLottie.animationSpeed = randomEffectSpeed
            positionView.layer.opacity = 1.0
            positionLabel.layer.opacity = 1.0
            blurEarthLottie.layer.opacity = 0.5
        }
    }
}
