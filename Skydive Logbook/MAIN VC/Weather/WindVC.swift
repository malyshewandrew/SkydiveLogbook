import Lottie
import UIKit

// MARK: STRUCT WIND SPEEDS:

struct WindSpeed {
    let image: UIImage?
    let name: String
    let value: String
}

// MARK: ARRAY WIND SPEEDS:

var arrayWindSpeed = [
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Calm wind / wind speed", comment: ""), value: "<0.5"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Weak wind / wind speed", comment: ""), value: "0.5-1.5"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Light wind / wind speed", comment: ""), value: "1.6-3.2"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Quiet wind / wind speed", comment: ""), value: "3.3-5.4"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Moderate wind / wind speed", comment: ""), value: "5.5-7.9"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Fresh wind / wind speed", comment: ""), value: "8.0-10.7"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Strong wind / wind speed", comment: ""), value: "10.8-13.8"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Hard wind / wind speed", comment: ""), value: "13.9-17.1"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Powerful wind / wind speed", comment: ""), value: "17.2-20.7"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Storm wind / wind speed", comment: ""), value: "20.8-24.4"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Hard storm wind / wind speed", comment: ""), value: "24.5 - 32.6"),
    WindSpeed(image: UIImage(systemName: "wind"), name: NSLocalizedString("Hurricane wind / wind speed", comment: ""), value: ">32.7")
]

final class WindVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let weatherWind = LottieAnimationView(name: "WeatherWind")
    private let weatherWindBackground = LottieAnimationView(name: "WeatherWindBackground")
    private let windView = UIView()
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
        view.addSubviews(weatherWindBackground, weatherWind, windView, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: WIND BACKGROUND:

        weatherWindBackground.translatesAutoresizingMaskIntoConstraints = false
        weatherWindBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        weatherWindBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherWindBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherWindBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: WIND:

        weatherWind.translatesAutoresizingMaskIntoConstraints = false
        weatherWind.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        weatherWind.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherWind.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: WIND VIEW:

        windView.translatesAutoresizingMaskIntoConstraints = false
        windView.topAnchor.constraint(equalTo: weatherWind.bottomAnchor, constant: 5).isActive = true
        windView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        windView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        windView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: windView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: WIND BACKGROUND:
        
        weatherWindBackground.play()
        weatherWindBackground.loopMode = .loop
        weatherWindBackground.contentMode = .scaleAspectFill
        
        // MARK: WIND:
        
        weatherWind.play()
        weatherWind.loopMode = .loop
        weatherWind.animationSpeed = 0.7
        
        // MARK: WIND VIEW:

        windView.layer.masksToBounds = true
        windView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = windView.bounds
        windView.addSubviews(blurEffectView, tableView)
        
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
        cell.configure(image: wind.image ?? UIImage(), name: wind.name, value: wind.value)
        print("123")
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
