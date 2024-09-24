import AlertKit
import MapKit
import Network
import SafariServices
import UIKit
import WebKit

final class DropZonesVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let mapView = MKMapView()
    private let infoButton = UIButton()
    private let locationManager = CLLocationManager()
    private let currentLocationButton = UIButton()
    private let mapTypeButton = UIButton()
    private let closeButton = UIButton(type: .system)
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 36)
    private let mapConfigurator = MKHybridMapConfiguration(elevationStyle: .realistic)
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        getUserLocation()
        configureDropZonesPoints()
        configureGestures()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(mapView)
        mapView.addSubviews(infoButton, currentLocationButton, closeButton, mapTypeButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: MAP VIEW:

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: CURRENT LOCATION BUTTON:

        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -150).isActive = true
        currentLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true
        
        // MARK: INFO BUTTON:

        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.bottomAnchor.constraint(equalTo: currentLocationButton.topAnchor, constant: -20).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true
        
        // MARK: BACK BUTTON:

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 15).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 15).isActive = true

        // MARK: MAP TYPE BUTTON:
        
        mapTypeButton.translatesAutoresizingMaskIntoConstraints = false
        mapTypeButton.bottomAnchor.constraint(equalTo: infoButton.topAnchor, constant: -15).isActive = true
        mapTypeButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false
        
        // MARK: MAP VIEW:

        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.isRotateEnabled = false
        mapView.preferredConfiguration = mapConfigurator
        
        // MARK: BACK BUTTON:

        closeButton.setTitle("   " + NSLocalizedString("Close", comment: "") + "   ", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = cornerRadius15
        closeButton.backgroundColor = .colorTabBar
        closeButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        
        // MARK: INFO BUTTON:

        let infoImage = UIImage(systemName: "info.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        // MARK: CURRENT LOCATION BUTTON:

        let locationImage = UIImage(systemName: "location.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        currentLocationButton.setImage(locationImage, for: .normal)
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        
        // MARK: MAP TYPE BUTTON:
        
        let mapImage = UIImage(systemName: "map.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        mapTypeButton.setImage(mapImage, for: .normal)
        mapTypeButton.addTarget(self, action: #selector(mapTypeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: GET USER LOCATION:
    
    private func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CONFIGURE DROP ZONES:
    
    private func configureDropZonesPoints() {
        // MARK: - BELARUS:

//        let lipki = MKPointAnnotation()
//        lipki.coordinate = CLLocationCoordinate2D(latitude: 53.909962, longitude: 27.703807)
//        lipki.title = "Lipki"
//        lipki.subtitle = "Skydive Minsk"
//        mapView.addAnnotation(lipki)
    }
    
    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapMapAction))
        longPressGesture.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: - HELPERS:
    
    // MARK: MAP TYPE BUTTON ACTION:

    @objc private func mapTypeButtonTapped() {
        let alertController = UIAlertController(title: NSLocalizedString("Map type", comment: ""), message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Standard / map type", comment: ""), style: .default) { _ in
            self.mapView.mapType = .standard
        })
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Satellite / map type", comment: ""), style: .default) { _ in
            self.mapView.mapType = .satellite
        })
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Hybrid / map type", comment: ""), style: .default) { _ in
            self.mapView.mapType = .hybrid
        })
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel))
        present(alertController, animated: true)
    }
    
    // MARK: BACK BUTTON:
    
    @objc private func backupButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: FUNC FOR CURRENT LOCATION:

    @objc private func currentLocationButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        guard let cordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: cordinate,
                                                  latitudinalMeters: 250,
                                                  longitudinalMeters: 250)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: INFO BUTTON:
    
    @objc private func infoButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("Information / drop zones", comment: ""), message: NSLocalizedString("Info map / map view", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        present(alert, animated: true)
    }
    
    // MARK: FUNC FOR ADD NEW POINT:

    @objc func tapMapAction(recognizer: UITapGestureRecognizer) {
        let touch = recognizer.location(in: mapView)
        let coord = mapView.convert(touch, toCoordinateFrom: mapView)

        let alert = UIAlertController(title: NSLocalizedString("Create point / map view", comment: ""), message: NSLocalizedString("Create point description / map view", comment: ""), preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = NSLocalizedString("Name of point / map view", comment: "")
        }
        alert.addTextField { textFieldDescription in
            textFieldDescription.placeholder = NSLocalizedString("Description of point / map view", comment: "")
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("Send / community", comment: ""), style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            checkInternetConnection { [weak self] isConnected in
                guard let self = self else { return }
                
                if !isConnected {
                    DispatchQueue.main.async {
                        self.showAlertWithMessage(
                            title: NSLocalizedString("Error / alert kit", comment: ""),
                            message: NSLocalizedString("Message / adapty", comment: "")
                        )
                        self.alertKitError()
                    }
                    return
                }
            }
            guard let textField = alert.textFields?.first, let name = textField.text, !name.isEmpty, let textFieldDescription = alert.textFields?.last, let subTitle = textFieldDescription.text, !subTitle.isEmpty else {
                return
            }
            let point = MKPointAnnotation()
            point.coordinate = coord
            point.title = name
            point.subtitle = subTitle
            sendTelegramMessage(message: "Добавлена новая локация.\nНазвание: \(name)\nОписание: \(subTitle).\nКоординаты: \(coord.latitude), \(coord.longitude)")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: CHECK INTERNET CONNECTION:
    
    private func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
            monitor.cancel()
        }
        monitor.start(queue: queue)
    }
    
    // MARK: SEND TELEGRAM MESSAGE:
    
    func sendTelegramMessage(message: String) {
        let botToken = "7264425174:AAGOBEeZrrYhQSwrWPcwMURy90kfW65UlSg"
        let chatID = "298098804,"
        
        let messageText = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.telegram.org/bot\(botToken)/sendMessage?chat_id=\(chatID)&text=\(messageText)"
        
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] _, _, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    print("Ошибка при отправке сообщения в Telegram: \(error.localizedDescription)")
                    self.alertKitError()
                }
                return
            }
            DispatchQueue.main.async {
                self.showAlertWithMessage(title: NSLocalizedString("Success / alert kit", comment: ""), message: NSLocalizedString("Success / community", comment: ""))
                self.alertKitSuccess()
            }
        }
        task.resume()
    }
    
    // MARK: SHOW ALERT WITH MESSAGE:

    private func showAlertWithMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / alert kit", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
}

// MARK: - EXTENSION. SAFARI VIEW CONTROLLER DELEGATE:

extension DropZonesVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}

extension DropZonesVC: CLLocationManagerDelegate {
    
}
