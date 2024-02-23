import Lottie
import UIKit

// MARK: STRUCT WIND SPEEDS:

struct WindSpeed {
    let image: UIImage?
    let name: String
    let value: String
}

// MARK: ARRAY WIND SPEEDS:

private let arrayWindSpeed = [
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
        windLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
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
        cell.configure(image: wind.image ?? UIImage(), name: wind.name, value: wind.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
