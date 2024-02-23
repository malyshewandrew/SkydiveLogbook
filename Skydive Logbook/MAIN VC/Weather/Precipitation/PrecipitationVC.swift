import Lottie
import UIKit

// MARK: PRECIPITATION MODEL:

struct PrecipitationModel {
    let image: UIImage?
    let name: String
    let value: String
}

// MARK: ARRAY PRECIPITATION VALUES:

private let arrayPrecipitation = [
    PrecipitationModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 1", value: "Значение 1"),
    PrecipitationModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 2", value: "Значение 2"),
    PrecipitationModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 3", value: "Значение 3"),
    PrecipitationModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 4", value: "Значение 4"),
    PrecipitationModel(image: UIImage(systemName: "humidity.fill"), name: "Имя 5", value: "Значение 5")
]

// MARK: - CLASS:

final class PrecipitationVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let precipitationBackgroundLottie = LottieAnimationView(name: "WeatherPrecipitationBackground")
    private let precipitationLogoLottie = LottieAnimationView(name: "WeatherPrecipitation")
    private let precipitationListView = UIView()
    private let tableView = UITableView()
    private let precipitationInfoView = UIView()
    private let precipitationInfoLabel = UILabel()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PrecipitationCell.self, forCellReuseIdentifier: "PrecipitationCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(precipitationBackgroundLottie, precipitationLogoLottie, precipitationListView, precipitationInfoView)
        precipitationListView.addSubviews(tableView)
        precipitationInfoView.addSubviews(precipitationInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: PRECIPITATION BACKGROUND:

        precipitationBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        precipitationBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        precipitationBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        precipitationBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        precipitationBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: PRECIPITATION LOGO:

        precipitationLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        precipitationLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        precipitationLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        precipitationLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: VISIBILITY VIEW FOR TABLE VIEW:

        precipitationListView.translatesAutoresizingMaskIntoConstraints = false
        precipitationListView.topAnchor.constraint(equalTo: precipitationLogoLottie.bottomAnchor, constant: 5).isActive = true
        precipitationListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        precipitationListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        precipitationListView.bottomAnchor.constraint(equalTo: precipitationInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: precipitationListView.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: precipitationListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: precipitationListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: precipitationListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: PRECIPITATION VIEW:
        
        precipitationInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = precipitationInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = precipitationInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        precipitationInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        precipitationInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: PRECIPITATION LABEL:
        
        precipitationInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationInfoLabel.topAnchor.constraint(equalTo: precipitationInfoView.topAnchor, constant: 20).isActive = true
        precipitationInfoLabel.leadingAnchor.constraint(equalTo: precipitationInfoView.leadingAnchor, constant: 10).isActive = true
        precipitationInfoLabel.trailingAnchor.constraint(equalTo: precipitationInfoView.trailingAnchor, constant: -10).isActive = true
        precipitationInfoLabel.bottomAnchor.constraint(equalTo: precipitationInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: PRECIPITATION BACKGROUND:
        
        precipitationBackgroundLottie.play()
        precipitationBackgroundLottie.loopMode = .loop
        precipitationBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: PRECIPITATION LOGO:
        
        precipitationLogoLottie.play()
        precipitationLogoLottie.loopMode = .autoReverse
        precipitationLogoLottie.animationSpeed = 0.7
        
        // MARK: PRECIPITATION FOR TABLE VIEW:

        precipitationListView.layer.masksToBounds = true
        precipitationListView.layer.cornerRadius = cornerRadius15
        let blurEffect1 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView1 = UIVisualEffectView(effect: blurEffect1)
        blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView1.frame = precipitationListView.bounds
        precipitationListView.addSubviews(blurEffectView1, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: PRECIPITATION VIEW:

        precipitationInfoView.layer.masksToBounds = true
        precipitationInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect2 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView2.frame = precipitationInfoView.bounds
        precipitationInfoView.addSubviews(blurEffectView2, precipitationInfoLabel)
        
        // MARK: PRECIPITATION LABEL:
        
        precipitationInfoLabel.textColor = .white
        precipitationInfoLabel.font = fontMediumStandard14
        precipitationInfoLabel.numberOfLines = 0
        precipitationInfoLabel.adjustsFontSizeToFitWidth = true
        precipitationInfoLabel.textAlignment = .center
        precipitationInfoLabel.text = NSLocalizedString("Precipitation weather message / alert", comment: "")
    }
    // MARK: - HELPERS:
}
// MARK: - EXTENSION:

extension PrecipitationVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayPrecipitation.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PrecipitationCell", for: indexPath) as? PrecipitationCell else { return UITableViewCell() }
        let precipitation = arrayPrecipitation[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: precipitation.image ?? UIImage(), name: precipitation.name, value: precipitation.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
