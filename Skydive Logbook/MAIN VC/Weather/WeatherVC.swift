import CoreLocation
import Lottie
import UIKit
import WeatherKit

final class WeatherVC: UIViewController, CLLocationManagerDelegate {
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
        view.addSubviews(weatherBackgroundLottie, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WEATHER NIGHT BACKGROUND:

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
        
        view.backgroundColor = .colorBackground
        
        // MARK: LOTTIE BACKGROUNDS:

        weatherBackgroundLottie.isHidden = true
        
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
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .blowingDust:
                print("Condition is blowing dust")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .blowingSnow:
                print("Condition is blowing snow")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .breezy:
                print("Condition is breezy")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .clear:
                print("Condition is clear")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .cloudy:
                print("Condition is cloudy")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .drizzle:
                print("Condition is drizzle")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .flurries:
                print("Condition is flurries")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .foggy:
                print("Condition is foggy")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .freezingDrizzle:
                print("Condition is freezing drizzle")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .freezingRain:
                print("Condition is freezing rain")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .frigid:
                print("Condition is frigid")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .hail:
                print("Condition is hail")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .haze:
                print("Condition is haze")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .heavyRain:
                print("Condition is heavy rain")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .heavySnow:
                print("Condition is heavy snow")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .hot:
                print("Condition is hot")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .hurricane:
                print("Condition is hurricane")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .isolatedThunderstorms:
                print("Condition is isolated thunderstorms")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .mostlyClear:
                print("Condition is mostly clear")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .mostlyCloudy:
                print("Condition is mostly cloudy")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .partlyCloudy:
                print("Condition is partly cloudy")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .rain:
                print("Condition is rain")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .scatteredThunderstorms:
                print("Condition is scattered thunderstorms")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .sleet:
                print("Condition is sleet")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .smoky:
                print("Condition is smoky")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .snow:
                print("Condition is snow")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .strongStorms:
                print("Condition is strong storms")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .sunFlurries:
                print("Condition is sun flurries")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .sunShowers:
                print("Condition is sun showers")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .thunderstorms:
                print("Condition is thunderstorms")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .tropicalStorm:
                print("Condition is tropical storm")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .windy:
                print("Condition is windy")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
            case .wintryMix:
                print("Condition is wintry mix")
                weatherBackgroundLottie.isHidden = false
                weatherBackgroundLottie.play()
                weatherBackgroundLottie.loopMode = .loop
                weatherBackgroundLottie.contentMode = .scaleAspectFill
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
    // MARK: - WIND:

    func tapWindOverlayButton() {
//        let alert = UIAlertController(title: NSLocalizedString("Wind weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Wind weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("Temperature weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Temperature weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
        let temperatureVC = TemperatureVC()
        if let sheetController = temperatureVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(temperatureVC, animated: true)
    }
    
    // MARK: - HUMIDITY:

    func tapHumidityOverlayButton() {
//        let alert = UIAlertController(title: NSLocalizedString("Humidity weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Humidity weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("Cloud cover weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Cloud cover weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("Dew point weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Dew point weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("Visibility weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Visibility weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("Precipitation weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Precipitation weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("Pressure weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("Pressure weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
//        let alert = UIAlertController(title: NSLocalizedString("UvIndex weather title / alert", comment: "") + ":",
//                                      message: NSLocalizedString("UvIndex weather message / alert", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//        }))
//        present(alert, animated: true)
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
