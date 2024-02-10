import CoreLocation
import UIKit
import WeatherKit

class WeatherVC: UIViewController, CLLocationManagerDelegate {
    // MARK: - PROPERTES:

    let locationManager = CLLocationManager()
    let service = WeatherService()

    private let iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .medium)
        return label
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        getUserLocation()
        setUpView()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(iconView, titleLabel, tempLabel)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        iconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        iconView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

        titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tempLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false

        // MARK: VIEW:

        view.backgroundColor = .colorBackground
    }

    // MARK: - HELPERS:

    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func getWeather(location: CLLocation) {
        Task {
            do {
                let result = try await service.weather(for: location)
                print("Current: " + String(describing: result.currentWeather))
                print("Daily: " + String(describing: result.dailyForecast))
                print("Minutely: " + String(describing: result.minuteForecast))
                self.iconView.image = UIImage(systemName: result.currentWeather.symbolName)
                self.tempLabel.text = """
                \(result.currentWeather.temperature.value) \(result.currentWeather.temperature.unit.symbol)
                \(result.currentWeather.apparentTemperature)
                \(result.currentWeather.cloudCover)
                \(result.currentWeather.condition)
                \(result.currentWeather.dewPoint)
                \(result.currentWeather.humidity)
                \(result.currentWeather.isDaylight)
                
                \(result.currentWeather.precipitationIntensity)
                \(result.currentWeather.pressure)
                \(result.currentWeather.pressureTrend)
                \(result.currentWeather.temperature)
                \(result.currentWeather.metadata)
                
                \(result.currentWeather.wind)
                \(result.currentWeather.date)
                \(result.currentWeather.visibility)
                \(result.currentWeather.uvIndex)
                \(result.currentWeather.temperature.unit.symbol)
                """
                self.titleLabel.text = ""
            } catch {
                print(String(describing: error))
            }
        }
    }

    func setUpView() {}

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        getWeather(location: location)
    }
}
