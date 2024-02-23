import Lottie
import UIKit

// MARK: VISIBILITY MODEL:

struct VisibilityModel {
    let image: UIImage?
    let name: String
    let value: String
}

// MARK: ARRAY VISIBILITY VALUES:

private let arrayVisibility = [
    VisibilityModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 1", value: "Значение 1"),
    VisibilityModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 2", value: "Значение 2"),
    VisibilityModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 3", value: "Значение 3"),
    VisibilityModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 4", value: "Значение 4"),
    VisibilityModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 5", value: "Значение 5")
]

// MARK: - CLASS:

final class VisibilityVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let visibilityBackgroundLottie = LottieAnimationView(name: "WeatherVisibilityBackground")
    private let visibilityLogoLottie = LottieAnimationView(name: "WeatherVisibility")
    private let visibilityListView = UIView()
    private let tableView = UITableView()
    private let visibilityInfoView = UIView()
    private let visibilityInfoLabel = UILabel()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VisibilityCell.self, forCellReuseIdentifier: "VisibilityCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(visibilityBackgroundLottie, visibilityLogoLottie, visibilityListView, visibilityInfoView)
        visibilityListView.addSubviews(tableView)
        visibilityInfoView.addSubviews(visibilityInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: VISIBILITY BACKGROUND:

        visibilityBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        visibilityBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        visibilityBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visibilityBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visibilityBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: VISIBILITY LOGO:

        visibilityLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        visibilityLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        visibilityLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        visibilityLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: VISIBILITY VIEW FOR TABLE VIEW:

        visibilityListView.translatesAutoresizingMaskIntoConstraints = false
        visibilityListView.topAnchor.constraint(equalTo: visibilityLogoLottie.bottomAnchor, constant: 5).isActive = true
        visibilityListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visibilityListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        visibilityListView.bottomAnchor.constraint(equalTo: visibilityInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: visibilityListView.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: visibilityListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: visibilityListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: visibilityListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: VISIBILITY VIEW:

        visibilityInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = visibilityInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = visibilityInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        visibilityInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        visibilityInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: VISIBILITY LABEL:
        
        visibilityInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityInfoLabel.topAnchor.constraint(equalTo: visibilityInfoView.topAnchor, constant: 20).isActive = true
        visibilityInfoLabel.leadingAnchor.constraint(equalTo: visibilityInfoView.leadingAnchor, constant: 10).isActive = true
        visibilityInfoLabel.trailingAnchor.constraint(equalTo: visibilityInfoView.trailingAnchor, constant: -10).isActive = true
        visibilityInfoLabel.bottomAnchor.constraint(equalTo: visibilityInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: VISIBILITY BACKGROUND:
        
        visibilityBackgroundLottie.play()
        visibilityBackgroundLottie.loopMode = .loop
        visibilityBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: VISIBILITY LOGO:
        
        visibilityLogoLottie.play()
        visibilityLogoLottie.loopMode = .loop
        visibilityLogoLottie.animationSpeed = 0.7
        
        // MARK: VISIBILITY VIEW FOR TABLE VIEW:

        visibilityListView.layer.masksToBounds = true
        visibilityListView.layer.cornerRadius = cornerRadius15
        let blurEffect1 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView1 = UIVisualEffectView(effect: blurEffect1)
        blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView1.frame = visibilityListView.bounds
        visibilityListView.addSubviews(blurEffectView1, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: VISIBILITY VIEW:

        visibilityInfoView.layer.masksToBounds = true
        visibilityInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect2 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView2.frame = visibilityInfoView.bounds
        visibilityInfoView.addSubviews(blurEffectView2, visibilityInfoLabel)
        
        // MARK: VISIBILITY LABEL:
        
        visibilityInfoLabel.textColor = .white
        visibilityInfoLabel.font = fontMediumStandard14
        visibilityInfoLabel.numberOfLines = 0
        visibilityInfoLabel.adjustsFontSizeToFitWidth = true
        visibilityInfoLabel.textAlignment = .center
        visibilityInfoLabel.text = NSLocalizedString("Visibility weather message / alert", comment: "")
    }
    // MARK: - HELPERS:
}
// MARK: - EXTENSION:

extension VisibilityVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayVisibility.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisibilityCell", for: indexPath) as? VisibilityCell else { return UITableViewCell() }
        let visibility = arrayVisibility[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: visibility.image ?? UIImage(), name: visibility.name, value: visibility.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
