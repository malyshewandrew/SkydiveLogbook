import CoreLocation
import Lottie
import UIKit
import WeatherKit

final class WeatherVC: UIViewController, CLLocationManagerDelegate {
    // MARK: - PROPERTIES:
    
    private let weatherBackgroundDefault = LottieAnimationView(name: "WeatherBackgroundDefault")
    private let weatherBackgroundCloudyLight = LottieAnimationView(name: "WeatherBackgroundCloudyLight")
    private let weatherBackgroundCloudyHard = LottieAnimationView(name: "WeatherBackgroundCloudyHard")
    private let weatherBackgroundRain = LottieAnimationView(name: "WeatherBackgroundRain")
    private let weatherBackgroundSnow = LottieAnimationView(name: "WeatherBackgroundSnow")
    private let weatherBackgroundWind = LottieAnimationView(name: "WeatherBackgroundWind")
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
    private var maxTemperature: String = ""
    private var minTemperature: String = ""
    private var averageTemperature: String = ""
    
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
        view.addSubviews(weatherBackgroundDefault, weatherBackgroundCloudyLight, weatherBackgroundCloudyHard, weatherBackgroundRain, weatherBackgroundSnow, weatherBackgroundWind, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WEATHER BACKGROUND DEFAULT:

        weatherBackgroundDefault.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundDefault.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundDefault.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundDefault.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundDefault.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: WEATHER BACKGROUND CLOUDY LIGHT:

        weatherBackgroundCloudyLight.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundCloudyLight.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundCloudyLight.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundCloudyLight.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundCloudyLight.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: WEATHER BACKGROUND CLOUDY HARD:

        weatherBackgroundCloudyHard.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundCloudyHard.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundCloudyHard.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundCloudyHard.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundCloudyHard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: WEATHER BACKGROUND RAIN:

        weatherBackgroundRain.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundRain.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundRain.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundRain.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundRain.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: WEATHER BACKGROUND SNOW:

        weatherBackgroundSnow.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundSnow.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundSnow.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundSnow.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundSnow.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: WEATHER BACKGROUND WIND:

        weatherBackgroundWind.translatesAutoresizingMaskIntoConstraints = false
        weatherBackgroundWind.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        weatherBackgroundWind.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherBackgroundWind.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherBackgroundWind.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
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
        
        // MARK: WEATHER BACKGROUNDS:

        weatherBackgroundDefault.isHidden = true
        weatherBackgroundCloudyLight.isHidden = true
        weatherBackgroundCloudyHard.isHidden = true
        weatherBackgroundRain.isHidden = true
        weatherBackgroundSnow.isHidden = true
        weatherBackgroundWind.isHidden = true
        
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
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .blowingDust:
                weatherBackgroundWind.isHidden = false
                weatherBackgroundWind.play()
                weatherBackgroundWind.loopMode = .loop
                weatherBackgroundWind.contentMode = .scaleAspectFill
            case .blowingSnow:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .breezy:
                weatherBackgroundWind.isHidden = false
                weatherBackgroundWind.play()
                weatherBackgroundWind.loopMode = .loop
                weatherBackgroundWind.contentMode = .scaleAspectFill
            case .clear:
                weatherBackgroundDefault.isHidden = false
                weatherBackgroundDefault.play()
                weatherBackgroundDefault.loopMode = .loop
                weatherBackgroundDefault.contentMode = .scaleAspectFill
            case .cloudy:
                weatherBackgroundCloudyLight.isHidden = false
                weatherBackgroundCloudyLight.play()
                weatherBackgroundCloudyLight.loopMode = .loop
                weatherBackgroundCloudyLight.contentMode = .scaleAspectFill
            case .drizzle:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .flurries:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .foggy:
                weatherBackgroundDefault.isHidden = false
                weatherBackgroundDefault.play()
                weatherBackgroundDefault.loopMode = .loop
                weatherBackgroundDefault.contentMode = .scaleAspectFill
            case .freezingDrizzle:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .freezingRain:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .frigid:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .hail:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .haze:
                weatherBackgroundDefault.isHidden = false
                weatherBackgroundDefault.play()
                weatherBackgroundDefault.loopMode = .loop
                weatherBackgroundDefault.contentMode = .scaleAspectFill
            case .heavyRain:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .heavySnow:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .hot:
                weatherBackgroundDefault.isHidden = false
                weatherBackgroundDefault.play()
                weatherBackgroundDefault.loopMode = .loop
                weatherBackgroundDefault.contentMode = .scaleAspectFill
            case .hurricane:
                weatherBackgroundWind.isHidden = false
                weatherBackgroundWind.play()
                weatherBackgroundWind.loopMode = .loop
                weatherBackgroundWind.contentMode = .scaleAspectFill
            case .isolatedThunderstorms:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .mostlyClear:
                weatherBackgroundDefault.isHidden = false
                weatherBackgroundDefault.play()
                weatherBackgroundDefault.loopMode = .loop
                weatherBackgroundDefault.contentMode = .scaleAspectFill
            case .mostlyCloudy:
                weatherBackgroundCloudyHard.isHidden = false
                weatherBackgroundCloudyHard.play()
                weatherBackgroundCloudyHard.loopMode = .loop
                weatherBackgroundCloudyHard.contentMode = .scaleAspectFill
            case .partlyCloudy:
                weatherBackgroundCloudyLight.isHidden = false
                weatherBackgroundCloudyLight.play()
                weatherBackgroundCloudyLight.loopMode = .loop
                weatherBackgroundCloudyLight.contentMode = .scaleAspectFill
            case .rain:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .scatteredThunderstorms:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .sleet:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .smoky:
                weatherBackgroundDefault.isHidden = false
                weatherBackgroundDefault.play()
                weatherBackgroundDefault.loopMode = .loop
                weatherBackgroundDefault.contentMode = .scaleAspectFill
            case .snow:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .strongStorms:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .sunFlurries:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
            case .sunShowers:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .thunderstorms:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .tropicalStorm:
                weatherBackgroundRain.isHidden = false
                weatherBackgroundRain.play()
                weatherBackgroundRain.loopMode = .loop
                weatherBackgroundRain.contentMode = .scaleAspectFill
            case .windy:
                weatherBackgroundWind.isHidden = false
                weatherBackgroundWind.play()
                weatherBackgroundWind.loopMode = .loop
                weatherBackgroundWind.contentMode = .scaleAspectFill
            case .wintryMix:
                weatherBackgroundSnow.isHidden = false
                weatherBackgroundSnow.play()
                weatherBackgroundSnow.loopMode = .loop
                weatherBackgroundSnow.contentMode = .scaleAspectFill
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
                self.pressure = "\(Int(result.currentWeather.pressure.value * 0.750063755419211)) \(NSLocalizedString("mm / pressure", comment: ""))"
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
                
                // MARK: TEMPERATURE:
                
                let dailyForecasts = result.dailyForecast
                var maxTemperature = 0
                var minTemperature = 0
                for dailyForecast in dailyForecasts {
                    let lowTemperature = dailyForecast.highTemperature.value
                    let hightTemperature = dailyForecast.highTemperature.value
                maxTemperature = Int(lowTemperature)
                minTemperature = Int(hightTemperature)
                self.maxTemperature = "\(String(Int(maxTemperature))) \(result.currentWeather.temperature.unit.symbol)"
                self.minTemperature = "\(String(Int(minTemperature))) \(result.currentWeather.temperature.unit.symbol)"
                let averageTemperature = (maxTemperature + minTemperature) / 2
                self.averageTemperature = "\(String(Int(averageTemperature))) \(result.currentWeather.temperature.unit.symbol)"
                }
            } catch {
                print(String(describing: error))
            }
        }
    }
}

// MARK: - EXTENSION:

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELL:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // MARK: CUSTOM CELL:

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
    // MARK: - WIND:

    func tapWindOverlayButton() {
        let windVC = WindVC()
        if let sheetController = windVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(windVC, animated: true)
    }
    
    // MARK: - TEMPERATURE:

    func taptemperatureOverlayButton() {
        let temperatureVC = TemperatureVC()
        if let sheetController = temperatureVC.sheetPresentationController {
            temperatureVC.maxTemperature = maxTemperature
            temperatureVC.minTemperature = minTemperature
            temperatureVC.averageTemperature = averageTemperature
            temperatureVC.feelTemperature = feelTemperature
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(temperatureVC, animated: true)
    }
    
    // MARK: - HUMIDITY:

    func tapHumidityOverlayButton() {
        let humidityVC = HumidityVC()
        if let sheetController = humidityVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(humidityVC, animated: true)
    }
    
    // MARK: - CLOUD COVER:

    func tapCloudCoverOverlayButton() {
        let cloudCoverVC = CloudCoverVC()
        if let sheetController = cloudCoverVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(cloudCoverVC, animated: true)
    }
    
    // MARK: - DEW POINT:

    func tapDewPointOverlayButton() {
        let dewPointVC = DewPointVC()
        if let sheetController = dewPointVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(dewPointVC, animated: true)
    }
    
    // MARK: - VISIBILITY:

    func tapVisibilityOverlayButton() {
        let visibilityVC = VisibilityVC()
        if let sheetController = visibilityVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(visibilityVC, animated: true)
    }
    
    // MARK: - PRECIPITATION:

    func tapPrecipitationOverlayButton() {
        let precipitationVC = PrecipitationVC()
        if let sheetController = precipitationVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(precipitationVC, animated: true)
    }
    
    // MARK: - PRESSURE:

    func tapPressureOverlayButton() {
        let pressureVC = PressureVC()
        if let sheetController = pressureVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(pressureVC, animated: true)
    }
    
    // MARK: - UV INDEX:
    
    func tapUvIndexOverlayButton() {
        let uvIndexVC = UvIndexVC()
        if let sheetController = uvIndexVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(uvIndexVC, animated: true)
    }
    
    // MARK: - WIND INFO BUTTON:

    func tapWindInfoButton() {
        let alert = UIAlertController(title: NSLocalizedString("Wind direction", comment: ""), message: NSLocalizedString("Arrow wind direction", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }
}
