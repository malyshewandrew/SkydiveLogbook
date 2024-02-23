import Lottie
import UIKit

struct TemperatureValue {
    let image: UIImage?
    let nameTemperature: String
    let valueTemperature: String
}

final class TemperatureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherTemperature = LottieAnimationView(name: "WeatherTemperature")
    private let weatherTemperatureBackground = LottieAnimationView(name: "WeatherTemperatureBackground")
    private let temperatureView = UIView()
    private let temperatureLabel = UILabel()
    private let tempView = UIView()
    private let tableView = UITableView()
    var maxTemperature: String = ""
    var minTemperature: String = ""
    var averageTemperature: String = ""
    var feelTemperature: String = ""
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TemperatureCell.self, forCellReuseIdentifier: "TemperatureCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(weatherTemperatureBackground, weatherTemperature, tempView, temperatureView)
        tempView.addSubviews(tableView)
        temperatureView.addSubviews(temperatureLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: TEMPERATURE BACKGROUND:

        weatherTemperatureBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherTemperatureBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherTemperatureBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherTemperatureBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherTemperatureBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: TEMPERATURE:

        weatherTemperature.translatesAutoresizingMaskIntoConstraints = false
        weatherTemperature.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherTemperature.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: TEMP VIEW:

        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.topAnchor.constraint(equalTo: weatherTemperature.bottomAnchor, constant: 5).isActive = true
        tempView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tempView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tempView.bottomAnchor.constraint(equalTo: temperatureView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: tempView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        
        // MARK: TEMPERATURE VIEW:

        temperatureView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = temperatureView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = temperatureView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        temperatureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        temperatureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        // MARK: TEMPERATURE LABEL:
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.topAnchor.constraint(equalTo: temperatureView.topAnchor, constant: 20).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: temperatureView.leadingAnchor, constant: 10).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: temperatureView.trailingAnchor, constant: -10).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo: temperatureView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: TEMPERATURE BACKGROUND:
        
        weatherTemperatureBackground.play()
        weatherTemperatureBackground.loopMode = .loop
        weatherTemperatureBackground.contentMode = .scaleToFill
        
        // MARK: TEMPERATURE:
        
        weatherTemperature.play()
        weatherTemperature.loopMode = .loop
        weatherTemperature.animationSpeed = 0.7
        
        // MARK: TEMP VIEW:

        tempView.layer.masksToBounds = true
        tempView.layer.cornerRadius = cornerRadius15
        let blurEffectTempView = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectViewTempView = UIVisualEffectView(effect: blurEffectTempView)
        blurEffectViewTempView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectViewTempView.frame = tempView.bounds
        tempView.addSubviews(blurEffectViewTempView, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: TEMPERATURE VIEW:

        temperatureView.layer.masksToBounds = true
        temperatureView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = temperatureView.bounds
        temperatureView.addSubviews(blurEffectView, temperatureLabel)
        
        // MARK: TEMPERATURE LABEL:
        
        temperatureLabel.textColor = .white
        temperatureLabel.font = fontMediumStandard14
        temperatureLabel.numberOfLines = 0
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textAlignment = .center
        temperatureLabel.text = NSLocalizedString("Temperature weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: CREATE ARRAY WITH TEMPERATURES:

    func createTemperatureArray() -> [TemperatureValue] {
        let arrayTemperature: [TemperatureValue] = [
            TemperatureValue(image: UIImage(systemName: "thermometer.sun"), nameTemperature: NSLocalizedString("Max temperature / temperature", comment: ""), valueTemperature: maxTemperature),
            TemperatureValue(image: UIImage(systemName: "thermometer.snowflake"), nameTemperature: NSLocalizedString("Min temperature / temperature", comment: ""), valueTemperature: minTemperature),
            TemperatureValue(image: UIImage(systemName: "thermometer.medium"), nameTemperature: NSLocalizedString("Average temperature / temperature", comment: ""), valueTemperature: averageTemperature),
            TemperatureValue(image: UIImage(systemName: "thermometer.high"), nameTemperature: NSLocalizedString("Feels like temperature / temperature", comment: ""), valueTemperature: feelTemperature),
        ]
        return arrayTemperature
    }
}

// MARK: EXTENSION:

extension TemperatureVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        createTemperatureArray().count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureCell", for: indexPath) as? TemperatureCell else { return UITableViewCell() }
        let temperature = createTemperatureArray()[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: temperature.image ?? UIImage(), name: temperature.nameTemperature, value: temperature.valueTemperature)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
