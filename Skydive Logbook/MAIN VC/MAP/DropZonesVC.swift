import MapKit
import SafariServices
import UIKit
import WebKit

final class DropZonesVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let mapView = MKMapView()
    private let infoButton = UIButton()
    private let vibrationOn = Vibration()
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
        self.vibrationOn.vibrationStandart()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: FUNC FOR CURRENT LOCATION:

    @objc private func currentLocationButtonTapped() {
        vibrationOn.vibrationStandart()
        guard let cordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: cordinate,
                                                  latitudinalMeters: 250,
                                                  longitudinalMeters: 250)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: INFO BUTTON:
    
    @objc private func infoButtonTapped() {
        vibrationOn.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("Information / drop zones", comment: ""), message: NSLocalizedString("Message / drop zones", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Instagram", comment: ""), style: .default, handler: { _ in
            self.tapInstagramButton()
        }))
        present(alert, animated: true)
    }
    
    // MARK: TRANSITION ON INSTAGRAM:
    
    private func tapInstagramButton() {
        guard let url = URL(string: "https://instagram.com/skydivebook") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
}

// MARK: - EXTENSION. SAFARI VIEW CONTROLLER DELEGATE:

extension DropZonesVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}

extension DropZonesVC: CLLocationManagerDelegate {}
