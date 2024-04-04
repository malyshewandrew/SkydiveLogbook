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
    private let closeButton = UIButton()
    
    private let dropZones: String = NSLocalizedString("Drop zones / drop zones", comment: "")
    private let windTunnels: String = NSLocalizedString("Wind tunnels / drop zones", comment: "")
    private let shops: String = NSLocalizedString("Shops / drop zones", comment: "")
    private var segmentControl = UISegmentedControl()
    
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 36)
    private let mapConfigurator = MKHybridMapConfiguration(elevationStyle: .realistic)
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        getUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentControl.selectedSegmentIndex = 0
        segmentedControlValueChanged(segmentControl)
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(mapView)
        mapView.addSubviews(infoButton, currentLocationButton, closeButton, segmentControl, mapTypeButton)
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
        
        // MARK: SEGMENT CONTROL:

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -25).isActive = true

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

        closeButton.setTitle(NSLocalizedString("Close", comment: ""), for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
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
        
        // MARK: SEGMENT CONTROL:

        segmentControl.insertSegment(withTitle: dropZones, at: 0, animated: true)
        segmentControl.insertSegment(withTitle: windTunnels, at: 1, animated: true)
        segmentControl.insertSegment(withTitle: shops, at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .colorCell
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
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
        
        // MARK: GERMANY:
        
        let goJumpBerlin = MKPointAnnotation()
        goJumpBerlin.coordinate = CLLocationCoordinate2D(latitude: 53.00409028648374, longitude: 13.206484198265958)
        goJumpBerlin.title = "GoJump Berlin"
        goJumpBerlin.subtitle = ""
        mapView.addAnnotation(goJumpBerlin)
        
        // MARK: SWEDEN:
        
        let skydiveStockholm = MKPointAnnotation()
        skydiveStockholm.coordinate = CLLocationCoordinate2D(latitude: 60.28603600967073, longitude: 17.42522949833224)
        skydiveStockholm.title = "Skydive Stockholm"
        skydiveStockholm.subtitle = "Skydive Stockholm"
        mapView.addAnnotation(skydiveStockholm)
        
        // MARK: NORVAY
        
        let skydiveOslo = MKPointAnnotation()
        skydiveOslo.coordinate = CLLocationCoordinate2D(latitude: 61.256814564874986, longitude: 11.671157069599577)
        skydiveOslo.title = "skydiveOslo"
        skydiveOslo.subtitle = "skydiveOslo"
        mapView.addAnnotation(skydiveOslo)
        
        let skydiveTonsberg = MKPointAnnotation()
        skydiveTonsberg.coordinate = CLLocationCoordinate2D(latitude: 59.2988761305857, longitude: 10.366905862083742)
        skydiveTonsberg.title = "Skydive Tønsberg"
        skydiveTonsberg.subtitle = "Skydive Tønsberg"
        mapView.addAnnotation(skydiveTonsberg)
    }
    
    // MARK: - CONFIGURE WIND TUNNELS:
    
    private func configureWindTunnelsPoints() {
        // MARK: - BELARUS:

        let iFlyMinsk = MKPointAnnotation()
        iFlyMinsk.coordinate = CLLocationCoordinate2D(latitude: 53.926960, longitude: 27.509481)
        iFlyMinsk.title = "iFLY"
        iFlyMinsk.subtitle = "iFLY Minsk"
        mapView.addAnnotation(iFlyMinsk)
        
        let flyAway = MKPointAnnotation()
        flyAway.coordinate = CLLocationCoordinate2D(latitude: 53.850693, longitude: 27.432016)
        flyAway.title = "FlyAway"
        flyAway.subtitle = "FlyAway Minsk"
        mapView.addAnnotation(flyAway)
        
        // MARK: - UKRAINE:
        
        let aerodiumKiev = MKPointAnnotation()
        aerodiumKiev.coordinate = CLLocationCoordinate2D(latitude: 50.373749, longitude: 30.446368)
        aerodiumKiev.title = "Aerodium"
        aerodiumKiev.subtitle = "Aerodium Kiev"
        mapView.addAnnotation(aerodiumKiev)
        
        // MARK: - LATVIA:
        
        let aerodiumSigulda = MKPointAnnotation()
        aerodiumSigulda.coordinate = CLLocationCoordinate2D(latitude: 57.133440, longitude: 24.786326)
        aerodiumSigulda.title = "Aerodium"
        aerodiumSigulda.subtitle = "Aerodium Sigulda"
        mapView.addAnnotation(aerodiumSigulda)
        
        // MARK: - POLAND:
        
        let flyspotPoland = MKPointAnnotation()
        flyspotPoland.coordinate = CLLocationCoordinate2D(latitude: 52.215476, longitude: 20.861399)
        flyspotPoland.title = "Flyspot"
        flyspotPoland.subtitle = "Warsaw Indoor Skydiving"
        mapView.addAnnotation(flyspotPoland)
        
        // MARK: - HUNGARY:

        let skywardBudapest = MKPointAnnotation()
        skywardBudapest.coordinate = CLLocationCoordinate2D(latitude: 47.43239502009966, longitude: 19.055754789632893)
        skywardBudapest.title = "Skyward"
        skywardBudapest.subtitle = "Skyward Indoor skydiving Budapest"
        mapView.addAnnotation(skywardBudapest)
        
        // MARK: - FRANCE:

        let weembi = MKPointAnnotation()
        weembi.coordinate = CLLocationCoordinate2D(latitude: 50.584185410592475, longitude: 3.0952959633639017)
        weembi.title = "Weembi"
        weembi.subtitle = "Weembi"
        mapView.addAnnotation(weembi)
        
        // MARK: - BELGIUM:
    
        let airSpaceIndoorSkydiving = MKPointAnnotation()
        airSpaceIndoorSkydiving.coordinate = CLLocationCoordinate2D(latitude: 50.472656203914966, longitude: 4.474358494243173)
        airSpaceIndoorSkydiving.title = "AirSpace Indoor Skydiving"
        airSpaceIndoorSkydiving.subtitle = "AirSpace Indoor Skydiving"
        mapView.addAnnotation(airSpaceIndoorSkydiving)
        
        // MARK: - DENMARK:
        
        let airExperience = MKPointAnnotation()
        airExperience.coordinate = CLLocationCoordinate2D(latitude: 55.66325283190777, longitude: 12.248159402942566)
        airExperience.title = "Air Experience"
        airExperience.subtitle = "Air Experience"
        mapView.addAnnotation(airExperience)
        
        // MARK: - UNITED KINGDOM:
        
        let bodyflightBedford = MKPointAnnotation()
        bodyflightBedford.coordinate = CLLocationCoordinate2D(latitude: 52.196034555670515, longitude: -0.4916001569759647)
        bodyflightBedford.title = "Bodyflight Bedford"
        bodyflightBedford.subtitle = "Bodyflight Bedford"
        mapView.addAnnotation(bodyflightBedford)
        
        let iFlyMiltonKeynes = MKPointAnnotation()
        iFlyMiltonKeynes.coordinate = CLLocationCoordinate2D(latitude: 52.04226195442022, longitude: -0.7467268510507883)
        iFlyMiltonKeynes.title = "iFLY Milton Keynes"
        iFlyMiltonKeynes.subtitle = "iFLY Milton Keynes"
        mapView.addAnnotation(iFlyMiltonKeynes)
        
        let iflyBasingstoke = MKPointAnnotation()
        iflyBasingstoke.coordinate = CLLocationCoordinate2D(latitude: 51.26427077100447, longitude: -1.1190587055017542)
        iflyBasingstoke.title = "iFLY Basingstoke"
        iflyBasingstoke.subtitle = "iFLY Basingstoke"
        mapView.addAnnotation(iflyBasingstoke)
    }
    
    // MARK: - CONFIGURE SHOPS:
    
    private func configureShopsPoints() {
        // MARK: - LITHUANIA:

        let skyShopLithuania = MKPointAnnotation()
        skyShopLithuania.coordinate = CLLocationCoordinate2D(latitude: 54.67961665060792, longitude: 25.28561112602266)
        skyShopLithuania.title = "Sky-Shop"
        skyShopLithuania.subtitle = "Sky-Shop Skydiving Gear Store Europe"
        mapView.addAnnotation(skyShopLithuania)
        
        // MARK: - USA:

        let skydiveStoreFlorida = MKPointAnnotation()
        skydiveStoreFlorida.coordinate = CLLocationCoordinate2D(latitude: 28.805276, longitude: -82.323445)
        skydiveStoreFlorida.title = "Skydive Store"
        skydiveStoreFlorida.subtitle = "Skydive Store Inc"
        mapView.addAnnotation(skydiveStoreFlorida)
        
        let chutingStarSkydivingGearSuperStore = MKPointAnnotation()
        chutingStarSkydivingGearSuperStore.coordinate = CLLocationCoordinate2D(latitude: 33.979267138740425, longitude: -84.56356367308129)
        chutingStarSkydivingGearSuperStore.title = "ChutingStar Skydiving Gear SuperStore"
        chutingStarSkydivingGearSuperStore.subtitle = "ChutingStar Skydiving Gear SuperStore"
        mapView.addAnnotation(chutingStarSkydivingGearSuperStore)
        
        // MARK: - HUNGARY:
        
        let intrudairHungary = MKPointAnnotation()
        intrudairHungary.coordinate = CLLocationCoordinate2D(latitude: 47.93826421863233, longitude: 21.712176888968195)
        intrudairHungary.title = "Intrudair"
        intrudairHungary.subtitle = "Intrudair Skydive and Base gear"
        mapView.addAnnotation(intrudairHungary)
        
        // MARK: - CZECH:
        
        let marsCzech = MKPointAnnotation()
        marsCzech.coordinate = CLLocationCoordinate2D(latitude: 49.63286892244522, longitude: 16.715628983432094)
        marsCzech.title = "Mars"
        marsCzech.subtitle = "MarS a.s."
        mapView.addAnnotation(marsCzech)
        
        // MARK: - SPAIN:
        
        let skydiveShopSpain = MKPointAnnotation()
        skydiveShopSpain.coordinate = CLLocationCoordinate2D(latitude: 37.296152234826685, longitude: -6.160095204267157)
        skydiveShopSpain.title = "SkydiveShop"
        skydiveShopSpain.subtitle = "SkydiveShop"
        mapView.addAnnotation(skydiveShopSpain)
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
    
    // MARK: SEGMENT CONTROL VALUE CHANGED:

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            vibrationOn.vibrationStandart()
            mapView.removeAnnotations(mapView.annotations)
            configureDropZonesPoints()
        } else if sender.selectedSegmentIndex == 1 {
            vibrationOn.vibrationStandart()
            mapView.removeAnnotations(mapView.annotations)
            configureWindTunnelsPoints()
        } else if sender.selectedSegmentIndex == 2 {
            vibrationOn.vibrationStandart()
            mapView.removeAnnotations(mapView.annotations)
            configureShopsPoints()
        }
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
