import AlertKit
import AudioToolbox
import AVFoundation
import Lottie
import RealmSwift
import UIKit

final class MainVC: UIViewController {
    // MARK: - PROPERTIES:

    private let loadingView = UIView()
    private let loadingLottie = LottieAnimationView(name: "Loading")
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
    private let sliderButton = UISlider()

    private let dateFormatter = DateFormatter()
    private let vibrationOn = Vibration()
    private var selectedJump: JumpClassRealm?
    private let realmManager = RealmManager()
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
        firstMessage()
        tableView.reloadData()
        sortArray()
        arrayJumpsRealm.reverse()
        startConfigureGestures()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(mainShadowLottie, mainLottie, confettiLottie, confettiButton, accountButton, weatherButton, mapsButton, communityButton, calculatorButton, notesButton, tableView, startCenterConfettiLottie, startConfettiTopLottie, firstMessageView, firstMessageLabel, mainStartLottie, startConfettiCenterButton, loadingView)
        loadingView.addSubview(loadingLottie)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: LOADING VIEW:

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // MARK: LOADING LOTTIE:

        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingLottie.topAnchor.constraint(equalTo: loadingView.topAnchor).isActive = true
        loadingLottie.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor).isActive = true
        loadingLottie.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor).isActive = true
        loadingLottie.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor).isActive = true
        
        // MARK: MAIN SHADOW LOTTIE:
        
        mainShadowLottie.translatesAutoresizingMaskIntoConstraints = false
        mainShadowLottie.centerXAnchor.constraint(equalTo: mainLottie.centerXAnchor).isActive = true
        mainShadowLottie.centerYAnchor.constraint(equalTo: mainLottie.centerYAnchor, constant: 10).isActive = true
        mainShadowLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true

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
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: LOADING VIEW:

        loadingView.backgroundColor = .colorBackground

        // MARK: LOADING LOTTIE:

        loadingLottie.play()
        loadingLottie.loopMode = .loop
        loadingLottie.contentMode = .center
        loadingLottie.layer.shadowRadius = 100
        loadingLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        loadingLottie.layer.shadowOpacity = 0.5
        perform(#selector(hideAnimation), with: nil, afterDelay: 2)

        // MARK: CONFETTI LOTTIE:

        confettiLottie.layer.shadowRadius = 15
        confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
        confettiLottie.layer.shadowOpacity = 1
        
        // MARK: MAIN SHADOW LOTTIE:
        
        mainShadowLottie.play()
        mainShadowLottie.loopMode = .loop
        mainShadowLottie.layer.opacity = 0.2
        mainShadowLottie.animationSpeed = 0.2

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

        // MARK: TAB BAR CONTROLLER:

        tabBarController?.tabBar.isHidden = true

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
    }
    
    private func startConfigureGestures() {
        // MARK: THREE TAP FOR PLAY ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(startConfettiButtonTapped))
        confettiGesture.numberOfTapsRequired = 3
        startConfettiCenterButton.addGestureRecognizer(confettiGesture)
    }

    // MARK: - FIRST MESSAGE:

    private func firstMessage() {
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
        
        // MARK: START LOTTIE CENTER CONFETTI:
        
        startCenterConfettiLottie.translatesAutoresizingMaskIntoConstraints = false
        startCenterConfettiLottie.centerXAnchor.constraint(equalTo: mainStartLottie.centerXAnchor).isActive = true
        startCenterConfettiLottie.centerYAnchor.constraint(equalTo: mainStartLottie.centerYAnchor).isActive = true
        startCenterConfettiLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true

        // MARK: ANIMATION MAIN LOTTIE:

        mainStartLottie.translatesAutoresizingMaskIntoConstraints = false
        mainStartLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainStartLottie.bottomAnchor.constraint(equalTo: firstMessageView.topAnchor, constant: -30).isActive = true
        mainStartLottie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        mainStartLottie.widthAnchor.constraint(equalToConstant: 150).isActive = true

        // MARK: FIRST MESSAGE VIEW:

        firstMessageView.translatesAutoresizingMaskIntoConstraints = false
        firstMessageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstMessageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        firstMessageView.heightAnchor.constraint(greaterThanOrEqualTo: firstMessageLabel.heightAnchor, constant: 10).isActive = true
        firstMessageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        firstMessageView.backgroundColor = .colorCell
        firstMessageView.layer.cornerRadius = cornerRadius15
        firstMessageView.layer.shadowRadius = 100
        firstMessageView.layer.shadowColor = UIColor.colorLightBlue.cgColor
        firstMessageView.layer.shadowOpacity = 0.5

        // MARK: FIRST MESSAGE LABEL:

        firstMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        firstMessageLabel.centerXAnchor.constraint(equalTo: firstMessageView.centerXAnchor).isActive = true
        firstMessageLabel.centerYAnchor.constraint(equalTo: firstMessageView.centerYAnchor).isActive = true
        firstMessageLabel.leadingAnchor.constraint(equalTo: firstMessageView.leadingAnchor, constant: 10).isActive = true
        firstMessageLabel.trailingAnchor.constraint(equalTo: firstMessageView.trailingAnchor, constant: -10).isActive = true

        firstMessageLabel.textColor = .colorWhite
        firstMessageLabel.font = fontRegularStandard12
        firstMessageLabel.numberOfLines = 0
        firstMessageLabel.textAlignment = .center
        firstMessageLabel.adjustsFontSizeToFitWidth = true
        firstMessageLabel.text = NSLocalizedString("First Message", comment: "")
        
        // MARK: START CONFETTI LOTTIE TOP:
        
        startConfettiTopLottie.translatesAutoresizingMaskIntoConstraints = false
        startConfettiTopLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        startConfettiTopLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        startConfettiTopLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        startConfettiTopLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // MARK: START CONFETTI CENTER BUTTON:
        
        startConfettiCenterButton.translatesAutoresizingMaskIntoConstraints = false
        startConfettiCenterButton.centerXAnchor.constraint(equalTo: mainStartLottie.centerXAnchor).isActive = true
        startConfettiCenterButton.centerYAnchor.constraint(equalTo: mainStartLottie.centerYAnchor).isActive = true
        startConfettiCenterButton.heightAnchor.constraint(equalTo: mainStartLottie.heightAnchor, multiplier: 1).isActive = true
        startConfettiCenterButton.widthAnchor.constraint(equalTo: mainStartLottie.widthAnchor, multiplier: 1).isActive = true

        if arrayJumpsRealm.count == 0 {
            firstMessageView.isHidden = false
            firstMessageLabel.isHidden = false
            startCenterConfettiLottie.isHidden = false
            mainStartLottie.isHidden = false
            startConfettiTopLottie.isHidden = false
            startConfettiCenterButton.isHidden = false
            mainStartLottie.play()
            mainStartLottie.loopMode = .autoReverse
            startConfettiTopLottie.play()
            startConfettiTopLottie.loopMode = .loop
            startConfettiTopLottie.contentMode = .scaleAspectFill
            startConfettiTopLottie.animationSpeed = 0.5
            startCenterConfettiLottie.layer.shadowRadius = 15
            startCenterConfettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
            startCenterConfettiLottie.layer.shadowOpacity = 1
        } else {
            startCenterConfettiLottie.isHidden = true
            mainStartLottie.isHidden = true
            startConfettiCenterButton.isHidden = true
            firstMessageView.isHidden = true
            firstMessageLabel.isHidden = true
            startConfettiTopLottie.isHidden = true

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

    // MARK: CHECK AGREE USE STATUS FROM USER:

    private func checkAgree() {
        if !UserDefaults.standard.bool(forKey: "hasShownStartAlert") {
            showStartAlert()
        }
    }

    // MARK: SHOW START ALERT:

    private func showStartAlert() {
        let alert = UIAlertController(title: "SkydiveBook", message: NSLocalizedString("", comment: ""), preferredStyle: .alert)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        let scrollView = UIScrollView()
        let messageLabel = UILabel()
        let agreeAction = UIAlertAction(title: NSLocalizedString("Agree", comment: ""), style: .default) { _ in
            UserDefaults.standard.set(true, forKey: "hasShownStartAlert")
        }
        alert.view.addSubviews(containerView)
        containerView.addSubviews(scrollView)
        scrollView.addSubviews(messageLabel, sliderButton)
        alert.addAction(agreeAction)
        agreeAction.isEnabled = false

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: alert.view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50).isActive = true
        containerView.heightAnchor.constraint(equalTo: alert.view.widthAnchor, multiplier: 0.8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: alert.view.widthAnchor, multiplier: 1).isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5).isActive = true
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .colorAlert

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        messageLabel.text = NSLocalizedString("Info text start alert", comment: "")
        messageLabel.font = fontRegularStandard8
        messageLabel.textAlignment = .center
        messageLabel.textColor = .colorStartAlert
        messageLabel.numberOfLines = 0
        
        sliderButton.translatesAutoresizingMaskIntoConstraints = false
        sliderButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10).isActive = true
        sliderButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sliderButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -5).isActive = true
        sliderButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.6).isActive = true
        sliderButton.layer.masksToBounds = true
        sliderButton.backgroundColor = .systemRed
        sliderButton.layer.cornerRadius = cornerRadius15
        sliderButton.minimumTrackTintColor = UIColor.clear
        sliderButton.maximumTrackTintColor = UIColor.clear
        sliderButton.thumbTintColor = UIColor.white
        sliderButton.minimumValue = 0
        sliderButton.maximumValue = 100
        if let sliderImage = UIImage(systemName: "arrowshape.right.circle.fill", withConfiguration: configurationImage) {
            let coloredSliderImage = sliderImage.withTintColor(.white, renderingMode: .alwaysOriginal)
            sliderButton.setThumbImage(coloredSliderImage, for: .normal)
            sliderButton.setThumbImage(coloredSliderImage, for: .highlighted)
        }

        sliderButton.addAction(UIAction(handler: { _ in
            self.vibrationOn.vibrationLight()
            if self.sliderButton.value >= 99.5, self.sliderButton.value <= 100.5 {
                agreeAction.isEnabled = true
                self.sliderButton.backgroundColor = .systemGreen
                if let sliderFinishImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: self.configurationImage) {
                    let coloredSliderImage = sliderFinishImage.withTintColor(.white, renderingMode: .alwaysOriginal)
                    self.sliderButton.setThumbImage(coloredSliderImage, for: .normal)
                }
            } else {
                agreeAction.isEnabled = false
                self.sliderButton.backgroundColor = .systemRed
                if let sliderImage = UIImage(systemName: "arrowshape.right.circle.fill", withConfiguration: self.configurationImage) {
                    let coloredSliderImage = sliderImage.withTintColor(.white, renderingMode: .alwaysOriginal)
                    self.sliderButton.setThumbImage(coloredSliderImage, for: .normal)
                    self.sliderButton.setThumbImage(coloredSliderImage, for: .highlighted)
                }
            }
        }), for: .valueChanged)
        present(alert, animated: true)
    }

    // MARK: FUNC FOR PLAY CONFETTI + VIBRATION:

    @objc private func confettiButtonLongPress() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
        
    @objc private func startConfettiButtonTapped() {
        vibrationOn.vibrationSucces()
        startCenterConfettiLottie.play()
    }

    // MARK: FUNC FOR CLOSED LOADING LOTTIE:

    @objc private func hideAnimation() {
        tableView.isHidden = false
        tabBarController?.tabBar.isHidden = false
        checkAgree()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0.0
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
        loadingLottie.removeFromSuperview()
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
    
    // MARK: - TRANSITIONS:
    
    // MARK: TRANSITION ON ACCOUNT VIEW CONTROLLER:

    @objc private func accountButtonTapped() {
        vibrationOn.vibrationStandart()
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
        vibrationOn.vibrationStandart()
        let weatherViewController = WeatherVC()
        present(weatherViewController, animated: true)
    }

    // MARK: TRANSITION ON DROPZONES VIEW CONTROLLER:

    @objc private func dropzonesButtonTapped() {
        vibrationOn.vibrationStandart()
        let dropzones = DropZonesVC()
        present(dropzones, animated: true)
    }
    
    // MARK: TRANSITION ON PARAMETERS VIEW CONTROLLER:
    
    @objc private func confettiButtonTapped() {
        self.vibrationOn.vibrationStandart()
        let parametersVC = ParametersVC()
        if let sheetController = parametersVC.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.large()]
        }
        self.present(parametersVC, animated: true)
    }

    // MARK: TRANSITION ON SKYDIVERS VIEW CONTROLLER:

    @objc private func skydiversButtonTapped() {
        vibrationOn.vibrationStandart()
        let skydivers = SkydiversVC()
        skydivers.isModalInPresentation = true
        present(skydivers, animated: true)
    }

    // MARK: TRANSITION ON CALCULATOR VIEW CONTROLLER:

    @objc private func calculatorButtonTapped() {
        vibrationOn.vibrationStandart()
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
        vibrationOn.vibrationStandart()
        let notesViewController = NotesVC()
        if let sheetController = notesViewController.sheetPresentationController {
            sheetController.prefersGrabberVisible = true
            sheetController.preferredCornerRadius = 100
            sheetController.detents = [.medium()]
        }
        present(notesViewController, animated: true, completion: nil)
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
        vibrationOn.vibrationStandart()
        let jump = arrayJumpsRealm[indexPath.row]
        let jumpViewController = JumpVC(selectedJump: jump)
        selectedJump = jump
        jumpViewController.jumpNumber = arrayJumpsRealm.count - indexPath.row
        let navigationController = UINavigationController(rootViewController: jumpViewController)
        present(navigationController, animated: true, completion: nil)
    }

    // MARK: COSTUM SWIPE RIGHT (DELETE AND EDIT):

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: DELETE JUMP:

        vibrationOn.vibrationStandart()
        let deleteJump = arrayJumpsRealm[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            self.vibrationOn.vibrationStandart()
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
                self.firstMessage()
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
            self.vibrationOn.vibrationStandart()
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
}
