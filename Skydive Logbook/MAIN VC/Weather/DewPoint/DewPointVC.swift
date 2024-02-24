import Lottie
import UIKit

// MARK: DEW POINT MODEL:

struct DewPointModel {
    let image: UIImage?
    let name: String
    let value: String
}

// MARK: ARRAY CLOUD COVER VALUES:

private let arrayDewPoint = [
    DewPointModel(image: UIImage(systemName: "thermometer.low"), name: NSLocalizedString("Relatively dry air / dew point", comment: ""), value: "<10°C"),
    DewPointModel(image: UIImage(systemName: "thermometer.medium"), name: NSLocalizedString("Moderately humid air / dew point", comment: ""), value: "10-15°C"),
    DewPointModel(image: UIImage(systemName: "thermometer.high"), name: NSLocalizedString("Humid air / dew point", comment: ""), value: "15-20°C"),
    DewPointModel(image: UIImage(systemName: "thermometer.sun.fill"), name: NSLocalizedString("Very humid air / dew point", comment: ""), value: ">20°C")
]

// MARK: - CLASS:

final class DewPointVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let dewPointBackgroundLottie = LottieAnimationView(name: "WeatherDewPointBackground")
    private let dewPointLogoLottie = LottieAnimationView(name: "WeatherDewPoint")
    private let dewPointListView = UIView()
    private let tableView = UITableView()
    private let dewPointInfoView = UIView()
    private let dewPointInfoLabel = UILabel()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DewPointCell.self, forCellReuseIdentifier: "DewPointCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(dewPointBackgroundLottie, dewPointLogoLottie, dewPointListView, dewPointInfoView)
        dewPointListView.addSubviews(tableView)
        dewPointInfoView.addSubviews(dewPointInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: DEW POINT BACKGROUND:

        dewPointBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        dewPointBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        dewPointBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dewPointBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dewPointBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: DEW POINT LOGO:

        dewPointLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        dewPointLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        dewPointLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dewPointLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: DEW POINT VIEW FOR TABLE VIEW:

        dewPointListView.translatesAutoresizingMaskIntoConstraints = false
        dewPointListView.topAnchor.constraint(equalTo: dewPointLogoLottie.bottomAnchor, constant: 5).isActive = true
        dewPointListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dewPointListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        dewPointListView.bottomAnchor.constraint(equalTo: dewPointInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: dewPointListView.topAnchor, constant: 15).isActive = true
        tableView.centerXAnchor.constraint(equalTo: dewPointListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: dewPointListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: dewPointListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: DEW POINT VIEW:
        
        dewPointInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = dewPointInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = dewPointInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        dewPointInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dewPointInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: DEW POINT LABEL:
        
        dewPointInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointInfoLabel.topAnchor.constraint(equalTo: dewPointInfoView.topAnchor, constant: 20).isActive = true
        dewPointInfoLabel.leadingAnchor.constraint(equalTo: dewPointInfoView.leadingAnchor, constant: 10).isActive = true
        dewPointInfoLabel.trailingAnchor.constraint(equalTo: dewPointInfoView.trailingAnchor, constant: -10).isActive = true
        dewPointInfoLabel.bottomAnchor.constraint(equalTo: dewPointInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: DEW POINT BACKGROUND:
        
        dewPointBackgroundLottie.play()
        dewPointBackgroundLottie.loopMode = .loop
        dewPointBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: DEW POINT LOGO:
        
        dewPointLogoLottie.play()
        dewPointLogoLottie.loopMode = .loop
        dewPointLogoLottie.animationSpeed = 0.7
        
        // MARK: DEW POINT VIEW FOR TABLE VIEW:

        dewPointListView.layer.masksToBounds = true
        dewPointListView.layer.cornerRadius = cornerRadius15
        let blurEffect1 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView1 = UIVisualEffectView(effect: blurEffect1)
        blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView1.frame = dewPointListView.bounds
        dewPointListView.addSubviews(blurEffectView1, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: DEW POINT VIEW:

        dewPointInfoView.layer.masksToBounds = true
        dewPointInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect2 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView2.frame = dewPointInfoView.bounds
        dewPointInfoView.addSubviews(blurEffectView2, dewPointInfoLabel)
        
        // MARK: DEW POINT LABEL:
        
        dewPointInfoLabel.textColor = .white
        dewPointInfoLabel.font = fontMediumStandard14
        dewPointInfoLabel.numberOfLines = 0
        dewPointInfoLabel.adjustsFontSizeToFitWidth = true
        dewPointInfoLabel.textAlignment = .center
        dewPointInfoLabel.text = NSLocalizedString("Dew point weather message / alert", comment: "")
    }
    // MARK: - HELPERS:
}
// MARK: - EXTENSION:

extension DewPointVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayDewPoint.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DewPointCell", for: indexPath) as? DewPointCell else { return UITableViewCell() }
        let dewPoint = arrayDewPoint[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: dewPoint.image ?? UIImage(), name: dewPoint.name, value: dewPoint.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrationOn.vibrationStandart()
    }
}
