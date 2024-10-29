import AlertKit
import AudioToolbox
import AVFoundation
import Lottie
import RealmSwift
import UIKit

final class MainVC: UIViewController {
    // MARK: - PROPERTIES:

    private let mainShadowLottie = LottieAnimationView(name: "MainShadowLottie")
    private let mainLottie = LottieAnimationView(name: "Main")
    private let mainStartLottie = LottieAnimationView(name: "Main")
    private let confettiLottie = LottieAnimationView(name: "MainConfetti")
    private let startCenterConfettiLottie = LottieAnimationView(name: "MainConfetti")
    private let startConfettiCenterButton = UIButton()
    private let startConfettiTopLottie = LottieAnimationView(name: "StartConfettiTop")

    private let confettiButton = UIButton()
    private let accountButton = UIButton()
    private let weatherButton = UIButton()
    private let mapsButton = UIButton()
    private let communityButton = UIButton()
    private let calculatorButton = UIButton()
    private let notesButton = UIButton()
    private let tableView = UITableView()
    
    private let firstMessageView = UIView()
    private let firstMessageLabel = UILabel()
    private let firstLocationTextField = UITextField()
    private let firstAircraftTextField = UITextField()
    private let firstCanopyTextField = UITextField()
    private let saveButton = UIButton()
    private let secondMessageLabel = UILabel()
    
    private let emptyConfettiLottie = LottieAnimationView(name: "SettingsConfetti")
    private let emptyJumpsView = UIView()
    private let emptyJumpsLabel = UILabel()
    private let emptySkydiverLottie = LottieAnimationView(name: "EmptySkydiverLottie")
    private let emptySkydiverButton = UIButton()
    private var buildVersion = ""
    private var appVersion = ""
    private let emptyFlowersLottie = LottieAnimationView(name: "EmptyFlowersLottie")

    private let dateFormatter = DateFormatter()
    private var selectedJump: JumpClassRealm?
    private let realmManager = RealmManager()
    private var player = AVAudioPlayer()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 30)

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        configureGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        loadAccount()
        checkData()
        tableView.reloadData()
        sortArray()
        arrayJumpsRealm.reverse()
        startConfigureGestures()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(mainShadowLottie, mainLottie, confettiLottie, confettiButton, accountButton, weatherButton, mapsButton, communityButton, calculatorButton, notesButton, tableView, emptyConfettiLottie, emptySkydiverLottie, emptySkydiverButton, emptyFlowersLottie, emptyJumpsView, startCenterConfettiLottie, startConfettiTopLottie, firstMessageView, mainStartLottie, startConfettiCenterButton)
        firstMessageView.addSubviews(firstMessageLabel, firstLocationTextField, firstAircraftTextField, firstCanopyTextField, saveButton, secondMessageLabel)
        emptyJumpsView.addSubviews(emptyJumpsLabel)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {

        // MARK: MAIN SHADOW LOTTIE:

        mainShadowLottie.translatesAutoresizingMaskIntoConstraints = false
        mainShadowLottie.centerXAnchor.constraint(equalTo: mainLottie.centerXAnchor).isActive = true
        mainShadowLottie.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 10).isActive = true
        mainShadowLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true

        // MARK: ANIMATION MAIN LOTTIE:

        mainLottie.translatesAutoresizingMaskIntoConstraints = false
        mainLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        mainLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        mainLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: mainLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: ACCOUNT BUTTON:

        accountButton.translatesAutoresizingMaskIntoConstraints = false
        accountButton.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 5).isActive = true
        accountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true

        // MARK: WEATHER BUTTON:

        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        weatherButton.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 5).isActive = true
        weatherButton.leadingAnchor.constraint(equalTo: accountButton.trailingAnchor, constant: 17).isActive = true

        // MARK: MAPS BUTTON:

        mapsButton.translatesAutoresizingMaskIntoConstraints = false
        mapsButton.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 5).isActive = true
        mapsButton.leadingAnchor.constraint(equalTo: weatherButton.trailingAnchor, constant: 17).isActive = true

        // MARK: COMMUNITY:

        communityButton.translatesAutoresizingMaskIntoConstraints = false
        communityButton.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 5).isActive = true
        communityButton.trailingAnchor.constraint(equalTo: calculatorButton.leadingAnchor, constant: -17).isActive = true

        // MARK: CALCULATOR:

        calculatorButton.translatesAutoresizingMaskIntoConstraints = false
        calculatorButton.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 5).isActive = true
        calculatorButton.trailingAnchor.constraint(equalTo: notesButton.leadingAnchor, constant: -17).isActive = true

        // MARK: NOTES:

        notesButton.translatesAutoresizingMaskIntoConstraints = false
        notesButton.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 5).isActive = true
        notesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mainLottie.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: - FIRST VIEW:
        
        // MARK: START LOTTIE CENTER CONFETTI:

        startCenterConfettiLottie.translatesAutoresizingMaskIntoConstraints = false
        startCenterConfettiLottie.centerXAnchor.constraint(equalTo: mainStartLottie.centerXAnchor).isActive = true
        startCenterConfettiLottie.centerYAnchor.constraint(equalTo: mainStartLottie.centerYAnchor).isActive = true
        startCenterConfettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        startCenterConfettiLottie.layer.shadowRadius = 15
        startCenterConfettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        startCenterConfettiLottie.layer.shadowOpacity = 1

        // MARK: ANIMATION MAIN LOTTIE:

        mainStartLottie.translatesAutoresizingMaskIntoConstraints = false
        mainStartLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStartLottie.bottomAnchor.constraint(equalTo: firstMessageView.topAnchor).isActive = true
        mainStartLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        mainStartLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        mainStartLottie.play()
        mainStartLottie.loopMode = .autoReverse

        // MARK: FIRST MESSAGE VIEW:

        firstMessageView.translatesAutoresizingMaskIntoConstraints = false
        firstMessageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstMessageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        firstMessageView.bottomAnchor.constraint(equalTo: secondMessageLabel.bottomAnchor, constant: 10).isActive = true
        firstMessageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        firstMessageView.backgroundColor = .colorCell
        firstMessageView.layer.cornerRadius = cornerRadius15
        firstMessageView.layer.shadowRadius = 100
        firstMessageView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        firstMessageView.layer.shadowOpacity = 0.5

        // MARK: FIRST MESSAGE LABEL:

        firstMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        firstMessageLabel.centerXAnchor.constraint(equalTo: firstMessageView.centerXAnchor).isActive = true
        firstMessageLabel.topAnchor.constraint(equalTo: firstMessageView.topAnchor, constant: 10).isActive = true
        firstMessageLabel.widthAnchor.constraint(equalTo: firstMessageView.widthAnchor, multiplier: 0.9).isActive = true

        firstMessageLabel.textColor = .colorWhite
        firstMessageLabel.font = FontManager.regular(size: 12).uiFont
        firstMessageLabel.numberOfLines = 0
        firstMessageLabel.textAlignment = .center
        firstMessageLabel.adjustsFontSizeToFitWidth = true
        firstMessageLabel.text = NSLocalizedString("First add text / first add", comment: "")
        
        // MARK: LOCATION TEXT FIELD:
        
        firstLocationTextField.translatesAutoresizingMaskIntoConstraints = false
        firstLocationTextField.topAnchor.constraint(equalTo: firstMessageLabel.bottomAnchor, constant: 15).isActive = true
        firstLocationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstLocationTextField.widthAnchor.constraint(equalTo: firstMessageView.widthAnchor, multiplier: 0.9).isActive = true
        firstLocationTextField.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 0.8).isActive = true
        
        firstLocationTextField.backgroundColor = .colorTabBar
        firstLocationTextField.textColor = .colorWhite
        firstLocationTextField.layer.cornerRadius = cornerRadius15
        firstLocationTextField.textAlignment = textAligmentCenter
        firstLocationTextField.placeholder = NSLocalizedString("Enter location", comment: "")
        
        // MARK: AIRCRAFT TEXT FIELD:
        
        firstAircraftTextField.translatesAutoresizingMaskIntoConstraints = false
        firstAircraftTextField.topAnchor.constraint(equalTo: firstLocationTextField.bottomAnchor, constant: 15).isActive = true
        firstAircraftTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstAircraftTextField.widthAnchor.constraint(equalTo: firstMessageView.widthAnchor, multiplier: 0.9).isActive = true
        firstAircraftTextField.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 0.8).isActive = true
        
        firstAircraftTextField.backgroundColor = .colorTabBar
        firstAircraftTextField.textColor = .colorWhite
        firstAircraftTextField.layer.cornerRadius = cornerRadius15
        firstAircraftTextField.textAlignment = textAligmentCenter
        firstAircraftTextField.placeholder = NSLocalizedString("Enter aircraft", comment: "")
        
        // MARK: CANOPY TEXT FIELD:
        
        firstCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
        firstCanopyTextField.topAnchor.constraint(equalTo: firstAircraftTextField.bottomAnchor, constant: 15).isActive = true
        firstCanopyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstCanopyTextField.widthAnchor.constraint(equalTo: firstMessageView.widthAnchor, multiplier: 0.9).isActive = true
        firstCanopyTextField.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 0.8).isActive = true
        
        firstCanopyTextField.backgroundColor = .colorTabBar
        firstCanopyTextField.textColor = .colorWhite
        firstCanopyTextField.layer.cornerRadius = cornerRadius15
        firstCanopyTextField.textAlignment = textAligmentCenter

        firstCanopyTextField.placeholder = NSLocalizedString("Enter canopy", comment: "")
        
        // MARK: SAVE BUTTON:
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: firstCanopyTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
        
        saveButton.backgroundColor = .colorTabBar
        saveButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        saveButton.setTitleColor(.colorWhite, for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .highlighted)
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = cornerRadius15
        saveButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            guard firstLocationTextField.text != "" else {
                showError(textField: firstLocationTextField)
                return
            }
            guard firstAircraftTextField.text != "" else {
                showError(textField: firstAircraftTextField)
                return
            }
            guard firstCanopyTextField.text != "" else {
                showError(textField: firstCanopyTextField)
                return
            }
            saveFirstData()
        }), for: .touchUpInside)
        
        // MARK: SECOND MESSAGE LABEL:
        
        secondMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        secondMessageLabel.centerXAnchor.constraint(equalTo: firstMessageView.centerXAnchor).isActive = true
        secondMessageLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10).isActive = true
        secondMessageLabel.widthAnchor.constraint(equalTo: firstMessageView.widthAnchor, multiplier: 0.9).isActive = true

        secondMessageLabel.textColor = .colorWhite
        secondMessageLabel.font = FontManager.regular(size: 12).uiFont
        secondMessageLabel.numberOfLines = 0
        secondMessageLabel.textAlignment = .center
        secondMessageLabel.adjustsFontSizeToFitWidth = true
        secondMessageLabel.text = NSLocalizedString("Second add text / first add", comment: "")

        // MARK: START CONFETTI LOTTIE TOP:

        startConfettiTopLottie.translatesAutoresizingMaskIntoConstraints = false
        startConfettiTopLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        startConfettiTopLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        startConfettiTopLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        startConfettiTopLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        startConfettiTopLottie.play()
        startConfettiTopLottie.loopMode = .loop
        startConfettiTopLottie.contentMode = .scaleAspectFill
        startConfettiTopLottie.animationSpeed = 0.5

        // MARK: START CONFETTI CENTER BUTTON:

        startConfettiCenterButton.translatesAutoresizingMaskIntoConstraints = false
        startConfettiCenterButton.centerXAnchor.constraint(equalTo: mainStartLottie.centerXAnchor).isActive = true
        startConfettiCenterButton.centerYAnchor.constraint(equalTo: mainStartLottie.centerYAnchor).isActive = true
        startConfettiCenterButton.heightAnchor.constraint(equalTo: mainStartLottie.heightAnchor, multiplier: 1).isActive = true
        startConfettiCenterButton.widthAnchor.constraint(equalTo: mainStartLottie.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: - EMPTY JUMPS VIEW:
        
        // MARK: EMPTY JUMPS VIEW:
        
        emptyJumpsView.translatesAutoresizingMaskIntoConstraints = false
        emptyJumpsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyJumpsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emptyJumpsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        emptyJumpsView.heightAnchor.constraint(greaterThanOrEqualTo: emptyJumpsLabel.heightAnchor).isActive = true
        
        emptyJumpsView.backgroundColor = .colorCell
        emptyJumpsView.layer.cornerRadius = cornerRadius15
        emptyJumpsView.layer.shadowRadius = 100
        emptyJumpsView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        emptyJumpsView.layer.shadowOpacity = 0.5
        
        // MARK: EMPTY JUMPS LABEL:
        
        emptyJumpsLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyJumpsLabel.centerXAnchor.constraint(equalTo: emptyJumpsView.centerXAnchor).isActive = true
        emptyJumpsLabel.centerYAnchor.constraint(equalTo: emptyJumpsView.centerYAnchor).isActive = true
        emptyJumpsLabel.widthAnchor.constraint(equalTo: emptyJumpsView.widthAnchor, multiplier: 0.9).isActive = true
        
        emptyJumpsLabel.textColor = .white
        emptyJumpsLabel.textAlignment = .center
        emptyJumpsLabel.numberOfLines = 0
        emptyJumpsLabel.font = FontManager.regular(size: 12).uiFont
        emptyJumpsLabel.text = NSLocalizedString("First Message", comment: "")
        
        // MARK: EMPTY CONFETTI LOTTIE:
        
        emptyConfettiLottie.translatesAutoresizingMaskIntoConstraints = false
        emptyConfettiLottie.centerXAnchor.constraint(equalTo: emptySkydiverLottie.centerXAnchor).isActive = true
        emptyConfettiLottie.centerYAnchor.constraint(equalTo: emptySkydiverLottie.centerYAnchor).isActive = true
        emptyConfettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        emptyConfettiLottie.heightAnchor.constraint(equalTo: emptyConfettiLottie.widthAnchor, multiplier: 1).isActive = true
        
        emptyConfettiLottie.loopMode = .playOnce
        emptyConfettiLottie.layer.shadowRadius = 15
        emptyConfettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        emptyConfettiLottie.layer.shadowOpacity = 1
        
        // MARK: EMPTY SKYDIVER LOTTIE:
        
        emptySkydiverLottie.translatesAutoresizingMaskIntoConstraints = false
        emptySkydiverLottie.bottomAnchor.constraint(equalTo: emptyJumpsView.topAnchor).isActive = true
        emptySkydiverLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptySkydiverLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        emptySkydiverLottie.heightAnchor.constraint(equalTo: emptySkydiverLottie.widthAnchor, multiplier: 1).isActive = true
        
        emptySkydiverLottie.isHidden = true
        emptySkydiverLottie.play()
        emptySkydiverLottie.loopMode = .loop
        emptySkydiverLottie.animationSpeed = 0.8
        emptySkydiverLottie.contentMode = .scaleAspectFill
        
        // MARK: EMPTY SKYDIVER BUTTON:
        
        emptySkydiverButton.translatesAutoresizingMaskIntoConstraints = false
        emptySkydiverButton.topAnchor.constraint(equalTo: emptySkydiverLottie.topAnchor).isActive = true
        emptySkydiverButton.bottomAnchor.constraint(equalTo: emptySkydiverLottie.bottomAnchor).isActive = true
        emptySkydiverButton.leadingAnchor.constraint(equalTo: emptySkydiverLottie.leadingAnchor).isActive = true
        emptySkydiverButton.trailingAnchor.constraint(equalTo: emptySkydiverLottie.trailingAnchor).isActive = true
        
        emptySkydiverButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            emptyConfettiLottie.play()
            if let infoDictionary = Bundle.main.infoDictionary {
                if let buildVersion = infoDictionary["CFBundleVersion"] as? String {
                    self.buildVersion = buildVersion
                }
                if let appVersion = infoDictionary["CFBundleShortVersionString"] as? String {
                    self.appVersion = appVersion
                }
            }
            let versionMessage = NSLocalizedString("Version / info", comment: "") + ": " + appVersion
            let buildMessage = NSLocalizedString("Build / info", comment: "") + ": " + buildVersion
            let imageView = UIImageView(image: UIImage(named: "AppIconVersion"))
            let versionSettingsLottie = LottieAnimationView(name: "VersionSettingsLottie")
            let alert = UIAlertController(title: "SkydiveBook™", message: "\n\n\n\(versionMessage). \(buildMessage)\n© Malyshew Andrew\nApp Store, 2023-2024", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            alert.view.addSubviews(versionSettingsLottie, imageView)
            
            versionSettingsLottie.translatesAutoresizingMaskIntoConstraints = false
            versionSettingsLottie.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
            versionSettingsLottie.topAnchor.constraint(equalTo: alert.view.topAnchor).isActive = true
            versionSettingsLottie.heightAnchor.constraint(equalToConstant: 140).isActive = true
            versionSettingsLottie.widthAnchor.constraint(equalToConstant: 275).isActive = true
            versionSettingsLottie.play()
            versionSettingsLottie.loopMode = .loop

            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
            imageView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor, constant: -35).isActive = true
            imageView.layer.shadowRadius = 35
            imageView.layer.shadowColor = UIColor.colorWhite.cgColor
            imageView.layer.shadowOpacity = 1

            present(alert, animated: true)
        }), for: .touchUpInside)
        
        // MARK: EMPTY FLOWER LOTTIE:
        
        emptyFlowersLottie.translatesAutoresizingMaskIntoConstraints = false
        emptyFlowersLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        emptyFlowersLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        emptyFlowersLottie.play()
        emptyFlowersLottie.loopMode = .loop
        emptyFlowersLottie.animationSpeed = 0.3
        emptyFlowersLottie.contentMode = .scaleAspectFill
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        
        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1

        // MARK: MAIN SHADOW LOTTIE:

        mainShadowLottie.play()
        mainShadowLottie.loopMode = .loop
        mainShadowLottie.layer.opacity = 0.2
        mainShadowLottie.animationSpeed = 0.2
        mainShadowLottie.layer.shadowRadius = 5
        mainShadowLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        mainShadowLottie.layer.shadowOpacity = 1

        // MARK: MAIN LOTTIE:

        mainLottie.play()
        mainLottie.loopMode = .autoReverse

        // MARK: CONFETTI BUTTON:

        confettiButton.layer.masksToBounds = true
        confettiButton.layer.shadowRadius = 25
        confettiButton.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiButton.layer.shadowOpacity = 1

        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIAGTION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""

        // MARK: ACCOUNT:

        accountButton.setImage(UIImage(systemName: "person.crop.circle.fill", withConfiguration: configurationImage), for: .normal)
        accountButton.tintColor = .colorDarkGray
        accountButton.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)

        // MARK: WEATHER:

        weatherButton.setImage(UIImage(systemName: "sun.max.circle.fill", withConfiguration: configurationImage), for: .normal)
        weatherButton.tintColor = .colorDarkGray
        weatherButton.addTarget(self, action: #selector(weatherButtonTapped), for: .touchUpInside)

        // MARK: MAPS:

        mapsButton.setImage(UIImage(systemName: "mappin.and.ellipse.circle.fill", withConfiguration: configurationImage), for: .normal)
        mapsButton.tintColor = .colorDarkGray
        mapsButton.addTarget(self, action: #selector(dropzonesButtonTapped), for: .touchUpInside)

        // MARK: CONFETTI BUTTON:

        confettiButton.addTarget(self, action: #selector(confettiButtonTapped), for: .touchUpInside)

        // MARK: COMMUNITY:

        communityButton.setImage(UIImage(systemName: "person.2.circle.fill", withConfiguration: configurationImage), for: .normal)
        communityButton.tintColor = .colorDarkGray
        communityButton.addTarget(self, action: #selector(skydiversButtonTapped), for: .touchUpInside)

        // MARK: CALCULATORS:

        calculatorButton.setImage(UIImage(systemName: "divide.circle.fill", withConfiguration: configurationImage), for: .normal)
        calculatorButton.tintColor = .colorDarkGray
        calculatorButton.addTarget(self, action: #selector(calculatorButtonTapped), for: .touchUpInside)

        // MARK: NOTES:

        notesButton.setImage(UIImage(systemName: "book.circle.fill", withConfiguration: configurationImage), for: .normal)
        notesButton.tintColor = .colorDarkGray
        notesButton.addTarget(self, action: #selector(notesButtonTapped), for: .touchUpInside)
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }

    // MARK: - LOAD JUMPS FROM REALM:

    private func loadJumps() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map { $0 }
    }

    // MARK: - LOAD ACCOUNT FROM REALM:

    private func loadAccount() {
        arrayAccountRealm = realmManager.localRealm.objects(AccountClassRealm.self).map { $0 }
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: THREE TAP FOR PLAY ANIMATIONS:

        let confettiGesture = UILongPressGestureRecognizer(target: self, action: #selector(confettiButtonLongPress))
        confettiButton.addGestureRecognizer(confettiGesture)
        
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func startConfigureGestures() {
        // MARK: THREE TAP FOR PLAY ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(startConfettiButtonTapped))
        confettiGesture.numberOfTapsRequired = 1
        startConfettiCenterButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - CHECK DATA:

    private func checkData() {
        if arrayLocationsRealm.isEmpty && arrayAircraftsRealm.isEmpty && arrayCanopiesRealm.isEmpty {
            tableView.isHidden = true
            firstMessageView.isHidden = false
            firstMessageLabel.isHidden = false
            startCenterConfettiLottie.isHidden = false
            mainStartLottie.isHidden = false
            startConfettiTopLottie.isHidden = false
            startConfettiCenterButton.isHidden = false
            mainShadowLottie.isHidden = true
            mainLottie.isHidden = true
            confettiLottie.isHidden = true
            confettiButton.isHidden = true
            accountButton.isHidden = true
            weatherButton.isHidden = true
            mapsButton.isHidden = true
            communityButton.isHidden = true
            calculatorButton.isHidden = true
            notesButton.isHidden = true
            emptySkydiverLottie.isHidden = true
            emptySkydiverButton.isHidden = true
            tabBarController?.tabBar.isHidden = true
        } else {
            firstMessageView.isHidden = true
            firstMessageLabel.isHidden = true
            startCenterConfettiLottie.isHidden = true
            mainStartLottie.isHidden = true
            startConfettiTopLottie.isHidden = true
            startConfettiCenterButton.isHidden = true
            mainShadowLottie.isHidden = false
            mainLottie.isHidden = false
            confettiLottie.isHidden = false
            confettiButton.isHidden = false
            accountButton.isHidden = false
            weatherButton.isHidden = false
            mapsButton.isHidden = false
            communityButton.isHidden = false
            calculatorButton.isHidden = false
            notesButton.isHidden = false
            checkJumps()
        }
    }
    
    // MARK: - CHECK JUMPS:
    
    private func checkJumps() {
        tabBarController?.tabBar.isHidden = false
        if arrayJumpsRealm.isEmpty {
            tableView.isHidden = true
            emptyConfettiLottie.isHidden = false
            emptyJumpsView.isHidden = false
            emptySkydiverLottie.isHidden = false
            emptySkydiverButton.isHidden = false
            emptyFlowersLottie.isHidden = false
        } else {
            tableView.isHidden = false
            emptyConfettiLottie.isHidden = true
            emptyJumpsView.isHidden = true
            emptySkydiverLottie.isHidden = true
            emptySkydiverButton.isHidden = true
            emptyFlowersLottie.isHidden = true
        }
    }

    // MARK: - SORT ARRAY:

    private func sortArray() {
        arrayJumpsRealm.sort { jump1, jump2 -> Bool in
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let date1 = dateFormatter.date(from: jump1.date), let date2 = dateFormatter.date(from: jump2.date) {
                return date1 < date2
            }
            return false
        }
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR PLAY CONFETTI + VIBRATION:

    @objc private func confettiButtonLongPress() {
        VibrationManager.instance.vibrationSucces()
        confettiLottie.play()
    }

    @objc private func startConfettiButtonTapped() {
        VibrationManager.instance.vibrationSucces()
        startCenterConfettiLottie.play()
    }

    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Jump deleted / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: ALERT KIT SAVE BUTTON SUCCESS:

    private func alertKitSaveButtonSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / alert kit", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }

    // MARK: - TRANSITIONS:

    // MARK: TRANSITION ON ACCOUNT VIEW CONTROLLER:

    @objc private func accountButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let accountVC = AccountVC()
        if let sheetController = accountVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(accountVC, animated: true)
    }

    // MARK: TRANSITION ON WEATHER VIEW CONTROLLER:

    @objc private func weatherButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let weatherViewController = WeatherVC()
        present(weatherViewController, animated: true)
    }

    // MARK: TRANSITION ON DROPZONES VIEW CONTROLLER:

    @objc private func dropzonesButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let dropzones = DropZonesVC()
        present(dropzones, animated: true)
    }

    // MARK: TRANSITION ON PARAMETERS VIEW CONTROLLER:

    @objc private func confettiButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let parametersVC = ParametersVC()
        if let sheetController = parametersVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.large()]
        }
        present(parametersVC, animated: true)
    }

    // MARK: TRANSITION ON SKYDIVERS VIEW CONTROLLER:

    @objc private func skydiversButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let skydivers = SkydiversVC()
        skydivers.isModalInPresentation = true
        present(skydivers, animated: true)
    }

    // MARK: TRANSITION ON CALCULATOR VIEW CONTROLLER:

    @objc private func calculatorButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let calculatorViewController = CalculatorVC()
        if let sheetController = calculatorViewController.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(calculatorViewController, animated: true)
    }

    // MARK: TRANSITION ON NOTES VIEW CONTROLLER:

    @objc private func notesButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let notesViewController = NotesVC()
        if let sheetController = notesViewController.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium(), .large()]
        }
        present(notesViewController, animated: true, completion: nil)
    }
    
    // MARK: SHOW ERROR FOR EMPTY FIELDS:
    
    private func showError(textField: UITextField) {
        textField.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            textField.backgroundColor = .colorTabBar
        }
        resignFirstResponders()
        actionButtonSaveRedColor()
        alertKitError()
    }
    
    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = .colorTabBar
        }
    }
    
    private func actionButtonSaveRedColor() {
        saveButton.backgroundColor = .colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = .colorTabBar
        }
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        firstLocationTextField.resignFirstResponder()
        firstAircraftTextField.resignFirstResponder()
        firstCanopyTextField.resignFirstResponder()
    }
    
    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc private func tapGestureDone() {
        view.endEditing(true)
    }
    
    // MARK: SAVE FIRST DATA:
    
    private func saveFirstData() {
        let newLocation = LocationClassRealm()
        newLocation.location = firstLocationTextField.text ?? ""
        try? realmManager.localRealm.write {
            self.realmManager.localRealm.add(newLocation, update: .all)
        }
        
        let newAircraft = AircraftClassRealm()
        newAircraft.aircraft = firstAircraftTextField.text ?? ""
        try? realmManager.localRealm.write {
            self.realmManager.localRealm.add(newAircraft, update: .all)
        }
        
        let newCanopy = CanopyClassRealm()
        newCanopy.canopy = firstCanopyTextField.text ?? ""
        try? realmManager.localRealm.write {
            self.realmManager.localRealm.add(newCanopy, update: .all)
        }
        actionButtonSaveGreenColor()
        alertKitSaveButtonSuccess()
        playSoundSucces()
        loadRealmData()
        checkData()
    }
    
    // MARK: LOAD REALM DATA:

    private func loadRealmData() {
        arrayJumpsRealm = realmManager.localRealm.objects(JumpClassRealm.self).map { $0 }
        arrayAccountRealm = realmManager.localRealm.objects(AccountClassRealm.self).map { $0 }
        arrayNotesRealm = realmManager.localRealm.objects(NoteClassRealm.self).map { $0 }
        arraySystemsRealm = realmManager.localRealm.objects(SystemClassRealm.self).map { $0 }
        arrayLocationsRealm = realmManager.localRealm.objects(LocationClassRealm.self).map { $0 }
        arrayAircraftsRealm = realmManager.localRealm.objects(AircraftClassRealm.self).map { $0 }
        arrayCanopiesRealm = realmManager.localRealm.objects(CanopyClassRealm.self).map { $0 }
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayJumpsRealm.count
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        let jump = arrayJumpsRealm[indexPath.row]
        cell.configure(number: String(arrayJumpsRealm.count - indexPath.row), date: jump.date, location: jump.location, aircraft: jump.aircraft, canopy: jump.canopy, mission: jump.mission?.localizedValue ?? "", height: jump.height, time: jump.time, cutaway: jump.cutaway?.localizedValue ?? "", comment: jump.comment)
        return cell
    }

    // MARK: TRANSSITION ON SELECTED JUMP:

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
        let jump = arrayJumpsRealm[indexPath.row]
        let jumpViewController = JumpVC(selectedJump: jump)
        selectedJump = jump
        jumpViewController.jumpNumber = arrayJumpsRealm.count - indexPath.row
        let navigationController = UINavigationController(rootViewController: jumpViewController)
        navigationController.sheetPresentationController?.prefersGrabberVisible = true
        present(navigationController, animated: true, completion: nil)
    }

    // MARK: COSTUM SWIPE RIGHT (DELETE AND EDIT):

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        VibrationManager.instance.vibrationStandart()

        // MARK: DELETE JUMP:

        let deleteJump = arrayJumpsRealm[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete jump?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                try? self.realmManager.localRealm.write {
                    self.realmManager.localRealm.delete(deleteJump)
                }
                self.loadJumps()
                tableView.reloadData()
                self.sortArray()
                arrayJumpsRealm.reverse()
                self.checkData()
                self.alertKitSuccess()
            }))
            self.present(alertDelete, animated: true)
            completion(true)
        }
        if let trashImage = UIImage(systemName: "trash")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) {
            deleteAction.image = trashImage
        }
        deleteAction.backgroundColor = .colorBackground

        // MARK: EDIT JUMP:

        let editAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            let editJumpViewController = EditJumpVC()
            editJumpViewController.indexPath = indexPath.row
            self.navigationController?.pushViewController(editJumpViewController, animated: true)
            completion(true)
        }
        if let editImage = UIImage(systemName: "slider.horizontal.2.square")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal) {
            editAction.image = editImage
        }
        editAction.backgroundColor = .colorBackground
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return configuration
    }

    // MARK: COSTUM SWIPE LEFT (SHARE WITH JUMP:

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        VibrationManager.instance.vibrationStandart()
        let shareAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            VibrationManager.instance.vibrationStandart()
            let jump = arrayJumpsRealm[indexPath.row]
            let missionValue = jump.mission?.localizedValue ?? "-"
            let cutawayValue = jump.cutaway?.localizedValue ?? ""
            let jumpNumber = arrayJumpsRealm.count - indexPath.row

            let skydiver = realmManager.localRealm.objects(AccountClassRealm.self)
            let nicknameValue = skydiver.first?.nickname ?? ""

            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let formattedDate = dateFormatter.string(from: date)

            let text = """
            # \(jumpNumber)/\(arrayJumpsRealm.count):
            \(NSLocalizedString("Date", comment: "")): \(jump.date).
            \(NSLocalizedString("Location", comment: "")): \(jump.location).
            \(NSLocalizedString("Aircraft", comment: "")): \(jump.aircraft).
            \(NSLocalizedString("Canopy", comment: "")): \(jump.canopy).
            \(NSLocalizedString("Mission", comment: "")): \(missionValue).
            \(NSLocalizedString("Height", comment: "")): \(jump.height).
            \(NSLocalizedString("Time", comment: "")): \(jump.time).
            \(NSLocalizedString("Cutaway", comment: "")): \(cutawayValue).
            \(NSLocalizedString("Comment", comment: "")): \(jump.comment).

            Skydive Book iOS Application, \(formattedDate).
            \(nicknameValue)
            """
            let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            present(activityViewController, animated: true)
            completion(true)
        }
        if let editImage = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal) {
            shareAction.image = editImage
        }
        shareAction.backgroundColor = .colorBackground
        let configuration = UISwipeActionsConfiguration(actions: [shareAction])
        return configuration
    }
}
