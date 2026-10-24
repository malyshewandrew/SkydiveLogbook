import Lottie
import UIKit
import ShimmerSwift

class AccountVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let accountLottie = LottieAnimationView(name: "Account")
    private let nicknameView = UIView()
    private let nicknameLabel = UILabel()
    private let licenseView = UIView()
    private var licenseLabel = UILabel()
    private var medicineView = UIView()
    private var medicineLabel = UILabel()
    private var insuranceView = UIView()
    private var insuranceLabel = UILabel()
    private var reserveCanopyView = UIView()
    private var reserveCanopyLabel = UILabel()
    private var emptyAccountView = UIView()
    private var emptyAccountLabel = UILabel()
    private let emptyAccountShimmer = ShimmeringView()
    private var stackView = UIStackView()
    private let realmManager = RealmManager()
    
    private var nickname = ""
    private var licenseType = ""
    private var licenseDate = ""
    private var medicine = ""
    private var insurance = ""
    private var reserveCanopy = ""
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        configureNickname()
        configureLicenseType()
        configureLicenseDate()
        configureMedicine()
        configureInsurance()
        configureReserveCanopy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAccount()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(accountLottie, stackView, emptyAccountView)
        stackView.addArrangedSubviews(nicknameView, licenseView, medicineView, insuranceView, reserveCanopyView)
        nicknameView.addSubviews(nicknameLabel)
        licenseView.addSubviews(licenseLabel)
        medicineView.addSubviews(medicineLabel)
        insuranceView.addSubviews(insuranceLabel)
        reserveCanopyView.addSubviews(reserveCanopyLabel)
        emptyAccountView.addSubviews(emptyAccountLabel, emptyAccountShimmer)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: ACCOUNT LOTTIE:
        
        accountLottie.translatesAutoresizingMaskIntoConstraints = false
        accountLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
        accountLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accountLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: EMPTY ACCOUNT:
        
        emptyAccountView.translatesAutoresizingMaskIntoConstraints = false
        emptyAccountView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyAccountView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyAccountView.heightAnchor.constraint(greaterThanOrEqualTo: emptyAccountLabel.heightAnchor, constant: 10).isActive = true
        emptyAccountView.widthAnchor.constraint(greaterThanOrEqualTo: emptyAccountLabel.widthAnchor, constant: 10).isActive = true
        
        emptyAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyAccountLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        emptyAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        // MARK: STACK VIEW:

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: accountLottie.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // MARK: NICKNAME:
        
        nicknameView.translatesAutoresizingMaskIntoConstraints = false
        nicknameView.heightAnchor.constraint(greaterThanOrEqualTo: nicknameLabel.heightAnchor, constant: 10).isActive = true
        nicknameView.widthAnchor.constraint(greaterThanOrEqualTo: nicknameLabel.widthAnchor, constant: 10).isActive = true
        
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.centerYAnchor.constraint(equalTo: nicknameView.centerYAnchor).isActive = true
        nicknameLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        nicknameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        // MARK: LICENSE:
        
        licenseView.translatesAutoresizingMaskIntoConstraints = false
        licenseView.heightAnchor.constraint(greaterThanOrEqualTo: licenseLabel.heightAnchor, constant: 10).isActive = true
        licenseView.widthAnchor.constraint(greaterThanOrEqualTo: licenseLabel.widthAnchor, constant: 10).isActive = true
        
        licenseLabel.translatesAutoresizingMaskIntoConstraints = false
        licenseLabel.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        licenseLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        // MARK: MEDICINE:
        
        medicineView.translatesAutoresizingMaskIntoConstraints = false
        medicineView.heightAnchor.constraint(greaterThanOrEqualTo: medicineLabel.heightAnchor, constant: 10).isActive = true
        medicineView.widthAnchor.constraint(greaterThanOrEqualTo: medicineLabel.widthAnchor, constant: 10).isActive = true
        
        medicineLabel.translatesAutoresizingMaskIntoConstraints = false
        medicineLabel.centerYAnchor.constraint(equalTo: medicineView.centerYAnchor).isActive = true
        medicineLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        medicineLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        // MARK: INSURANCE:
        
        insuranceView.translatesAutoresizingMaskIntoConstraints = false
        insuranceView.heightAnchor.constraint(greaterThanOrEqualTo: insuranceLabel.heightAnchor, constant: 10).isActive = true
        insuranceView.widthAnchor.constraint(greaterThanOrEqualTo: insuranceLabel.widthAnchor, constant: 10).isActive = true
        
        insuranceLabel.translatesAutoresizingMaskIntoConstraints = false
        insuranceLabel.centerYAnchor.constraint(equalTo: insuranceView.centerYAnchor).isActive = true
        insuranceLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        insuranceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyView.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyView.heightAnchor.constraint(greaterThanOrEqualTo: reserveCanopyLabel.heightAnchor, constant: 10).isActive = true
        reserveCanopyView.widthAnchor.constraint(greaterThanOrEqualTo: reserveCanopyLabel.widthAnchor, constant: 10).isActive = true
        
        reserveCanopyLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyLabel.centerYAnchor.constraint(equalTo: reserveCanopyView.centerYAnchor).isActive = true
        reserveCanopyLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        reserveCanopyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: ACCOUNT LOTTIE:
        
        accountLottie.play()
        accountLottie.loopMode = .loop
        accountLottie.isHidden = true
        
        // MARK: EMPTY ACCOUNT:
        
        emptyAccountView.addBlurEffect(.systemThinMaterialDark)
        emptyAccountView.layer.masksToBounds = true
        emptyAccountView.layer.cornerRadius = cornerRadius15
        emptyAccountView.isHidden = true
        emptyAccountView.addSubviews(emptyAccountLabel, emptyAccountShimmer)
        emptyAccountLabel.textColor = .white
        emptyAccountLabel.numberOfLines = 0
        emptyAccountLabel.textAlignment = .center
        emptyAccountLabel.font = FontManager.medium(size: 12).uiFont
        emptyAccountLabel.adjustsFontSizeToFitWidth = true
        ShimmerManager.instance.addShimmerEffect(shimmerView: emptyAccountShimmer, toView: emptyAccountLabel, speed: 75)
        
        // MARK: STACK VIEW:

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        
        // MARK: NICKNAME:

        nicknameView.addBlurEffect(.systemThinMaterialDark)
        nicknameView.layer.masksToBounds = true
        nicknameView.layer.cornerRadius = cornerRadius15
        nicknameView.isHidden = true
        nicknameView.addSubview(nicknameLabel)
        nicknameLabel.textColor = .white
        nicknameLabel.textAlignment = .center
        nicknameLabel.font = FontManager.bold(size: 16).uiFont
        nicknameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: LICENSE TYPE:
        
        licenseView.addBlurEffect(.systemThinMaterialDark)
        licenseView.layer.masksToBounds = true
        licenseView.layer.cornerRadius = cornerRadius15
        licenseView.isHidden = true
        licenseView.addSubview(licenseLabel)
        licenseLabel.textColor = .white
        licenseLabel.textAlignment = .center
        licenseLabel.font = FontManager.medium(size: 14).uiFont
        licenseLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MEDICINE:
        
        medicineView.addBlurEffect(.systemThinMaterialDark)
        medicineView.layer.masksToBounds = true
        medicineView.layer.cornerRadius = cornerRadius15
        medicineView.isHidden = true
        medicineView.addSubview(medicineLabel)
        medicineLabel.textColor = .white
        medicineLabel.textAlignment = .center
        medicineLabel.font = FontManager.medium(size: 14).uiFont
        medicineLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: INSURANCE:
        
        insuranceView.addBlurEffect(.systemThinMaterialDark)
        insuranceView.layer.masksToBounds = true
        insuranceView.layer.cornerRadius = cornerRadius15
        insuranceView.isHidden = true
        insuranceView.addSubview(insuranceLabel)
        insuranceLabel.textColor = .white
        insuranceLabel.textAlignment = .center
        insuranceLabel.font = FontManager.medium(size: 14).uiFont
        insuranceLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyView.addBlurEffect(.systemThinMaterialDark)
        reserveCanopyView.layer.masksToBounds = true
        reserveCanopyView.layer.cornerRadius = cornerRadius15
        reserveCanopyView.isHidden = true
        reserveCanopyView.addSubview(reserveCanopyLabel)
        reserveCanopyLabel.textColor = .white
        reserveCanopyLabel.textAlignment = .center
        reserveCanopyLabel.font = FontManager.medium(size: 14).uiFont
        reserveCanopyLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - LOAD ACCOUNT FROM REALM:

    private func loadAccount() {
        arrayAccountRealm = realmManager.localRealm.objects(AccountClassRealm.self).map { $0 }
    }
    
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE NICKNAME:

    private func configureNickname() {
        if arrayAccountRealm.count == 0 {
            nickname = ""
        } else {
            if arrayAccountRealm[0].nickname.isEmpty {
            } else {
                nicknameView.isHidden = false
                nickname = arrayAccountRealm[0].nickname
            }
        }
    }
    
    // MARK: CONFIGURE LICENSE TYPE:

    private func configureLicenseType() {
        if arrayAccountRealm.count == 0 {
            licenseType = ""
        } else {
            if arrayAccountRealm[0].licenseType.isEmpty {
            } else {
                licenseView.isHidden = false
                licenseType = "\(NSLocalizedString("License", comment: "")) " + "\"" + arrayAccountRealm[0].licenseType + "\""
            }
        }
    }
    
    // MARK: CONFIGURE LICENSE DATE:

    private func configureLicenseDate() {
        if arrayAccountRealm.count == 0 {
            licenseDate = ""
        } else {
            if arrayAccountRealm[0].licenseDate.isEmpty {
            } else {
                licenseDate = " \(NSLocalizedString("until", comment: "")): " + arrayAccountRealm[0].licenseDate
            }
        }
    }
    
    // MARK: CONFIGURE MEDICINE:

    private func configureMedicine() {
        if arrayAccountRealm.count == 0 {
            medicine = ""
        } else {
            if arrayAccountRealm[0].medicine == "" {
            } else {
                medicineView.isHidden = false
                medicine = NSLocalizedString("Medicine until", comment: "") + ": " + arrayAccountRealm[0].medicine
            }
        }
    }
    
    // MARK: CONFIGURE INSURANCE:

    private func configureInsurance() {
        if arrayAccountRealm.count == 0 {
            insurance = ""
        } else {
            if arrayAccountRealm[0].insurance == "" {
            } else {
                insuranceView.isHidden = false
                insurance = NSLocalizedString("Insurance until", comment: "") + ": " + arrayAccountRealm[0].insurance
            }
        }
    }
    
    // MARK: CONFIGURE RESERVE CANOPY:

    private func configureReserveCanopy() {
        if arrayAccountRealm.count == 0 {
            reserveCanopy = ""
        } else {
            if arrayAccountRealm[0].reserveCanopy == "" {
            } else {
                reserveCanopyView.isHidden = false
                reserveCanopy = NSLocalizedString("Reserve canopy until", comment: "") + ": " + arrayAccountRealm[0].reserveCanopy
            }
        }
    }
        
    // MARK: CONFIGURE ACCOUNT:

    private func configureAccount() {
        if nickname == "" && licenseType == "" && licenseDate == "" && medicine == "" && insurance == "" && reserveCanopy == "" {
            accountLottie.isHidden = true
            emptyAccountView.isHidden = false
            emptyAccountLabel.text = "\n\(NSLocalizedString("Edit/add account", comment: ""))"
        } else {
            accountLottie.isHidden = true
            emptyAccountView.isHidden = true
            nicknameLabel.text = nickname.uppercased()
            licenseLabel.text = licenseType + licenseDate
            medicineLabel.text = medicine
            insuranceLabel.text = insurance
            reserveCanopyLabel.text = reserveCanopy
        }
    }
}
