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
    private let backButton = UIButton()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 36)
    private let mapConfigurator = MKHybridMapConfiguration(elevationStyle: .realistic)
    
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
        mapView.addSubviews(infoButton, currentLocationButton, backButton, mapTypeButton)
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

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 15).isActive = true
        backButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 15).isActive = true
        
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
        mapView.preferredConfiguration = mapConfigurator
        
        // MARK: BACK BUTTON:

        backButton.setTitle(NSLocalizedString("Close", comment: ""), for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        
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
    
    private func configurePoints() {
        // MARK: - BELARUS:

        let lipki = MKPointAnnotation()
        lipki.coordinate = CLLocationCoordinate2D(latitude: 53.909962, longitude: 27.703807)
        lipki.title = "Lipki"
        lipki.subtitle = "Skydive Minsk"
        mapView.addAnnotation(lipki)
        
        let hozhevo = MKPointAnnotation()
        hozhevo.coordinate = CLLocationCoordinate2D(latitude: 54.252339, longitude: 26.867862)
        hozhevo.title = "Hozhevo"
        hozhevo.subtitle = "Skydive Minsk"
        mapView.addAnnotation(hozhevo)
        
        let sincha = MKPointAnnotation()
        sincha.coordinate = CLLocationCoordinate2D(latitude: 53.455188, longitude: 28.093508)
        sincha.title = "Sincha"
        sincha.subtitle = "Skydive Minsk"
        mapView.addAnnotation(sincha)
        
        let kukovyachino = MKPointAnnotation()
        kukovyachino.coordinate = CLLocationCoordinate2D(latitude: 55.159721, longitude: 29.974239)
        kukovyachino.title = "Kukovyachino"
        kukovyachino.subtitle = "Skydive Vitebsk"
        mapView.addAnnotation(kukovyachino)
        
        let mihalin = MKPointAnnotation()
        mihalin.coordinate = CLLocationCoordinate2D(latitude: 51.988815, longitude: 23.907536)
        mihalin.title = "Mihalin"
        mihalin.subtitle = "Skydive Brest"
        mapView.addAnnotation(mihalin)
        
        let pashkovo = MKPointAnnotation()
        pashkovo.coordinate = CLLocationCoordinate2D(latitude: 53.945857, longitude: 30.240983)
        pashkovo.title = "Pashkovo"
        pashkovo.subtitle = "Skydive Mogilev"
        mapView.addAnnotation(pashkovo)
        
        let zyabrovka = MKPointAnnotation()
        zyabrovka.coordinate = CLLocationCoordinate2D(latitude: 52.300540, longitude: 31.160671)
        zyabrovka.title = "Zyabrovka"
        zyabrovka.subtitle = "Skydive Gomel"
        mapView.addAnnotation(zyabrovka)
        
        let karolino = MKPointAnnotation()
        karolino.coordinate = CLLocationCoordinate2D(latitude: 53.635119, longitude: 23.736646)
        karolino.title = "Karolino"
        karolino.subtitle = "Skydive Grodno"
        mapView.addAnnotation(karolino)
        
        // MARK: - UKRAINE:

        let fiveOkean = MKPointAnnotation()
        fiveOkean.coordinate = CLLocationCoordinate2D(latitude: 50.004567, longitude: 30.197923)
        fiveOkean.title = "5 okean"
        fiveOkean.subtitle = "Kiev South"
        mapView.addAnnotation(fiveOkean)
        
        let odessa = MKPointAnnotation()
        odessa.coordinate = CLLocationCoordinate2D(latitude: 46.42994, longitude: 30.677449)
        odessa.title = "Odessa"
        odessa.subtitle = "Odessa Liman"
        mapView.addAnnotation(odessa)
        
        // MARK: - UNITED ARAB EMIRATES:

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
        
        // MARK: - USA:
        
        // MARK: HAWAII:

        let skydiveHawaii = MKPointAnnotation()
        skydiveHawaii.coordinate = CLLocationCoordinate2D(latitude: 21.5788317518325, longitude: -158.180809021)
        skydiveHawaii.title = "Hawaii"
        skydiveHawaii.subtitle = "Skydive Hawaii"
        mapView.addAnnotation(skydiveHawaii)
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
        let alert = UIAlertController(title: NSLocalizedString("Drop Zones / drop zones", comment: ""), message: NSLocalizedString("Message / drop zones", comment: ""), preferredStyle: .alert)
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
