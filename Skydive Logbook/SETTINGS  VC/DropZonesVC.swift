import MapKit
import SafariServices
import UIKit
import WebKit

class DropZonesVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let mapView = MKMapView()
    private let infoButton = UIButton()
    private let vibrationOn = Vibration()
    private let locationManager = CLLocationManager()
    private let currentLocationButton = UIButton()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 40)
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        getUserLocation()
        configurePoints()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(mapView)
        mapView.addSubviews(infoButton, currentLocationButton)
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
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        
        // MARK: NAVIGATION CONTROLLER:
        navigationController?.navigationBar.isHidden = false
        
        // MARK: MAP VIEW:
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        let mapConfigurator = MKHybridMapConfiguration(elevationStyle: .realistic)
        mapView.preferredConfiguration = mapConfigurator
        
        // MARK: INFO BUTTON:
        let infoImage = UIImage(systemName: "mappin.and.ellipse.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        // MARK: CURRENT LOCATION BUTTON:

        let locationImage = UIImage(systemName: "location.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        currentLocationButton.setImage(locationImage, for: .normal)
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }
    
    // MARK: GET USER LOCATION:
    
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CONFIGURE DROP ZONES:
    
    private func configurePoints() {
        
        // BELARUS:
        let lipki = MKPointAnnotation()
        lipki.coordinate = CLLocationCoordinate2D(latitude: 53.909962, longitude: 27.703807)
        lipki.title = "Lipki"
        lipki.subtitle = "Skydive Minsk"
        mapView.addAnnotation(lipki)

        // UNITED ARAB EMIRATES:
        let skydiveDubaiPalm = MKPointAnnotation()
        skydiveDubaiPalm.coordinate = CLLocationCoordinate2D(latitude: 25.091480, longitude: 55.135047)
        skydiveDubaiPalm.title = "Skydive Dubai"
        skydiveDubaiPalm.subtitle = "The Palm At Skydive Dubai"
        mapView.addAnnotation(skydiveDubaiPalm)
        
        let skydiveDubaiDesert = MKPointAnnotation()
        skydiveDubaiDesert.coordinate = CLLocationCoordinate2D(latitude: 24.885379, longitude: 55.548078)
        skydiveDubaiDesert.title = "Skydive Dubai"
        skydiveDubaiDesert.subtitle = "The Desert Campus at Skydive Dubai"
        mapView.addAnnotation(skydiveDubaiDesert)
        
        // USA: HAWAII:
        let skydiveHawaii = MKPointAnnotation()
        skydiveHawaii.coordinate = CLLocationCoordinate2D(latitude: 21.5788317518325, longitude: -158.180809021)
        skydiveHawaii.title = "Hawaii"
        skydiveHawaii.subtitle = "Skydive Hawaii"
        mapView.addAnnotation(skydiveHawaii)
        
        // USA: CALIFORNIA:
        let bayAreaSkydiving = MKPointAnnotation()
        bayAreaSkydiving.coordinate = CLLocationCoordinate2D(latitude: 37.835015, longitude: -121.632784)
        bayAreaSkydiving.title = "Bay Area Skydiving"
        bayAreaSkydiving.subtitle = "California"
        mapView.addAnnotation(bayAreaSkydiving)
        
        // LATVIA:
        let skydiveLatvia = MKPointAnnotation()
        skydiveLatvia.coordinate = CLLocationCoordinate2D(latitude: 57.48525478983592, longitude: 24.670893796301062)
        skydiveLatvia.title = "Skydive Latvia"
        skydiveLatvia.subtitle = "Langaci-Limbazi Airport Limbazu pagasts"
        mapView.addAnnotation(skydiveLatvia)
    }
    
    // MARK: - HELPERS:
    
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
        let alert = UIAlertController(title: NSLocalizedString("Drop Zones / drop zones", comment: ""), message: NSLocalizedString("Message / drop zones", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
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
