import AudioToolbox
import AVFoundation
import CoreImage
import CoreLocation
import Lottie
import UIKit

final class ParametersVC: UIViewController {
    // MARK: - PROPERTIES:

    private let parametersBackgroundLottie = LottieAnimationView(name: "ParametersBackgroundLottie")
    private let parametersEffectLottie = LottieAnimationView(name: "ParametersEffect")
    
    private let loadingParametersLottie = LottieAnimationView(name: "LoadingParameters")
    private let altitudeButton = UIButton()
    private let altitudeLabel = UILabel()
    private let updateDate = UILabel()
    private let compasImageView = UIImageView()
    private let degreesLabel = UILabel()
    private let redLineView = UIView()
    private let speedLabel = UILabel()
    private let backgroundSpeedParametersLottie = LottieAnimationView(name: "BackgroundSpeedParameters")
    
    private let locationManager = CLLocationManager()
    private var headingManager: CLLocationManager?
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 60)
    
    private let dateFormatter = DateFormatter()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        setupLocationManager()
        configureAltitudeButton()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(parametersBackgroundLottie, parametersEffectLottie, redLineView, loadingParametersLottie, altitudeLabel, backgroundSpeedParametersLottie, speedLabel, degreesLabel, compasImageView, updateDate, altitudeButton)
    }

    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: ALTIMETER BACKGROUND:
        
        parametersBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        parametersBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        parametersBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        parametersBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        parametersBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 250).isActive = true
        
        // MARK: ALTIMETER EFFECT LOTTIE:
        
        parametersEffectLottie.translatesAutoresizingMaskIntoConstraints = false
        parametersEffectLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parametersEffectLottie.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        parametersEffectLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        
        // MARK: LONG PRESS LOTTIE:
        
        loadingParametersLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingParametersLottie.centerXAnchor.constraint(equalTo: altitudeLabel.centerXAnchor).isActive = true
        loadingParametersLottie.centerYAnchor.constraint(equalTo: altitudeLabel.centerYAnchor).isActive = true
        loadingParametersLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        loadingParametersLottie.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: ALTITUDE BUTTON:
        
        altitudeButton.translatesAutoresizingMaskIntoConstraints = false
        altitudeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        altitudeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        
        // MARK: LAST UPDATE LABEL:
        
        updateDate.translatesAutoresizingMaskIntoConstraints = false
        updateDate.topAnchor.constraint(equalTo: altitudeLabel.bottomAnchor, constant: -10).isActive = true
        updateDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateDate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        updateDate.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: ALTITUDE LABEL:
        
        altitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        altitudeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        altitudeLabel.bottomAnchor.constraint(equalTo: compasImageView.topAnchor, constant: -35).isActive = true
        altitudeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        
        // MARK: RED LINE VIEW:
        
        redLineView.translatesAutoresizingMaskIntoConstraints = false
        redLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redLineView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        redLineView.heightAnchor.constraint(equalToConstant: height75 * 2.5 - 24).isActive = true
        redLineView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: COMPAS IMAGE:
        
        compasImageView.translatesAutoresizingMaskIntoConstraints = false
        compasImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        compasImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        compasImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        compasImageView.heightAnchor.constraint(equalTo: compasImageView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: DEGREES LABEL:
        
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false
        degreesLabel.centerXAnchor.constraint(equalTo: compasImageView.centerXAnchor).isActive = true
        degreesLabel.centerYAnchor.constraint(equalTo: compasImageView.centerYAnchor).isActive = true
        degreesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        degreesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: BACKGROUND SPEED PARAMETERS LOTTIE:
        
        backgroundSpeedParametersLottie.translatesAutoresizingMaskIntoConstraints = false
        backgroundSpeedParametersLottie.centerXAnchor.constraint(equalTo: speedLabel.centerXAnchor).isActive = true
        backgroundSpeedParametersLottie.centerYAnchor.constraint(equalTo: speedLabel.centerYAnchor).isActive = true
        backgroundSpeedParametersLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.5).isActive = true
        
        // MARK: SPEED LABEL:
        
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        speedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        view.backgroundColor = .black
        
        // MARK: ALTIMETER BACKGROUND:
        
        parametersBackgroundLottie.loopMode = .loop
        parametersBackgroundLottie.animationSpeed = 1
        parametersBackgroundLottie.contentMode = .scaleAspectFill
        parametersBackgroundLottie.play()
        
        // MARK: ALTIMETER EFFECT LOTTIE:
        
        parametersEffectLottie.play()
        parametersEffectLottie.loopMode = .loop
        parametersEffectLottie.animationSpeed = 0.5
        parametersEffectLottie.layer.shadowRadius = 25
        parametersEffectLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        parametersEffectLottie.layer.shadowOpacity = 1
        
        // MARK: ALTITUDE BUTTON:
        
        altitudeButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath.circle.fill", withConfiguration: configurationImage), for: .normal)
        altitudeButton.tintColor = .white
        altitudeButton.layer.shadowRadius = 50
        altitudeButton.layer.shadowColor = UIColor.colorLightBlue.cgColor
        altitudeButton.layer.shadowOpacity = 1
        altitudeButton.addTarget(self, action: #selector(altitudeButtonTapped), for: .touchUpInside)
        
        // MARK: LOADING PARAMETERS LOTTIE:
        
        loadingParametersLottie.layer.opacity = 0.0
        
        // MARK: LAST UPDATE LABEL:
        
        updateDate.textColor = .systemGreen
        updateDate.textAlignment = .center
        updateDate.font = FontManager.thin(size: 10).uiFont
        updateDate.layer.shadowRadius = 25
        updateDate.layer.shadowColor = UIColor.colorLightBlue.cgColor
        updateDate.layer.shadowOpacity = 1
        
        // MARK: ALTITUDE LABEL:
        
        altitudeLabel.textColor = .white
        altitudeLabel.textAlignment = .center
        altitudeLabel.font = FontManager.regular(size: 72).uiFont
        altitudeLabel.layer.shadowRadius = 25
        altitudeLabel.layer.shadowColor = UIColor.colorLightBlue.cgColor
        altitudeLabel.layer.shadowOpacity = 1
        
        // MARK: RED LINE VIEW:
        
        redLineView.backgroundColor = .systemRed
        redLineView.layer.shadowRadius = 25
        redLineView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        redLineView.layer.shadowOpacity = 1
        
        // MARK: COMPAS IMAGE:
        
        compasImageView.image = UIImage(named: "Compas")
        compasImageView.layer.shadowRadius = 25
        compasImageView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        compasImageView.layer.shadowOpacity = 1
        
        // MARK: DEGREES LABEL:
        
        degreesLabel.textColor = .white
        degreesLabel.textAlignment = .center
        degreesLabel.font = FontManager.regular(size: 50).uiFont
        degreesLabel.layer.shadowRadius = 25
        degreesLabel.layer.shadowColor = UIColor.colorLightBlue.cgColor
        degreesLabel.layer.shadowOpacity = 1
        
        // MARK: BACKGROUND SPEED PARAMETERS LOTTIE:
        
        backgroundSpeedParametersLottie.play()
        backgroundSpeedParametersLottie.loopMode = .loop
        backgroundSpeedParametersLottie.animationSpeed = 0.5
        backgroundSpeedParametersLottie.layer.opacity = 0.5
        backgroundSpeedParametersLottie.layer.shadowRadius = 25
        backgroundSpeedParametersLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        backgroundSpeedParametersLottie.layer.shadowOpacity = 1
        
        // MARK: SPEED LABEL:
        
        speedLabel.textColor = .white
        speedLabel.textAlignment = .center
        speedLabel.font = FontManager.regular(size: 72).uiFont
        speedLabel.layer.shadowRadius = 25
        speedLabel.layer.shadowColor = UIColor.colorLightBlue.cgColor
        speedLabel.layer.shadowOpacity = 1
    }
    
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE ALTITUDE BUTTON:
    
    private func configureAltitudeButton() {
        if let savedDateString = UserDefaults.standard.string(forKey: "dateString") {
            dateFormatter.dateFormat = "dd.MM.yyyy / HH:mm:ss"
            if let savedDate = dateFormatter.date(from: savedDateString) {
                let currentDate = Date()
                if Calendar.current.isDate(savedDate, inSameDayAs: currentDate) {
                    updateDate.text = "[ \(savedDateString) ]"
                    stopBounce()
                } else {
                    updateDate.text = ""
                    startBounce()
                    altitudeLabel.layer.opacity = 0.0
                }
            }
        }
    }
    
    // MARK: ALTITUDE BUTTON TAPPED:
    
    @objc private func altitudeButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        changeAltitudeButton()
        let currentDate = Date()
        dateFormatter.dateFormat = "dd.MM.yyyy / HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        UserDefaults.standard.set(dateString, forKey: "dateString")
        
        if let lastLocation = locationManager.location {
            let first = Int(lastLocation.altitude)
            UserDefaults.standard.setValue(first, forKey: "first")
        }
        first()
        stopBounce()
    }
    
    // MARK: FIRST PAST TAPPED:
    
    private func first() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.loadingParametersLottie.layer.opacity = 1
                self?.loadingParametersLottie.play()
                self?.loadingParametersLottie.loopMode = .loop
                self?.altitudeLabel.layer.opacity = 0.0
                self?.updateDate.layer.opacity = 0.0
            }) { _ in
                self.second()
            }
        }
    }
    
    // MARK: SECOND PAST TAPPED:
    
    private func second() {
        guard let savedDateString = UserDefaults.standard.string(forKey: "dateString") else { return }
        updateDate.text = "[ \(savedDateString) ]"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1.5, animations: { [weak self = self] in
                guard let self = self else { return }
                loadingParametersLottie.layer.opacity = 0
                altitudeLabel.layer.opacity = 1
                updateDate.layer.opacity = 1
            })
        }
    }
    
    // MARK: START BOUNCE ANIMATION:
    
    private func startBounce() {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: { [weak self] in
            self?.altitudeButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { [weak self] _ in
            guard let self = self else { return }
            UIView.animate(withDuration: 1, animations: {
                self.altitudeButton.transform = CGAffineTransform.identity
            }) { [weak self] _ in
                self?.startBounce()
            }
        }
    }

    // MARK: STOP BOUNCE ANIMATION:

    private func stopBounce() {
        UIView.animate(withDuration: 0, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: { [weak self] in
            self?.altitudeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { [weak self] _ in
            UIView.animate(withDuration: 0, animations: { [weak self] in
                self?.altitudeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { [weak self] _ in
                self?.altitudeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    // MARK: CHANGE ALTITUDE BUTTON:
    
    private func changeAltitudeButton() {
        altitudeButton.tintColor = .clear
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) { [weak self] in
            self?.altitudeButton.tintColor = .white
        }
    }
    
    // MARK: LOCATION SERVICES:
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.headingAvailable() {
            headingManager = CLLocationManager()
            headingManager?.delegate = self
            headingManager?.startUpdatingHeading()
        }
    }

    private func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
}

// MARK: - EXTENISON:

extension ParametersVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            checkLocationServicesEnabled()
        case .denied, .restricted:
            showLocationSettingsAlert()
        case .notDetermined:
            showLocationSettingsAlert()
        @unknown default:
            showLocationSettingsAlert()
        }
    }
    
    // MARK: SPEED AND HEIGHT:

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // MARK: ALTITUDE:
        
        let altitude = Int(location.altitude)
        let first = UserDefaults.standard.integer(forKey: "first")
        altitudeLabel.text = "\(altitude - first) " + NSLocalizedString("m.", comment: "")
        
        // MARK: SPEED:
        
        let speed = location.speed
        let speedKPH = Int(speed * 3.6)
        speedLabel.text = "\(speedKPH) " + NSLocalizedString("km", comment: "") + "/" + NSLocalizedString("h.", comment: "")
    }
    
    // MARK: COMPASS:

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let trueHeading = newHeading.trueHeading
        let correctedHeading = trueHeading - 10.0
        let normalizedHeading = (correctedHeading + 360.0).truncatingRemainder(dividingBy: 360.0)
        let headingRadians = CGFloat(normalizedHeading) * .pi / 180.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.compasImageView.transform = CGAffineTransform(rotationAngle: -headingRadians)
        }
        degreesLabel.text = String(format: " %.0f°", normalizedHeading)
        VibrationManager.instance.vibrationLight()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    private func checkLocationServicesEnabled() {
        guard !Thread.isMainThread else {
            DispatchQueue.global().async { [weak self] in
                self?.checkLocationServicesEnabled()
            }
            return
        }
        guard CLLocationManager.locationServicesEnabled() else { return }
        startLocationUpdates()
    }
    
    // MARK: ERROR ACCESS ALERT:

    private func showLocationSettingsAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Error / alert kit", comment: ""),
                                      message: NSLocalizedString("Permisson label / weather", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Settings iphone", comment: ""), style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
