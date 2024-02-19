import CoreLocation
import Lottie
import UIKit
import WeatherKit

class WeatherVC: UIViewController, CLLocationManagerDelegate {
    // MARK: - PROPERTIES:
    
    private let weatherNightBackgroundLottie = LottieAnimationView(name: "WeatherNightBackground")
    private let weatherDayBackgroundLottie = LottieAnimationView(name: "WeatherDayBackground")
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
    private var uvIndex: String = ""
    private var windSpeed: String = ""
    private var windGust: String = ""
    private var windDirection: String = ""
    private var visibility: String = ""
    private var rotationAngle: Int = 0
    
    private var condition: WeatherCondition?
    
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
        view.addSubviews(weatherNightBackgroundLottie, weatherDayBackgroundLottie, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WEATHER NIGHT BACKGROUND:

        weatherNightBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        weatherNightBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherNightBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherNightBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherNightBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: WEATHER DAY BACKGROUND:

        weatherDayBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        weatherDayBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherDayBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherDayBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherDayBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
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
        
        view.backgroundColor = .colorBackground
        
        // MARK: LOTTIE BACKGROUNDS:
        
        weatherDayBackgroundLottie.isHidden = true
        weatherNightBackgroundLottie.isHidden = true
        
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
    
    // MARK: - CONFIGURE BACKGROUND:
    
    private func configureBackground() {
        if let condition = condition {
            switch condition {
            case .blizzard:
                print("Condition is blizzard")
            case .blowingDust:
                print("Condition is blowing dust")
            case .blowingSnow:
                print("Condition is blowing snow")
            case .breezy:
                print("Condition is breezy")
            case .clear:
                print("Condition is clear")
            case .cloudy:
                print("Condition is cloudy")
//                weatherNightBackgroundLottie.isHidden = false
//                weatherNightBackgroundLottie.play()
//                weatherNightBackgroundLottie.loopMode = .loop
            case .drizzle:
                print("Condition is drizzle")
            case .flurries:
                print("Condition is flurries")
            case .foggy:
                print("Condition is foggy")
            case .freezingDrizzle:
                print("Condition is freezing drizzle")
            case .freezingRain:
                print("Condition is freezing rain")
            case .frigid:
                print("Condition is frigid")
            case .hail:
                print("Condition is hail")
            case .haze:
                print("Condition is haze")
            case .heavyRain:
                print("Condition is heavy rain")
            case .heavySnow:
                print("Condition is heavy snow")
            case .hot:
                print("Condition is hot")
            case .hurricane:
                print("Condition is hurricane")
            case .isolatedThunderstorms:
                print("Condition is isolated thunderstorms")
            case .mostlyClear:
                print("Condition is mostly clear")
            case .mostlyCloudy:
                print("Condition is mostly cloudy")
            case .partlyCloudy:
                print("Condition is partly cloudy")
            case .rain:
                print("Condition is rain")
            case .scatteredThunderstorms:
                print("Condition is scattered thunderstorms")
            case .sleet:
                print("Condition is sleet")
            case .smoky:
                print("Condition is smoky")
            case .snow:
                print("Condition is snow")
            case .strongStorms:
                print("Condition is strong storms")
            case .sunFlurries:
                print("Condition is sun flurries")
            case .sunShowers:
                print("Condition is sun showers")
            case .thunderstorms:
                print("Condition is thunderstorms")
            case .tropicalStorm:
                print("Condition is tropical storm")
            case .windy:
                print("Condition is windy")
            case .wintryMix:
                print("Condition is wintry mix")
            @unknown default:
                print("Unknown condition")
                view.backgroundColor = .colorBackground
            }
        } else {
            view.backgroundColor = .colorBackground
        }
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
                self.uvIndex = "\(result.currentWeather.uvIndex.category): \(result.currentWeather.uvIndex.value)"
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
                self.condition = result.currentWeather.condition
                configureBackground()
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
        cell.configure(iconImage: UIImage(systemName: iconImage, withConfiguration: configurationImage) ?? UIImage(), description: weatherDescription, currentTemperature: currentTemperature, feelTemperature: feelTemperature, cloudCover: cloudCover, humidity: humidity, dewPoint: dewPoint, precipitation: precipitation, pressure: pressure, uvIndex: uvIndex, windSpeed: windSpeed, windGust: windGust, windDirection: windDirection, visibility: visibility, rotationAngle: rotationAngle)
        return cell
    }
}

// MARK: - EXTENSION:

extension WeatherVC: WeatherCellDelegate {
    func tapWindOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Wind weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Wind weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func taptemperatureOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Temperature weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Temperature weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapCloudCoverOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Cloud cover weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Cloud cover weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapHumidityOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Humidity weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Humidity weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapDewPointOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Dew point weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Dew point weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapPrecipitationOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Precipitation weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Precipitation weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapPressureOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Pressure weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Pressure weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapUvIndexOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("UvIndex weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("UvIndex weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapVisibilityOverlayButton() {
        let alert = UIAlertController(title: NSLocalizedString("Visibility weather title / alert", comment: "") + ":",
                                      message: NSLocalizedString("Visibility weather message / alert", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
    
    func tapWindInfoButton() {
        let alert = UIAlertController(title: NSLocalizedString("Wind direction", comment: ""), message: NSLocalizedString("Arrow wind direction", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
}
