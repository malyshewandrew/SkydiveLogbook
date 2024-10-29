import Lottie
import UIKit

// MARK: - STRUCT TEMPERATURE:

struct TemperatureValue {
    let image: UIImage?
    let color: UIColor
    let nameTemperature: String
    let valueTemperature: String
}

// MARK: - CLASS:

final class TemperatureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let temperatureBackgroundLottie = LottieAnimationView(name: "WeatherTemperatureBackground")
    private let temperatureLogoLottie = LottieAnimationView(name: "WeatherTemperature")
    private let temperatureListView = UIView()
    private let tableView = UITableView()
    private let temperatureInfoView = UIView()
    private let temperatureInfoLabel = UILabel()
    var maxTemperature: String = ""
    var minTemperature: String = ""
    var averageTemperature: String = ""
    var feelTemperature: String = ""
    
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
        view.addSubviews(temperatureBackgroundLottie, temperatureLogoLottie, temperatureListView, temperatureInfoView)
        temperatureListView.addSubviews(tableView)
        temperatureInfoView.addSubviews(temperatureInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: TEMPERATURE BACKGROUND:

        temperatureBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        temperatureBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        temperatureBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temperatureBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temperatureBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: TEMPERATURE LOGO:

        temperatureLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        temperatureLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        temperatureLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: TEMP VIEW:

        temperatureListView.translatesAutoresizingMaskIntoConstraints = false
        temperatureListView.topAnchor.constraint(equalTo: temperatureLogoLottie.bottomAnchor, constant: 5).isActive = true
        temperatureListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        temperatureListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        temperatureListView.bottomAnchor.constraint(equalTo: temperatureInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: temperatureListView.topAnchor, constant: 15).isActive = true
        tableView.centerXAnchor.constraint(equalTo: temperatureListView.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: temperatureListView.heightAnchor, multiplier: 1).isActive = true
        tableView.widthAnchor.constraint(equalTo: temperatureListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: TEMPERATURE VIEW:

        temperatureInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = temperatureInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = temperatureInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        temperatureInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        temperatureInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        // MARK: TEMPERATURE LABEL:
        
        temperatureInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureInfoLabel.topAnchor.constraint(equalTo: temperatureInfoView.topAnchor, constant: 20).isActive = true
        temperatureInfoLabel.leadingAnchor.constraint(equalTo: temperatureInfoView.leadingAnchor, constant: 10).isActive = true
        temperatureInfoLabel.trailingAnchor.constraint(equalTo: temperatureInfoView.trailingAnchor, constant: -10).isActive = true
        temperatureInfoLabel.bottomAnchor.constraint(equalTo: temperatureInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: TEMPERATURE BACKGROUND:
        
        temperatureBackgroundLottie.play()
        temperatureBackgroundLottie.loopMode = .loop
        temperatureBackgroundLottie.contentMode = .scaleToFill
        
        // MARK: TEMPERATURE:
        
        temperatureLogoLottie.play()
        temperatureLogoLottie.loopMode = .loop
        temperatureLogoLottie.animationSpeed = 0.7
        
        // MARK: TEMP VIEW:

        temperatureListView.layer.masksToBounds = true
        temperatureListView.layer.cornerRadius = cornerRadius15
        let blurEffectTempView = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectViewTempView = UIVisualEffectView(effect: blurEffectTempView)
        blurEffectViewTempView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectViewTempView.frame = temperatureListView.bounds
        temperatureListView.addSubviews(blurEffectViewTempView, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: TEMPERATURE VIEW:

        temperatureInfoView.layer.masksToBounds = true
        temperatureInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = temperatureInfoView.bounds
        temperatureInfoView.addSubviews(blurEffectView, temperatureInfoLabel)
        
        // MARK: TEMPERATURE LABEL:
        
        temperatureInfoLabel.textColor = .white
        temperatureInfoLabel.font = FontManager.medium(size: 14).uiFont
        temperatureInfoLabel.numberOfLines = 0
        temperatureInfoLabel.adjustsFontSizeToFitWidth = true
        temperatureInfoLabel.textAlignment = .center
        temperatureInfoLabel.text = NSLocalizedString("Temperature weather message / alert", comment: "")
    }
    
    // MARK: - HELPERS:
    
    // MARK: CREATE ARRAY WITH TEMPERATURES:

    func createTemperatureArray() -> [TemperatureValue] {
        let arrayTemperature: [TemperatureValue] = [
            TemperatureValue(image: UIImage(systemName: "thermometer.sun"), color: #colorLiteral(red: 0.9038113952, green: 0.1745244861, blue: 0.1827548146, alpha: 1), nameTemperature: NSLocalizedString("Max temperature / temperature", comment: ""), valueTemperature: maxTemperature),
            TemperatureValue(image: UIImage(systemName: "thermometer.snowflake"), color: #colorLiteral(red: 0.1246755049, green: 0.7242954373, blue: 0.8247141242, alpha: 1), nameTemperature: NSLocalizedString("Min temperature / temperature", comment: ""), valueTemperature: minTemperature),
            TemperatureValue(image: UIImage(systemName: "thermometer.medium"), color: #colorLiteral(red: 0.1420840621, green: 0.7043048739, blue: 0.1435457766, alpha: 1), nameTemperature: NSLocalizedString("Average temperature / temperature", comment: ""), valueTemperature: averageTemperature),
            TemperatureValue(image: UIImage(systemName: "thermometer.high"), color: #colorLiteral(red: 0.009829076938, green: 0.7325571179, blue: 0.5401486754, alpha: 1), nameTemperature: NSLocalizedString("Feels like temperature / temperature", comment: ""), valueTemperature: feelTemperature),
        ]
        return arrayTemperature
    }
}

// MARK: - EXTENSION:

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
        cell.configure(image: temperature.image ?? UIImage(), imageColor: temperature.color, name: temperature.nameTemperature, value: temperature.valueTemperature)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
    }
}
