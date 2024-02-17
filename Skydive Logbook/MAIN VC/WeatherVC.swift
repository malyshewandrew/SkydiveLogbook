import CoreLocation
import Lottie
import UIKit
import WeatherKit

class WeatherVC: UIViewController, CLLocationManagerDelegate {
    // MARK: - PROPERTIES:
    
    private let weatherBackgroundLottie = LottieAnimationView(name: "WeatherBackground")
    private let locationManager = CLLocationManager()
    private let service = WeatherService()
    private let tableView = UITableView()
    private var iconImage: String = ""
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 60)
    private var weatherDescription: String = ""
    private var currentTemperature: String = ""
    private var feelTemperature: String = ""
    private var cloudCover: String = ""
    private var humidity: String = ""
    private var dewPoint: String = ""
    private var precipitation: String = ""
    private var pressure: String = ""
    private var windSpeed: String = ""
    private var windGust: String = ""
    private var windDirection: String = ""
    private var visibility: String = ""
    private var rotationAngle: Int = 0
    
    // MARK: - LIFECYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        getUserLocation()
        configureTableView()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherBackgroundLottie, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WEATHER BACKGROUND:

        weatherBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.toolbar.backgroundColor = .clear
        
        // MARK: VIEW:
        
        view.backgroundColor = .colorWeather
        
        // MARK: LOTTIE ANIMATION:
        
        // MARK: WEATHER BACKGROUND:
        
        weatherBackgroundLottie.play()
        weatherBackgroundLottie.loopMode = .loop
        weatherBackgroundLottie.animationSpeed = 0.5
        weatherBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: TABLE VIEW:
        
        tableView.backgroundColor = .clear
    }
    
    // MARK: - CONFIGURE TABLE VIEW:
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.separatorStyle = .none
    }
    
    // MARK: - HELPERS:
    
    // MARK: GET USER LOCATION:
    
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // MARK: LOCATION MANAGER:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.stopUpdatingLocation()
        getWeather(location: location)
    }
    
    // MARK: GET WEATHER:
    
    func getWeather(location: CLLocation) {
        Task {
            do {
                let result = try await service.weather(for: location)
                self.iconImage = result.currentWeather.symbolName
                self.weatherDescription = result.currentWeather.condition.description
                self.currentTemperature = "\(Int(result.currentWeather.temperature.value))\(result.currentWeather.temperature.unit.symbol)"
                self.feelTemperature = "\(Int(result.currentWeather.apparentTemperature.value)) \(result.currentWeather.temperature.unit.symbol)"
                self.cloudCover = "\(Int(result.currentWeather.cloudCover * 100)) %"
                self.humidity = "\(Int(result.currentWeather.humidity * 100)) %"
                self.dewPoint = "\(Int(result.currentWeather.dewPoint.value))\(result.currentWeather.temperature.unit.symbol)"
                self.precipitation = "\(result.currentWeather.precipitationIntensity.value) \(NSLocalizedString("mm/h", comment: ""))"
                self.pressure = "\(Int(result.currentWeather.pressure.value)) \(NSLocalizedString("hPa", comment: ""))"
                self.windSpeed = "\(Int(result.currentWeather.wind.speed.value / 3.6)) \(NSLocalizedString("m/s", comment: ""))"
                if let gustValue = result.currentWeather.wind.gust?.value {
                    let gustSpeed = gustValue / 3.6
                    self.windGust = "\(NSLocalizedString("Gusts up to", comment: "")) \(String(Int(gustSpeed))) \(NSLocalizedString("m/s", comment: ""))"
                } else {
                    self.windGust = "\(NSLocalizedString("Gusts up to", comment: "")) \(NSLocalizedString("N/A", comment: ""))"
                }
                self.windDirection = "\(result.currentWeather.wind.compassDirection) (\(result.currentWeather.wind.direction))"
                self.visibility = "\(Int(result.currentWeather.visibility.value / 1000)) \(NSLocalizedString("km", comment: ""))"
                self.tableView.reloadData()
                self.rotationAngle = Int(result.currentWeather.wind.direction.value)
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: EXTENSION:

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.delegate = self
        cell.configure(iconImage: UIImage(systemName: iconImage, withConfiguration: configurationImage) ?? UIImage(), description: weatherDescription, currentTemperature: currentTemperature, feelTemperature: feelTemperature, cloudCover: cloudCover, humidity: humidity, dewPoint: dewPoint, precipitation: precipitation, pressure: pressure, windSpeed: windSpeed, windGust: windGust, windDirection: windDirection, visibility: visibility, rotationAngle: rotationAngle)
        return cell
    }
}

extension WeatherVC: WeatherCellDelegate {
    func tapInfoButton() {
        let alert = UIAlertController(title: NSLocalizedString("Wind direction", comment: ""), message: NSLocalizedString("Arrow wind direction", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
}
