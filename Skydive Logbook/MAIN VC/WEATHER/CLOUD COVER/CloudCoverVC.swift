import Lottie
import UIKit

// MARK: CLOUD COVER MODEL:

struct CloudCoverModel {
    let image: UIImage?
    let color: UIColor
    let name: String
    let value: String
}

// MARK: ARRAY CLOUD COVER VALUES:

private let arrayCloudCover = [
    CloudCoverModel(image: UIImage(systemName: "cloud.sun"), color: #colorLiteral(red: 0.02996753901, green: 0.7603672147, blue: 0.7500696778, alpha: 1), name: NSLocalizedString("Clear / cloud cover", comment: ""), value: "<10 %"),
    CloudCoverModel(image: UIImage(systemName: "cloud.sun"), color: #colorLiteral(red: 0.008190996945, green: 0.7086946964, blue: 0.3351221085, alpha: 1), name: NSLocalizedString("Partly Cloudy / cloud cover", comment: ""), value: "10-30 %"),
    CloudCoverModel(image: UIImage(systemName: "cloud.sun"), color: #colorLiteral(red: 0.8648145795, green: 0.6460573077, blue: 0.001722229063, alpha: 1), name: NSLocalizedString("Variable Cloudiness / cloud cover", comment: ""), value: "30-70 %"),
    CloudCoverModel(image: UIImage(systemName: "cloud.sun"), color: #colorLiteral(red: 0.9018223286, green: 0.3199688196, blue: 0.01046972442, alpha: 1), name: NSLocalizedString("Cloudy / cloud cover", comment: ""), value: "70-99 %"),
    CloudCoverModel(image: UIImage(systemName: "cloud.sun"), color: #colorLiteral(red: 0.9055797458, green: 0.09583576769, blue: 0.3299447, alpha: 1), name: NSLocalizedString("Overcast / cloud cover", comment: ""), value: "100 %")
]

// MARK: - CLASS:

final class CloudCoverVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let cloudCoverBackground = LottieAnimationView(name: "WeatherCloudCoverBackground")
    private let cloudCoverLogo = LottieAnimationView(name: "WeatherCloudCover")
    private let cloudCoverListView = UIView()
    private let tableView = UITableView()
    private let cloudCoverInfoView = UIView()
    private let cloudCoverInfoLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CloudCoverCell.self, forCellReuseIdentifier: "CloudCoverCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(cloudCoverBackground, cloudCoverLogo, cloudCoverListView, cloudCoverInfoView)
        cloudCoverListView.addSubviews(tableView)
        cloudCoverInfoView.addSubviews(cloudCoverInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: CLOUD COVER BACKGROUND:

        cloudCoverBackground.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        cloudCoverBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cloudCoverBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cloudCoverBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: CLOUD COVER LOGO:

        cloudCoverLogo.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        cloudCoverLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cloudCoverLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: CLOUD COVER VIEW FOR TABLE VIEW:

        cloudCoverListView.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverListView.topAnchor.constraint(equalTo: cloudCoverLogo.bottomAnchor, constant: 5).isActive = true
        cloudCoverListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cloudCoverListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cloudCoverListView.bottomAnchor.constraint(equalTo: cloudCoverInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: cloudCoverListView.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: cloudCoverListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: cloudCoverListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: cloudCoverListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CLOUD COVER VIEW:

        cloudCoverInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = cloudCoverInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = cloudCoverInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        cloudCoverInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cloudCoverInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        // MARK: CLOUD COVER LABEL:

        cloudCoverInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverInfoLabel.topAnchor.constraint(equalTo: cloudCoverInfoView.topAnchor, constant: 20).isActive = true
        cloudCoverInfoLabel.leadingAnchor.constraint(equalTo: cloudCoverInfoView.leadingAnchor, constant: 10).isActive = true
        cloudCoverInfoLabel.trailingAnchor.constraint(equalTo: cloudCoverInfoView.trailingAnchor, constant: -10).isActive = true
        cloudCoverInfoLabel.bottomAnchor.constraint(equalTo: cloudCoverInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: CLOUD COVER BACKGROUND:
        
        cloudCoverBackground.play()
        cloudCoverBackground.loopMode = .loop
        cloudCoverBackground.contentMode = .scaleToFill
        
        // MARK: CLOUD COVER LOGO:
        
        cloudCoverLogo.play()
        cloudCoverLogo.loopMode = .loop
        cloudCoverLogo.animationSpeed = 0.7
        
        // MARK: CLOUD COVER VIEW FOR TABLE VIEW:

        cloudCoverListView.layer.masksToBounds = true
        cloudCoverListView.layer.cornerRadius = cornerRadius15
        let blurEffect1 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView1 = UIVisualEffectView(effect: blurEffect1)
        blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView1.frame = cloudCoverListView.bounds
        cloudCoverListView.addSubviews(blurEffectView1, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: HUMIDITY VIEW:

        cloudCoverInfoView.layer.masksToBounds = true
        cloudCoverInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect2 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView2.frame = cloudCoverInfoView.bounds
        cloudCoverInfoView.addSubviews(blurEffectView2, cloudCoverInfoLabel)
        
        // MARK: HUMIDITY LABEL:
        
        cloudCoverInfoLabel.textColor = .white
        cloudCoverInfoLabel.font = AppFont.medium(size: 14).uiFont
        cloudCoverInfoLabel.numberOfLines = 0
        cloudCoverInfoLabel.adjustsFontSizeToFitWidth = true
        cloudCoverInfoLabel.textAlignment = .center
        cloudCoverInfoLabel.text = NSLocalizedString("Cloud cover weather message / alert", comment: "")
    }
    // MARK: - HELPERS:
}
// MARK: - EXTENSION:

extension CloudCoverVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCloudCover.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CloudCoverCell", for: indexPath) as? CloudCoverCell else { return UITableViewCell() }
        let cloudCover = arrayCloudCover[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: cloudCover.image ?? UIImage(), imageColor: cloudCover.color, name: cloudCover.name, value: cloudCover.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
    }
}
