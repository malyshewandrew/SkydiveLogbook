import MapKit
import SafariServices
import UIKit
import WebKit

class DropZonesVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let mapView = MKMapView()
    private let infoButton = UIButton()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        configurePoints()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(mapView)
        mapView.addSubviews(infoButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: MAP VIEW:

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: INFO VIEW:

        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -15).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: INFO VIEW:

        let configurator = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        let image = UIImage(systemName: "info.circle.fill", withConfiguration: configurator)
        infoButton.setImage(image, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE DROP ZONES:
    
    private func configurePoints() {
        let lipki = MKPointAnnotation()
        lipki.coordinate = CLLocationCoordinate2D(latitude: 53.909962, longitude: 27.703807)
        lipki.title = "Lipki"
        lipki.subtitle = "Skydive Minsk"
        mapView.addAnnotation(lipki)

        let skydiveDubai = MKPointAnnotation()
        skydiveDubai.coordinate = CLLocationCoordinate2D(latitude: 25.091480, longitude: 55.135047)
        skydiveDubai.title = "Skydive Dubai"
        skydiveDubai.subtitle = "Palm"
        mapView.addAnnotation(skydiveDubai)
    }
    
    // MARK: - HELPERS:
    
    // MARK: INFO BUTTON:
    
    @objc private func infoButtonTapped() {
        vibrationOn.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("Drop Zones / drop zones", comment: ""), message: NSLocalizedString("Message / drop zones", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Write / drop zone", comment: ""), style: .default, handler: { _ in
            guard let url = URL(string: "https://instagram.com/skydivelogbook") else { return }
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.delegate = self
            self.present(safariViewController, animated: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: { _ in
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
