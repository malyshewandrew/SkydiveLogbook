import Lottie
import UIKit

// MARK: STRUCT HUMIDITY:

struct HumidityModel {
    let image: UIImage?
    let color: UIColor
    let name: String
    let value: String
}

// MARK: ARRAY UVINDEX VALUES:

private let arrayHumidity = [
    HumidityModel(image: UIImage(systemName: "humidity.fill"), color: #colorLiteral(red: 0.8339261413, green: 0.6968302727, blue: 0.004520809744, alpha: 1), name: NSLocalizedString("Very dry air / humidity", comment: ""), value: "<30 %"),
    HumidityModel(image: UIImage(systemName: "humidity.fill"), color: #colorLiteral(red: 0.5635834336, green: 0.7061006427, blue: 0.005785941612, alpha: 1), name: NSLocalizedString("Dry air / humidity", comment: ""), value: "30-55 %"),
    HumidityModel(image: UIImage(systemName: "humidity.fill"), color: #colorLiteral(red: 0.008190996945, green: 0.7086946964, blue: 0.3351221085, alpha: 1), name: NSLocalizedString("Moderately dry air / humidity", comment: ""), value: "55-70 %"),
    HumidityModel(image: UIImage(systemName: "humidity.fill"), color: #colorLiteral(red: 0.009829076938, green: 0.7325571179, blue: 0.5401486754, alpha: 1), name: NSLocalizedString("Moderately humid air / humidity", comment: ""), value: "70-85 %"),
    HumidityModel(image: UIImage(systemName: "humidity.fill"), color: #colorLiteral(red: 0.02996753901, green: 0.7603672147, blue: 0.7500696778, alpha: 1), name: NSLocalizedString("Very humid air / humidity", comment: ""), value: "+85 %")
]

// MARK: - CLASS:

final class HumidityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let humidityBackgroundLottie = LottieAnimationView(name: "WeatherHumidityBackground")
    private let humidityLogoLottie = LottieAnimationView(name: "WeatherHumidity")
    private let humidityListView = UIView()
    private let tableView = UITableView()
    private let humidityInfoView = UIView()
    private let humidityInfoLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HumidityCell.self, forCellReuseIdentifier: "HumidityCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(humidityBackgroundLottie, humidityLogoLottie, humidityListView, humidityInfoView)
        humidityListView.addSubviews(tableView)
        humidityInfoView.addSubviews(humidityInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: HUMIDITY BACKGROUND LOTTIE:

        humidityBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        humidityBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        humidityBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        humidityBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        humidityBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: HUMIDITY LOGO LOTTIE:

        humidityLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        humidityLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        humidityLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        humidityLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: HUMIDITY VIEW FOR TABLE VIEW:

        humidityListView.translatesAutoresizingMaskIntoConstraints = false
        humidityListView.topAnchor.constraint(equalTo: humidityLogoLottie.bottomAnchor, constant: 5).isActive = true
        humidityListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        humidityListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        humidityListView.bottomAnchor.constraint(equalTo: humidityInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: humidityListView.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: humidityListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: humidityListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: humidityListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: HUMIDITY INFO VIEW:
        
        humidityInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = humidityInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = humidityInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        humidityInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        humidityInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: HUMIDITY INFO LABEL:
        
        humidityInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityInfoLabel.topAnchor.constraint(equalTo: humidityInfoView.topAnchor, constant: 20).isActive = true
        humidityInfoLabel.leadingAnchor.constraint(equalTo: humidityInfoView.leadingAnchor, constant: 10).isActive = true
        humidityInfoLabel.trailingAnchor.constraint(equalTo: humidityInfoView.trailingAnchor, constant: -10).isActive = true
        humidityInfoLabel.bottomAnchor.constraint(equalTo: humidityInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: HUMIDITY BACKGROUND LOTTIE:
        
        humidityBackgroundLottie.play()
        humidityBackgroundLottie.loopMode = .loop
        humidityBackgroundLottie.contentMode = .scaleToFill
        
        // MARK: HUMIDITY LOGO LOTTIE:
        
        humidityLogoLottie.play()
        humidityLogoLottie.loopMode = .loop
        humidityLogoLottie.animationSpeed = 0.7
        
        // MARK: HUMIDITY VIEW FOR TABLE VIEW:

        humidityListView.layer.masksToBounds = true
        humidityListView.layer.cornerRadius = cornerRadius15
        let blurEffect1 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView1 = UIVisualEffectView(effect: blurEffect1)
        blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView1.frame = humidityListView.bounds
        humidityListView.addSubviews(blurEffectView1, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: HUMIDITY INFO VIEW:
        
        humidityInfoView.layer.masksToBounds = true
        humidityInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect2 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView2.frame = humidityInfoView.bounds
        humidityInfoView.addSubviews(blurEffectView2, humidityInfoLabel)
        
        // MARK: HUMIDITY INFO LABEL:
        
        humidityInfoLabel.textColor = .white
        humidityInfoLabel.font = FontManager.medium(size: 14).uiFont
        humidityInfoLabel.numberOfLines = 0
        humidityInfoLabel.adjustsFontSizeToFitWidth = true
        humidityInfoLabel.textAlignment = .center
        humidityInfoLabel.text = NSLocalizedString("Humidity weather message / alert", comment: "")
    }
}

// MARK: - EXTENSION:

extension HumidityVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayHumidity.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HumidityCell", for: indexPath) as? HumidityCell else { return UITableViewCell() }
        let humidity = arrayHumidity[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: humidity.image ?? UIImage(), imageColor: humidity.color, name: humidity.name, value: humidity.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
    }
}
