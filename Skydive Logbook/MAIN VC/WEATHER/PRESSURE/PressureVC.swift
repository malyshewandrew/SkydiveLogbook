import Lottie
import UIKit

// MARK: PRESSURE MODEL:

struct PressureModel {
    let image: UIImage?
    let color: UIColor
    let name: String
    let value: String
}

// MARK: ARRAY PRESSURE VALUES:

private let arrayPressure = [
    PressureModel(image: UIImage(systemName: "globe.europe.africa.fill"), color: #colorLiteral(red: 0.02996753901, green: 0.7603672147, blue: 0.7500696778, alpha: 1), name: NSLocalizedString("Very low / pressure", comment: ""), value: "<20 " + NSLocalizedString("mm / pressure", comment: "")),
    PressureModel(image: UIImage(systemName: "globe.europe.africa.fill"), color: #colorLiteral(red: 0.008190996945, green: 0.7086946964, blue: 0.3351221085, alpha: 1), name: NSLocalizedString("Low / pressure", comment: ""), value: "<10-20 " + NSLocalizedString("mm / pressure", comment: "")),
    PressureModel(image: UIImage(systemName: "globe.europe.africa.fill"), color: #colorLiteral(red: 0.8648145795, green: 0.6460573077, blue: 0.001722229063, alpha: 1), name: NSLocalizedString("Normal / pressure", comment: ""), value: "±10 " + NSLocalizedString("mm / pressure", comment: "")),
    PressureModel(image: UIImage(systemName: "globe.europe.africa.fill"), color: #colorLiteral(red: 0.9018223286, green: 0.3199688196, blue: 0.01046972442, alpha: 1), name: NSLocalizedString("Hight / pressure", comment: ""), value: ">10-20 " + NSLocalizedString("mm / pressure", comment: "")),
    PressureModel(image: UIImage(systemName: "globe.europe.africa.fill"), color: #colorLiteral(red: 0.9055797458, green: 0.09583576769, blue: 0.3299447, alpha: 1), name: NSLocalizedString("Very hight / pressure", comment: ""), value: ">20 " + NSLocalizedString("mm / pressure", comment: ""))
]

// MARK: - CLASS:

final class PressureVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let pressureBackgroundLottie = LottieAnimationView(name: "WeatherPressureBackground")
    private let pressureLogoLottie = LottieAnimationView(name: "WeatherPressure")
    private let pressureListView = UIView()
    private let tableView = UITableView()
    private let pressureInfoView = UIView()
    private let pressureInfoLabel = UILabel()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PressureCell.self, forCellReuseIdentifier: "PressureCell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(pressureBackgroundLottie, pressureLogoLottie, pressureListView, pressureInfoView)
        pressureListView.addSubviews(tableView)
        pressureInfoView.addSubviews(pressureInfoLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: PRESSURE BACKGROUND:

        pressureBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        pressureBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pressureBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pressureBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pressureBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: PRESSURE LOGO:

        pressureLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        pressureLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        pressureLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pressureLogoLottie.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        // MARK: PRESSURE VIEW FOR TABLE VIEW:

        pressureListView.translatesAutoresizingMaskIntoConstraints = false
        pressureListView.topAnchor.constraint(equalTo: pressureLogoLottie.bottomAnchor, constant: 20).isActive = true
        pressureListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pressureListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        pressureListView.bottomAnchor.constraint(equalTo: pressureInfoView.topAnchor, constant: -15).isActive = true
        
        // MARK: TABLE VIEW:
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: pressureListView.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: pressureListView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: pressureListView.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: pressureListView.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: PRESSURE VIEW:

        pressureInfoView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = pressureInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        bottomConstraint.isActive = true
        let heightConstraint = pressureInfoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        pressureInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pressureInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // MARK: PRESSURE LABEL:
        
        pressureInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureInfoLabel.topAnchor.constraint(equalTo: pressureInfoView.topAnchor, constant: 20).isActive = true
        pressureInfoLabel.leadingAnchor.constraint(equalTo: pressureInfoView.leadingAnchor, constant: 10).isActive = true
        pressureInfoLabel.trailingAnchor.constraint(equalTo: pressureInfoView.trailingAnchor, constant: -10).isActive = true
        pressureInfoLabel.bottomAnchor.constraint(equalTo: pressureInfoView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground
        
        // MARK: PRESSURE BACKGROUND:
        
        pressureBackgroundLottie.play()
        pressureBackgroundLottie.loopMode = .loop
        pressureBackgroundLottie.animationSpeed = 0.7
        pressureBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: PRESSURE LOGO:
        
        pressureLogoLottie.play()
        pressureLogoLottie.loopMode = .loop
        pressureLogoLottie.animationSpeed = 0.7
        
        // MARK: PRESSURE VIEW FOR TABLE VIEW:

        pressureListView.layer.masksToBounds = true
        pressureListView.layer.cornerRadius = cornerRadius15
        let blurEffect1 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView1 = UIVisualEffectView(effect: blurEffect1)
        blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView1.frame = pressureListView.bounds
        pressureListView.addSubviews(blurEffectView1, tableView)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = .clear
        
        // MARK: PRESSURE VIEW:

        pressureInfoView.layer.masksToBounds = true
        pressureInfoView.layer.cornerRadius = cornerRadius15
        let blurEffect2 = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView2.frame = pressureInfoView.bounds
        pressureInfoView.addSubviews(blurEffectView2, pressureInfoLabel)
        
        // MARK: PRESSURE LABEL:
        
        pressureInfoLabel.textColor = .white
        pressureInfoLabel.font = AppFont.medium(size: 14).uiFont
        pressureInfoLabel.numberOfLines = 0
        pressureInfoLabel.adjustsFontSizeToFitWidth = true
        pressureInfoLabel.textAlignment = .center
        pressureInfoLabel.text = NSLocalizedString("Pressure weather message / alert", comment: "")
    }
    // MARK: - HELPERS:
}
// MARK: - EXTENSION:

extension PressureVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: CELL COUNTS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayPressure.count
    }
    
    // MARK: CUSTOM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PressureCell", for: indexPath) as? PressureCell else { return UITableViewCell() }
        let pressure = arrayPressure[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(image: pressure.image ?? UIImage(), imageColor: pressure.color, name: pressure.name, value: pressure.value)
        return cell
    }
    
    // MARK: SELECTED CELL:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
    }
}
