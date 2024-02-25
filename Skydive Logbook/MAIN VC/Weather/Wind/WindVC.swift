import Lottie
import UIKit

// MARK: STRUCT WIND SPEEDS:

struct WindSpeed {
    let image: UIImage?
    let name: String
    let value: String
    let color: UIColor
}

// MARK: ARRAY WIND SPEEDS:

private let arrayWindSpeed = [
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Calm wind / wind speed", comment: ""), value: "0-1 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.1246755049, green: 0.7242954373, blue: 0.8247141242, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Weak wind / wind speed", comment: ""), value: "1-2 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.02996753901, green: 0.7603672147, blue: 0.7500696778, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Light wind / wind speed", comment: ""), value: "2-3 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.009829076938, green: 0.7325571179, blue: 0.5401486754, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Quiet wind / wind speed", comment: ""), value: "3-5 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.008190996945, green: 0.7086946964, blue: 0.3351221085, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Moderate wind / wind speed", comment: ""), value: "5-8 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.1420840621, green: 0.7043048739, blue: 0.1435457766, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Fresh wind / wind speed", comment: ""), value: "8-11 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.5635834336, green: 0.7061006427, blue: 0.005785941612, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Strong wind / wind speed", comment: ""), value: "11-14 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.8339261413, green: 0.6968302727, blue: 0.004520809744, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Hard wind / wind speed", comment: ""), value: "14-17 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.8648145795, green: 0.6460573077, blue: 0.001722229063, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "wind.circle.fill"), name: NSLocalizedString("Powerful wind / wind speed", comment: ""), value: "17-21 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.8858549595, green: 0.5153784156, blue: 0.0006241258816, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "tornado.circle.fill"), name: NSLocalizedString("Storm wind / wind speed", comment: ""), value: "21-24 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.9018223286, green: 0.3199688196, blue: 0.01046972442, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "tornado.circle.fill"), name: NSLocalizedString("Hard storm wind / wind speed", comment: ""), value: "24-33 " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.9038113952, green: 0.1745244861, blue: 0.1827548146, alpha: 1)),
    WindSpeed(image: UIImage(systemName: "tornado.circle.fill"), name: NSLocalizedString("Hurricane wind / wind speed", comment: ""), value: "33+ " + NSLocalizedString("m/s", comment: ""), color: #colorLiteral(red: 0.9055797458, green: 0.09583576769, blue: 0.3299447, alpha: 1))
]

// MARK: - CLASS:

final class WindVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let windBackgroundLottie = LottieAnimationView(name: "WeatherWindBackground")
    private let windLogoLottie = LottieAnimationView(name: "WeatherWind")
    private let windListView = UIView()
    private let tableView = UITableView()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WindCell.self, forCellReuseIdentifier: "WindCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(windBackgroundLottie, windLogoLottie, windListView, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WIND BACKGROUND:

        windBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        windBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        windBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        windBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        windBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: WIND LOGO:

        windLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        windLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        windLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        windLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: WIND VIEW:

        windListView.translatesAutoresizingMaskIntoConstraints = false
        windListView.topAnchor.constraint(equalTo: windLogoLottie.bottomAnchor, constant: 5).isActive = true
        windListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        windListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        windListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: windListView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: WIND BACKGROUND:
        
        windBackgroundLottie.play()
        windBackgroundLottie.loopMode = .loop
        windBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: WIND:
        
        windLogoLottie.play()
        windLogoLottie.loopMode = .loop
        windLogoLottie.animationSpeed = 0.7
        
        // MARK: WIND VIEW:

        windListView.layer.masksToBounds = true
        windListView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = windListView.bounds
        windListView.addSubviews(blurEffectView, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
    }
}

// MARK: - EXTENSION:

extension WindVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayWindSpeed.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WindCell", for: indexPath) as? WindCell else { return UITableViewCell() }
        let wind = arrayWindSpeed[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: wind.image ?? UIImage(), name: wind.name, value: wind.value, color: wind.color)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
