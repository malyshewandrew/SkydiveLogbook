import Lottie
import UIKit

// MARK: STRUCT UVINDEX VALUES:

struct UvIndex {
    let image: UIImage?
    let imageColor: UIColor
    let name: String
    let value: String
}

// MARK: ARRAY UVINDEX VALUES:

private let arrayUvIndex = [
    UvIndex(image: UIImage(systemName: "thermometer.variable.and.figure"), imageColor: #colorLiteral(red: 0.009829076938, green: 0.7325571179, blue: 0.5401486754, alpha: 1), name: NSLocalizedString("Low / uv index", comment: ""), value: "0-2"),
    UvIndex(image: UIImage(systemName: "thermometer.variable.and.figure"), imageColor: #colorLiteral(red: 0.1420840621, green: 0.7043048739, blue: 0.1435457766, alpha: 1), name: NSLocalizedString("Moderate / uv index", comment: ""), value: "3-5"),
    UvIndex(image: UIImage(systemName: "thermometer.variable.and.figure"), imageColor: #colorLiteral(red: 0.8648145795, green: 0.6460573077, blue: 0.001722229063, alpha: 1), name: NSLocalizedString("Hight / uv index", comment: ""), value: "6-7"),
    UvIndex(image: UIImage(systemName: "thermometer.variable.and.figure"), imageColor: #colorLiteral(red: 0.9018223286, green: 0.3199688196, blue: 0.01046972442, alpha: 1), name: NSLocalizedString("Very high / uv index", comment: ""), value: "8-10"),
    UvIndex(image: UIImage(systemName: "thermometer.variable.and.figure"), imageColor: #colorLiteral(red: 0.9055797458, green: 0.09583576769, blue: 0.3299447, alpha: 1), name: NSLocalizedString("Excessive / uv index", comment: ""), value: "11+")
]

// MARK: - CLASS:

final class UvIndexVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let uvIndexBackgroundLottie = LottieAnimationView(name: "WeatherUvIndexBackground")
    private let uvIndexLogoLottie = LottieAnimationView(name: "WeatherUvIndex")
    private let uvIndexListView = UIView()
    private let tableView = UITableView()
    private let uvIndexInfoView = UIView()
    private let uvIndexInfoLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UvIndexCell.self, forCellReuseIdentifier: "UvIndexCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(uvIndexBackgroundLottie, uvIndexLogoLottie, uvIndexListView, uvIndexInfoView)
        uvIndexListView.addSubviews(tableView)
        uvIndexInfoView.addSubviews(uvIndexInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: UVINDEX BACKGROUND:

        uvIndexBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        uvIndexBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        uvIndexBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uvIndexBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uvIndexBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: UVINDEX LOGO:

        uvIndexLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        uvIndexLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        uvIndexLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uvIndexLogoLottie.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        // MARK: UVINDEX VIEW FOR TABLE VIEW:

        uvIndexListView.translatesAutoresizingMaskIntoConstraints = false
        uvIndexListView.topAnchor.constraint(equalTo: uvIndexLogoLottie.bottomAnchor).isActive = true
        uvIndexListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        uvIndexListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        uvIndexListView.bottomAnchor.constraint(equalTo: uvIndexInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: uvIndexListView.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: uvIndexListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: uvIndexListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: uvIndexListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: UVINDEX VIEW:

        uvIndexInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = uvIndexInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = uvIndexInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        uvIndexInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        uvIndexInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: UVINDEX LABEL:
        
        uvIndexInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        uvIndexInfoLabel.topAnchor.constraint(equalTo: uvIndexInfoView.topAnchor, constant: 20).isActive = true
        uvIndexInfoLabel.leadingAnchor.constraint(equalTo: uvIndexInfoView.leadingAnchor, constant: 10).isActive = true
        uvIndexInfoLabel.trailingAnchor.constraint(equalTo: uvIndexInfoView.trailingAnchor, constant: -10).isActive = true
        uvIndexInfoLabel.bottomAnchor.constraint(equalTo: uvIndexInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: UVINDEX BACKGROUND:
        
        uvIndexBackgroundLottie.play()
        uvIndexBackgroundLottie.loopMode = .loop
        uvIndexBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: UVINDEX LOGO:
        
        uvIndexLogoLottie.play()
        uvIndexLogoLottie.loopMode = .loop
        uvIndexLogoLottie.animationSpeed = 0.7
        
        // MARK: UVINDEX VIEW:

        uvIndexListView.layer.masksToBounds = true
        uvIndexListView.layer.cornerRadius = cornerRadius15
        let blurEffectUvIndexView = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectViewUvIndexView = UIVisualEffectView(effect: blurEffectUvIndexView)
        blurEffectViewUvIndexView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectViewUvIndexView.frame = uvIndexInfoView.bounds
        uvIndexListView.addSubviews(blurEffectViewUvIndexView, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: UVINDEX VIEW:

        uvIndexInfoView.layer.masksToBounds = true
        uvIndexInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = uvIndexInfoView.bounds
        uvIndexInfoView.addSubviews(blurEffectView, uvIndexInfoLabel)
        
        // MARK: UVINDEX LABEL:
        
        uvIndexInfoLabel.textColor = .white
        uvIndexInfoLabel.font = AppFont.medium(size: 14).uiFont
        uvIndexInfoLabel.numberOfLines = 0
        uvIndexInfoLabel.adjustsFontSizeToFitWidth = true
        uvIndexInfoLabel.textAlignment = .center
        uvIndexInfoLabel.text = NSLocalizedString("UvIndex weather message / alert", comment: "")
    }
}

// MARK: - EXTENSION:

extension UvIndexVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayUvIndex.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UvIndexCell", for: indexPath) as? UvIndexCell else { return UITableViewCell() }
        let uvIndex = arrayUvIndex[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: uvIndex.image ?? UIImage(), imageColor: uvIndex.imageColor, name: uvIndex.name, value: uvIndex.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
    }
}
