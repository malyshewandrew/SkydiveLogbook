import Lottie
import NotificationCenter
import UIKit
import Lottie

final class NotificationsVS: UIViewController {
    // MARK: - PRIVATE PROPERTIES:
    
    private let notificationsBackgroundLottie = LottieAnimationView(name: "NotificationsBackgroundLottie")
    private let notificationsLogoLottie = LottieAnimationView(name: "NotificationsLogoLottie")
    private let scrollView = UIScrollView()
    
    private let mainView = UIView()
    private let mainImageView = UIImageView()
    private let mainLabel = UILabel()
    private let mainSwitch = UISwitch()
    
    private let firstContentView = UIView()
    
    private let monthlyView = UIView()
    private let monthlyImageView = UIImageView()
    private let monthlyLabel = UILabel()
    private let monthlySwitch = UISwitch()
    
    private let secondContentView = UIView()
    
    private let containerView = UIView()
    private let containerImageView = UIImageView()
    private let containerLabel = UILabel()
    private let containerSwitch = UISwitch()
    
    private let lineOneView = UIView()
    
    private let aadView = UIView()
    private let aadImageView = UIImageView()
    private let aadLabel = UILabel()
    private let aadSwitch = UISwitch()
    
    private let lineTwoView = UIView()
    
    private let mainCanopyResourseView = UIView()
    private let mainCanopyResourseImageView = UIImageView()
    private let mainCanopyResourseLabel = UILabel()
    private let mainCanopyResourseSwitch = UISwitch()
    
    private let lineThreeView = UIView()
    
    private let reserveCanopyResourseView = UIView()
    private let reserveCanopyResourseImageView = UIImageView()
    private let reserveCanopyResourseLabel = UILabel()
    private let reserveCanopyResourseSwitch = UISwitch()
    
    private let threeContentView = UIView()
    
    private let mainCanopyJumpsView = UIView()
    private let mainCanopyJumpsImageView = UIImageView()
    private let mainCanopyJumpsLabel = UILabel()
    private let mainCanopyJumpsSwitch = UISwitch()
    
    private let lineFourView = UIView()
    
    private let reserveCanopyRepackView = UIView()
    private let reserveCanopyRepackImageView = UIImageView()
    private let reserveCanopyRepackLabel = UILabel()
    private let reserveCanopyRepackSwitch = UISwitch()
    
    private let fourContentView = UIView()
    
    private let licenseView = UIView()
    private let licenseImageView = UIImageView()
    private let licenseLabel = UILabel()
    private let licenseSwitch = UISwitch()
    
    private let lineFiveView = UIView()
    
    private let medicineView = UIView()
    private let medicineImageView = UIImageView()
    private let medicineLabel = UILabel()
    private let medicineSwitch = UISwitch()
    
    private let lineSixView = UIView()
    
    private let insuranceView = UIView()
    private let insuranceImageView = UIImageView()
    private let insuranceLabel = UILabel()
    private let insuranceSwitch = UISwitch()
    
    private let vibrationOn = Vibration()
    private let notificationCenter = UNUserNotificationCenter.current()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 22)

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        sendRequest()
        addSubviews()
        configureConstrains()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserDefaults()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(notificationsBackgroundLottie, notificationsLogoLottie, scrollView)
        
        scrollView.addSubviews(mainView, firstContentView, secondContentView, threeContentView, fourContentView)
        
        mainView.addSubviews(mainImageView, mainLabel, mainSwitch)
        
        firstContentView.addSubviews(monthlyView)
        monthlyView.addSubviews(monthlyImageView, monthlyLabel, monthlySwitch)
        
        secondContentView.addSubviews(containerView, lineOneView, aadView, lineTwoView, mainCanopyResourseView, lineThreeView, reserveCanopyResourseView)
        containerView.addSubviews(containerImageView, containerLabel, containerSwitch)
        aadView.addSubviews(aadImageView, aadLabel, aadSwitch)
        mainCanopyResourseView.addSubviews(mainCanopyResourseImageView, mainCanopyResourseLabel, mainCanopyResourseSwitch)
        reserveCanopyResourseView.addSubviews(reserveCanopyResourseImageView, reserveCanopyResourseLabel, reserveCanopyResourseSwitch)
        
        threeContentView.addSubviews(mainCanopyJumpsView, lineFourView, reserveCanopyRepackView)
        mainCanopyJumpsView.addSubviews(mainCanopyJumpsImageView, mainCanopyJumpsSwitch, mainCanopyJumpsLabel)
        reserveCanopyRepackView.addSubviews(reserveCanopyRepackImageView, reserveCanopyRepackSwitch, reserveCanopyRepackLabel)
        
        fourContentView.addSubviews(licenseView, lineFiveView, medicineView, insuranceView, lineSixView)
        licenseView.addSubviews(licenseImageView, licenseLabel, licenseSwitch)
        medicineView.addSubviews(medicineImageView, medicineLabel, medicineSwitch)
        insuranceView.addSubviews(insuranceImageView, insuranceLabel, insuranceSwitch)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: NOTIFICATIONS BACKGROUND:

        notificationsBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        notificationsBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        notificationsBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notificationsBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notificationsBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // MARK: NOTIFICATIONS LOGO:
        
        notificationsLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        notificationsLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        notificationsLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notificationsLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: SCROLL VIEW:
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: notificationsLogoLottie.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: MAIN:
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        mainImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15).isActive = true
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10).isActive = true
        
        mainSwitch.translatesAutoresizingMaskIntoConstraints = false
        mainSwitch.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        mainSwitch.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: FIRST CONTENT VIEW:
        
        firstContentView.translatesAutoresizingMaskIntoConstraints = false
        firstContentView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 15).isActive = true
        firstContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstContentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        firstContentView.bottomAnchor.constraint(equalTo: monthlyView.bottomAnchor).isActive = true
        
        // MARK: MONTHLY:
        
        monthlyView.translatesAutoresizingMaskIntoConstraints = false
        monthlyView.topAnchor.constraint(equalTo: firstContentView.topAnchor, constant: 0).isActive = true
        monthlyView.centerXAnchor.constraint(equalTo: firstContentView.centerXAnchor).isActive = true
        monthlyView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        monthlyView.widthAnchor.constraint(equalTo: firstContentView.widthAnchor, multiplier: 1).isActive = true
        
        monthlyImageView.translatesAutoresizingMaskIntoConstraints = false
        monthlyImageView.centerYAnchor.constraint(equalTo: monthlyView.centerYAnchor).isActive = true
        monthlyImageView.leadingAnchor.constraint(equalTo: monthlyView.leadingAnchor, constant: 15).isActive = true
        
        monthlyLabel.translatesAutoresizingMaskIntoConstraints = false
        monthlyLabel.centerYAnchor.constraint(equalTo: monthlyView.centerYAnchor).isActive = true
        monthlyLabel.leadingAnchor.constraint(equalTo: monthlyImageView.trailingAnchor, constant: 10).isActive = true
        
        monthlySwitch.translatesAutoresizingMaskIntoConstraints = false
        monthlySwitch.centerYAnchor.constraint(equalTo: monthlyView.centerYAnchor).isActive = true
        monthlySwitch.trailingAnchor.constraint(equalTo: monthlyView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: SECOND CONTENT VIEW:
        
        secondContentView.translatesAutoresizingMaskIntoConstraints = false
        secondContentView.topAnchor.constraint(equalTo: firstContentView.bottomAnchor, constant: 15).isActive = true
        secondContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondContentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        secondContentView.bottomAnchor.constraint(equalTo: reserveCanopyResourseView.bottomAnchor).isActive = true
        
        // MARK: CONTAINER:
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: secondContentView.topAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: secondContentView.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        containerView.widthAnchor.constraint(equalTo: secondContentView.widthAnchor, multiplier: 1).isActive = true
        
        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        containerImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        containerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        
        containerLabel.translatesAutoresizingMaskIntoConstraints = false
        containerLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        containerLabel.leadingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: 10).isActive = true
        
        containerSwitch.translatesAutoresizingMaskIntoConstraints = false
        containerSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        containerSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: LINE 1:
        
        lineOneView.translatesAutoresizingMaskIntoConstraints = false
        lineOneView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 2).isActive = true
        lineOneView.trailingAnchor.constraint(equalTo: secondContentView.trailingAnchor).isActive = true
        lineOneView.leadingAnchor.constraint(equalTo: containerLabel.leadingAnchor).isActive = true
        lineOneView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: AAD:
        
        aadView.translatesAutoresizingMaskIntoConstraints = false
        aadView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 4).isActive = true
        aadView.centerXAnchor.constraint(equalTo: secondContentView.centerXAnchor).isActive = true
        aadView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        aadView.widthAnchor.constraint(equalTo: secondContentView.widthAnchor, multiplier: 1).isActive = true
        
        aadImageView.translatesAutoresizingMaskIntoConstraints = false
        aadImageView.centerYAnchor.constraint(equalTo: aadView.centerYAnchor).isActive = true
        aadImageView.leadingAnchor.constraint(equalTo: aadView.leadingAnchor, constant: 15).isActive = true
        
        aadLabel.translatesAutoresizingMaskIntoConstraints = false
        aadLabel.centerYAnchor.constraint(equalTo: aadView.centerYAnchor).isActive = true
        aadLabel.leadingAnchor.constraint(equalTo: aadImageView.trailingAnchor, constant: 10).isActive = true
        
        aadSwitch.translatesAutoresizingMaskIntoConstraints = false
        aadSwitch.centerYAnchor.constraint(equalTo: aadView.centerYAnchor).isActive = true
        aadSwitch.trailingAnchor.constraint(equalTo: aadView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: LINE 2:
        
        lineTwoView.translatesAutoresizingMaskIntoConstraints = false
        lineTwoView.topAnchor.constraint(equalTo: aadView.bottomAnchor, constant: 2).isActive = true
        lineTwoView.trailingAnchor.constraint(equalTo: secondContentView.trailingAnchor).isActive = true
        lineTwoView.leadingAnchor.constraint(equalTo: aadLabel.leadingAnchor).isActive = true
        lineTwoView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: MAIN CANOPY RESOURSE:
        
        mainCanopyResourseView.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyResourseView.topAnchor.constraint(equalTo: aadView.bottomAnchor, constant: 4).isActive = true
        mainCanopyResourseView.centerXAnchor.constraint(equalTo: secondContentView.centerXAnchor).isActive = true
        mainCanopyResourseView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        mainCanopyResourseView.widthAnchor.constraint(equalTo: secondContentView.widthAnchor, multiplier: 1).isActive = true
        
        mainCanopyResourseImageView.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyResourseImageView.centerYAnchor.constraint(equalTo: mainCanopyResourseView.centerYAnchor).isActive = true
        mainCanopyResourseImageView.leadingAnchor.constraint(equalTo: mainCanopyResourseView.leadingAnchor, constant: 15).isActive = true
        
        mainCanopyResourseLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyResourseLabel.centerYAnchor.constraint(equalTo: mainCanopyResourseView.centerYAnchor).isActive = true
        mainCanopyResourseLabel.leadingAnchor.constraint(equalTo: mainCanopyResourseImageView.trailingAnchor, constant: 10).isActive = true
        
        mainCanopyResourseSwitch.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyResourseSwitch.centerYAnchor.constraint(equalTo: mainCanopyResourseView.centerYAnchor).isActive = true
        mainCanopyResourseSwitch.trailingAnchor.constraint(equalTo: mainCanopyResourseView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: LINE 3:
        
        lineThreeView.translatesAutoresizingMaskIntoConstraints = false
        lineThreeView.topAnchor.constraint(equalTo: mainCanopyResourseView.bottomAnchor, constant: 2).isActive = true
        lineThreeView.trailingAnchor.constraint(equalTo: secondContentView.trailingAnchor).isActive = true
        lineThreeView.leadingAnchor.constraint(equalTo: mainCanopyResourseLabel.leadingAnchor).isActive = true
        lineThreeView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: RESERVE CANOPY RESOURSE:
        
        reserveCanopyResourseView.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyResourseView.topAnchor.constraint(equalTo: mainCanopyResourseView.bottomAnchor, constant: 4).isActive = true
        reserveCanopyResourseView.centerXAnchor.constraint(equalTo: secondContentView.centerXAnchor).isActive = true
        reserveCanopyResourseView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        reserveCanopyResourseView.widthAnchor.constraint(equalTo: secondContentView.widthAnchor, multiplier: 1).isActive = true
        
        reserveCanopyResourseImageView.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyResourseImageView.centerYAnchor.constraint(equalTo: reserveCanopyResourseView.centerYAnchor).isActive = true
        reserveCanopyResourseImageView.leadingAnchor.constraint(equalTo: reserveCanopyResourseView.leadingAnchor, constant: 15).isActive = true
        
        reserveCanopyResourseLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyResourseLabel.centerYAnchor.constraint(equalTo: reserveCanopyResourseView.centerYAnchor).isActive = true
        reserveCanopyResourseLabel.leadingAnchor.constraint(equalTo: reserveCanopyResourseImageView.trailingAnchor, constant: 10).isActive = true
        
        reserveCanopyResourseSwitch.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyResourseSwitch.centerYAnchor.constraint(equalTo: reserveCanopyResourseView.centerYAnchor).isActive = true
        reserveCanopyResourseSwitch.trailingAnchor.constraint(equalTo: reserveCanopyResourseView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: THREE CONTENT VIEW:
        
        threeContentView.translatesAutoresizingMaskIntoConstraints = false
        threeContentView.topAnchor.constraint(equalTo: secondContentView.bottomAnchor, constant: 15).isActive = true
        threeContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        threeContentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        threeContentView.bottomAnchor.constraint(equalTo: reserveCanopyRepackView.bottomAnchor).isActive = true
        
        // MARK: MAIN CANOPY JUMPS:
        
        mainCanopyJumpsView.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyJumpsView.topAnchor.constraint(equalTo: threeContentView.topAnchor).isActive = true
        mainCanopyJumpsView.centerXAnchor.constraint(equalTo: threeContentView.centerXAnchor).isActive = true
        mainCanopyJumpsView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        mainCanopyJumpsView.widthAnchor.constraint(equalTo: threeContentView.widthAnchor, multiplier: 1).isActive = true
        
        mainCanopyJumpsImageView.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyJumpsImageView.centerYAnchor.constraint(equalTo: mainCanopyJumpsView.centerYAnchor).isActive = true
        mainCanopyJumpsImageView.leadingAnchor.constraint(equalTo: mainCanopyJumpsView.leadingAnchor, constant: 15).isActive = true
        
        mainCanopyJumpsLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyJumpsLabel.centerYAnchor.constraint(equalTo: mainCanopyJumpsView.centerYAnchor).isActive = true
        mainCanopyJumpsLabel.leadingAnchor.constraint(equalTo: mainCanopyJumpsImageView.trailingAnchor, constant: 10).isActive = true
        
        mainCanopyJumpsSwitch.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyJumpsSwitch.centerYAnchor.constraint(equalTo: mainCanopyJumpsView.centerYAnchor).isActive = true
        mainCanopyJumpsSwitch.trailingAnchor.constraint(equalTo: mainCanopyJumpsView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: LINE 4:
        
        lineFourView.translatesAutoresizingMaskIntoConstraints = false
        lineFourView.topAnchor.constraint(equalTo: mainCanopyJumpsView.bottomAnchor, constant: 2).isActive = true
        lineFourView.trailingAnchor.constraint(equalTo: threeContentView.trailingAnchor).isActive = true
        lineFourView.leadingAnchor.constraint(equalTo: mainCanopyJumpsLabel.leadingAnchor).isActive = true
        lineFourView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: RESERVE CANOPY REPACK:
        
        reserveCanopyRepackView.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyRepackView.topAnchor.constraint(equalTo: mainCanopyJumpsView.bottomAnchor, constant: 4).isActive = true
        reserveCanopyRepackView.centerXAnchor.constraint(equalTo: threeContentView.centerXAnchor).isActive = true
        reserveCanopyRepackView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        reserveCanopyRepackView.widthAnchor.constraint(equalTo: threeContentView.widthAnchor, multiplier: 1).isActive = true
        
        reserveCanopyRepackImageView.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyRepackImageView.centerYAnchor.constraint(equalTo: reserveCanopyRepackView.centerYAnchor).isActive = true
        reserveCanopyRepackImageView.leadingAnchor.constraint(equalTo: reserveCanopyRepackView.leadingAnchor, constant: 15).isActive = true
        
        reserveCanopyRepackLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyRepackLabel.centerYAnchor.constraint(equalTo: reserveCanopyRepackView.centerYAnchor).isActive = true
        reserveCanopyRepackLabel.leadingAnchor.constraint(equalTo: reserveCanopyRepackImageView.trailingAnchor, constant: 10).isActive = true
        
        reserveCanopyRepackSwitch.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyRepackSwitch.centerYAnchor.constraint(equalTo: reserveCanopyRepackView.centerYAnchor).isActive = true
        reserveCanopyRepackSwitch.trailingAnchor.constraint(equalTo: reserveCanopyRepackView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: FOUR CONTENT VIEW:
        
        fourContentView.translatesAutoresizingMaskIntoConstraints = false
        fourContentView.topAnchor.constraint(equalTo: threeContentView.bottomAnchor, constant: 15).isActive = true
        fourContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fourContentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        fourContentView.bottomAnchor.constraint(equalTo: insuranceView.bottomAnchor).isActive = true
        
        // MARK: LICENSE:
        
        licenseView.translatesAutoresizingMaskIntoConstraints = false
        licenseView.topAnchor.constraint(equalTo: fourContentView.topAnchor).isActive = true
        licenseView.centerXAnchor.constraint(equalTo: fourContentView.centerXAnchor).isActive = true
        licenseView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        licenseView.widthAnchor.constraint(equalTo: fourContentView.widthAnchor, multiplier: 1).isActive = true
        
        licenseImageView.translatesAutoresizingMaskIntoConstraints = false
        licenseImageView.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseImageView.leadingAnchor.constraint(equalTo: licenseView.leadingAnchor, constant: 15).isActive = true
        
        licenseLabel.translatesAutoresizingMaskIntoConstraints = false
        licenseLabel.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseLabel.leadingAnchor.constraint(equalTo: licenseImageView.trailingAnchor, constant: 10).isActive = true
        
        licenseSwitch.translatesAutoresizingMaskIntoConstraints = false
        licenseSwitch.centerYAnchor.constraint(equalTo: licenseView.centerYAnchor).isActive = true
        licenseSwitch.trailingAnchor.constraint(equalTo: licenseView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: LINE 5:
        
        lineFiveView.translatesAutoresizingMaskIntoConstraints = false
        lineFiveView.topAnchor.constraint(equalTo: licenseView.bottomAnchor, constant: 2).isActive = true
        lineFiveView.trailingAnchor.constraint(equalTo: fourContentView.trailingAnchor).isActive = true
        lineFiveView.leadingAnchor.constraint(equalTo: licenseLabel.leadingAnchor).isActive = true
        lineFiveView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: MEDICINE:
        
        medicineView.translatesAutoresizingMaskIntoConstraints = false
        medicineView.topAnchor.constraint(equalTo: licenseView.bottomAnchor, constant: 4).isActive = true
        medicineView.centerXAnchor.constraint(equalTo: fourContentView.centerXAnchor).isActive = true
        medicineView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        medicineView.widthAnchor.constraint(equalTo: fourContentView.widthAnchor, multiplier: 1).isActive = true
        
        medicineImageView.translatesAutoresizingMaskIntoConstraints = false
        medicineImageView.centerYAnchor.constraint(equalTo: medicineView.centerYAnchor).isActive = true
        medicineImageView.leadingAnchor.constraint(equalTo: medicineView.leadingAnchor, constant: 15).isActive = true
        
        medicineLabel.translatesAutoresizingMaskIntoConstraints = false
        medicineLabel.centerYAnchor.constraint(equalTo: medicineView.centerYAnchor).isActive = true
        medicineLabel.leadingAnchor.constraint(equalTo: medicineImageView.trailingAnchor, constant: 10).isActive = true
        
        medicineSwitch.translatesAutoresizingMaskIntoConstraints = false
        medicineSwitch.centerYAnchor.constraint(equalTo: medicineView.centerYAnchor).isActive = true
        medicineSwitch.trailingAnchor.constraint(equalTo: medicineView.trailingAnchor, constant: -15).isActive = true
        
        // MARK: LINE 6:
        
        lineSixView.translatesAutoresizingMaskIntoConstraints = false
        lineSixView.topAnchor.constraint(equalTo: medicineView.bottomAnchor, constant: 2).isActive = true
        lineSixView.trailingAnchor.constraint(equalTo: fourContentView.trailingAnchor).isActive = true
        lineSixView.leadingAnchor.constraint(equalTo: medicineLabel.leadingAnchor).isActive = true
        lineSixView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // MARK: INSURANCE:
        
        insuranceView.translatesAutoresizingMaskIntoConstraints = false
        insuranceView.topAnchor.constraint(equalTo: medicineView.bottomAnchor, constant: 4).isActive = true
        insuranceView.centerXAnchor.constraint(equalTo: fourContentView.centerXAnchor).isActive = true
        insuranceView.heightAnchor.constraint(equalToConstant: height45).isActive = true
        insuranceView.widthAnchor.constraint(equalTo: fourContentView.widthAnchor, multiplier: 1).isActive = true
        
        insuranceImageView.translatesAutoresizingMaskIntoConstraints = false
        insuranceImageView.centerYAnchor.constraint(equalTo: insuranceView.centerYAnchor).isActive = true
        insuranceImageView.leadingAnchor.constraint(equalTo: insuranceView.leadingAnchor, constant: 15).isActive = true
        
        insuranceLabel.translatesAutoresizingMaskIntoConstraints = false
        insuranceLabel.centerYAnchor.constraint(equalTo: insuranceView.centerYAnchor).isActive = true
        insuranceLabel.leadingAnchor.constraint(equalTo: insuranceImageView.trailingAnchor, constant: 10).isActive = true
        
        insuranceSwitch.translatesAutoresizingMaskIntoConstraints = false
        insuranceSwitch.centerYAnchor.constraint(equalTo: insuranceView.centerYAnchor).isActive = true
        insuranceSwitch.trailingAnchor.constraint(equalTo: insuranceView.trailingAnchor, constant: -15).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorCell
        
        // MARK: NAVIAGTION CONTROLLER:

        navigationController?.navigationBar.isHidden = false
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""
        
        // MARK: NOTIFICATIONS BACKGROUND:

        notificationsBackgroundLottie.play()
        notificationsBackgroundLottie.loopMode = .loop
        notificationsBackgroundLottie.animationSpeed = 1
        notificationsBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: NOTIFICATIONS LOGO:
        
        notificationsLogoLottie.play()
        notificationsLogoLottie.loopMode = .loop
        notificationsLogoLottie.animationSpeed = 1
        
        // MARK: SCROLL VIEW:
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.isScrollEnabled = true
        
        // MARK: MAIN:
        
        mainView.backgroundColor = .colorTabBar
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = cornerRadius15
        
        mainLabel.text = "Допуск к уведомлениям"
        mainLabel.textColor = .white
        mainLabel.font = fontMediumStandard14
        mainLabel.adjustsFontSizeToFitWidth = true
        
        mainSwitch.addTarget(self, action: #selector(mainSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: FIRST CONTENT VIEW:
        
        firstContentView.backgroundColor = .colorTabBar
        firstContentView.layer.masksToBounds = true
        firstContentView.layer.cornerRadius = cornerRadius15
        
        // MARK: MONTHLY:
        
        monthlyView.backgroundColor = .colorTabBar
        monthlyView.layer.masksToBounds = true
        monthlyView.layer.cornerRadius = cornerRadius15
        
        let montlyImage = UIImage(systemName: "moon.stars.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        monthlyImageView.image = montlyImage
        
        monthlyLabel.text = "Сводка в конце месяца"
        monthlyLabel.textColor = .white
        monthlyLabel.font = fontMediumStandard14
        monthlyLabel.adjustsFontSizeToFitWidth = true
        
        monthlySwitch.isOn = true
        monthlySwitch.addTarget(self, action: #selector(monthlySwitchValueChange(_:)), for: .valueChanged)
        
        
        // MARK: SECOND CONTENT VIEW:
        
        secondContentView.backgroundColor = .colorTabBar
        secondContentView.layer.masksToBounds = true
        secondContentView.layer.cornerRadius = cornerRadius15
        
        // MARK: CONTAINER:
        
        containerView.backgroundColor = .colorTabBar
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = cornerRadius15
        
        let containerImage = UIImage(systemName: "backpack.fill", withConfiguration: configurationImage)?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        containerImageView.image = containerImage
        
        containerLabel.text = "Ресурс ранца"
        containerLabel.textColor = .white
        containerLabel.font = fontMediumStandard14
        containerLabel.adjustsFontSizeToFitWidth = true
        
        containerSwitch.addTarget(self, action: #selector(containerSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: LINE 1:
        
        lineOneView.backgroundColor = .colorDarkGray
        
        // MARK: AAD:
        
        aadView.backgroundColor = .colorTabBar
        aadView.layer.masksToBounds = true
        aadView.layer.cornerRadius = cornerRadius15
        
        let aadImage = UIImage(systemName: "circle.filled.ipad.fill", withConfiguration: configurationImage)?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        aadImageView.image = aadImage
        
        aadLabel.text = "Ресурс прибора"
        aadLabel.textColor = .white
        aadLabel.font = fontMediumStandard14
        aadLabel.adjustsFontSizeToFitWidth = true
        
        aadSwitch.addTarget(self, action: #selector(aadSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: LINE 2:
        
        lineTwoView.backgroundColor = .colorDarkGray
        
        // MARK: MAIN CANOPY RESOURSE:
        
        mainCanopyResourseView.backgroundColor = .colorTabBar
        mainCanopyResourseView.layer.masksToBounds = true
        mainCanopyResourseView.layer.cornerRadius = cornerRadius15
        
        let mainCanopyResourse = UIImage(systemName: "circle.tophalf.filled.inverse", withConfiguration: configurationImage)?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        mainCanopyResourseImageView.image = mainCanopyResourse
        
        mainCanopyResourseLabel.text = "Ресурс основного (по дате)"
        mainCanopyResourseLabel.textColor = .white
        mainCanopyResourseLabel.font = fontMediumStandard14
        mainCanopyResourseLabel.adjustsFontSizeToFitWidth = true
        
        mainCanopyResourseSwitch.addTarget(self, action: #selector(mainCanopyResourseSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: LINE 3:
        
        lineThreeView.backgroundColor = .colorDarkGray
        
        // MARK: RESERVE CANOPY RESOURSE:
        
        reserveCanopyResourseView.backgroundColor = .colorTabBar
        reserveCanopyResourseView.layer.masksToBounds = true
        reserveCanopyResourseView.layer.cornerRadius = cornerRadius15
        
        let reserveCanopyResourse = UIImage(systemName: "circle.tophalf.filled", withConfiguration: configurationImage)?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        reserveCanopyResourseImageView.image = reserveCanopyResourse
        
        reserveCanopyResourseLabel.text = "Ресурс запасного (по дате)"
        reserveCanopyResourseLabel.textColor = .white
        reserveCanopyResourseLabel.font = fontMediumStandard14
        reserveCanopyResourseLabel.adjustsFontSizeToFitWidth = true
        
        reserveCanopyResourseSwitch.addTarget(self, action: #selector(reserveCanopyResourseSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: THREE CONTENT VIEW:
        
        threeContentView.backgroundColor = .colorTabBar
        threeContentView.layer.masksToBounds = true
        threeContentView.layer.cornerRadius = cornerRadius15
        
        // MARK: MAIN CANOPY JUMPS:
        
        mainCanopyJumpsView.backgroundColor = .colorTabBar
        mainCanopyJumpsView.layer.masksToBounds = true
        mainCanopyJumpsView.layer.cornerRadius = cornerRadius15
        
        let mainCanopyJumps = UIImage(systemName: "button.roundedbottom.horizontal.fill", withConfiguration: configurationImage)?.withTintColor(.colorLightBlue, renderingMode: .alwaysOriginal)
        mainCanopyJumpsImageView.image = mainCanopyJumps
        
        mainCanopyJumpsLabel.text = "Основной (по прыжкам)"
        mainCanopyJumpsLabel.textColor = .white
        mainCanopyJumpsLabel.font = fontMediumStandard14
        mainCanopyJumpsLabel.adjustsFontSizeToFitWidth = true
        
        mainCanopyJumpsSwitch.addTarget(self, action: #selector(mainCanopyJumpsSwitchValueChange(_:)), for: .valueChanged)
        
        //MARK: LINE 4:
        
        lineFourView.backgroundColor = .colorDarkGray
        
        // MARK: RESERVE CANOPY REPACK:
        
        reserveCanopyRepackView.backgroundColor = .colorTabBar
        reserveCanopyRepackView.layer.masksToBounds = true
        reserveCanopyRepackView.layer.cornerRadius = cornerRadius15
        
        let reserveCanopyRepack = UIImage(systemName: "button.roundedtop.horizontal.fill", withConfiguration: configurationImage)?.withTintColor(.colorLightBlue, renderingMode: .alwaysOriginal)
        reserveCanopyRepackImageView.image = reserveCanopyRepack
        
        reserveCanopyRepackLabel.text = "Запасной (по переукладкам)"
        reserveCanopyRepackLabel.textColor = .white
        reserveCanopyRepackLabel.font = fontMediumStandard14
        reserveCanopyRepackLabel.adjustsFontSizeToFitWidth = true
        
        reserveCanopyRepackSwitch.addTarget(self, action: #selector(reserveCanopyRepackSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: FOUR CONTENT VIEW:
        
        fourContentView.backgroundColor = .colorTabBar
        fourContentView.layer.masksToBounds = true
        fourContentView.layer.cornerRadius = cornerRadius15
        
        // MARK: LICENSE:
        
        licenseView.backgroundColor = .colorTabBar
        licenseView.layer.masksToBounds = true
        licenseView.layer.cornerRadius = cornerRadius15
        
        let license = UIImage(systemName: "doc.richtext", withConfiguration: configurationImage)?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        licenseImageView.image = license
        
        licenseLabel.text = "Срок лицензии"
        licenseLabel.textColor = .white
        licenseLabel.font = fontMediumStandard14
        licenseLabel.adjustsFontSizeToFitWidth = true
        
        licenseSwitch.addTarget(self, action: #selector(licenseSwitchValueChange(_:)), for: .valueChanged)
        
        //MARK: LINE 5:
        
        lineFiveView.backgroundColor = .colorDarkGray
        
        // MARK: MEDICINE:
        
        medicineView.backgroundColor = .colorTabBar
        medicineView.layer.masksToBounds = true
        medicineView.layer.cornerRadius = cornerRadius15
        
        let medicine = UIImage(systemName: "heart.text.square.fill", withConfiguration: configurationImage)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        medicineImageView.image = medicine
        
        medicineLabel.text = "Срок медицины"
        medicineLabel.textColor = .white
        medicineLabel.font = fontMediumStandard14
        medicineLabel.adjustsFontSizeToFitWidth = true
        
        medicineSwitch.addTarget(self, action: #selector(medicineSwitchValueChange(_:)), for: .valueChanged)
        
        //MARK: LINE 6:
        
        lineSixView.backgroundColor = .colorDarkGray
        
        // MARK: INSURANCE:
        
        insuranceView.backgroundColor = .colorTabBar
        insuranceView.layer.masksToBounds = true
        insuranceView.layer.cornerRadius = cornerRadius15
        
        let insurance = UIImage(systemName: "doc.text.image", withConfiguration: configurationImage)?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        insuranceImageView.image = insurance
        
        insuranceLabel.text = "Срок страховки"
        insuranceLabel.textColor = .white
        insuranceLabel.font = fontMediumStandard14
        medicineLabel.adjustsFontSizeToFitWidth = true
        
        insuranceSwitch.addTarget(self, action: #selector(insuranceSwitchValueChange(_:)), for: .valueChanged)
    }

    // MARK: - HELPERS:
    
    // MARK: MAIN SWITCH ABOT REQUEST LOCAL NOTIFICATIONS:
    
    @objc func mainSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            checkStatusRequest()
            UserDefaults.standard.set(true, forKey: "mainSwitch")
            print("Уведомления будут приходить")
            firstContentView.isHidden = false
            secondContentView.isHidden = false
            threeContentView.isHidden = true // ДОДЕЛАТЬ
            fourContentView.isHidden = true // ДОДЕЛАТЬ
            
            let mainImage = UIImage(systemName: "light.beacon.min.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            mainImageView.image = mainImage
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            checkStatusRequest()
            UserDefaults.standard.set(false, forKey: "mainSwitch")
            notificationCenter.removeAllPendingNotificationRequests()
            notificationCenter.removeAllDeliveredNotifications()
            print("Уведомления не будут приходить и все стерты")
            deleteNotifications()
            
            let mainImage = UIImage(systemName: "light.beacon.min.fill", withConfiguration: configurationImage)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            mainImageView.image = mainImage
        }
    }
    
    // MARK: MONTHLY:
    
    @objc func monthlySwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeMonthlyNotification()
            NotificationManager.instance.setMonthlyNotification(arrayJumpsRealm: arrayJumpsRealm)
            UserDefaults.standard.set(true, forKey: "monthlySwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeMonthlyNotification()
            UserDefaults.standard.set(false, forKey: "monthlySwitch")
            getCount()
        }
    }
    
    // MARK: CONTAINER:
    
    @objc func containerSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeContainerNotification(for: arraySystemsRealm)
            NotificationManager.instance.setContainerNotifications(for: arraySystemsRealm)
            UserDefaults.standard.set(true, forKey: "containerSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeContainerNotification(for: arraySystemsRealm)
            UserDefaults.standard.set(false, forKey: "containerSwitch")
            getCount()
        }
    }
    
    // MARK: AAD:
    
    @objc func aadSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeAadNotification(for: arraySystemsRealm)
            NotificationManager.instance.setAadNotifications(for: arraySystemsRealm)
            UserDefaults.standard.set(true, forKey: "aadSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeAadNotification(for: arraySystemsRealm)
            UserDefaults.standard.set(false, forKey: "aadSwitch")
            getCount()
        }
    }
    
    // MARK: MAIN CANOPY RESOURSE:
    
    @objc func mainCanopyResourseSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeMainCanopyResourseNotification(for: arraySystemsRealm)
            NotificationManager.instance.setMainCanopyResourseNotifications(for: arraySystemsRealm)
            UserDefaults.standard.set(true, forKey: "mainCanopyResourseSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeMainCanopyResourseNotification(for: arraySystemsRealm)
            UserDefaults.standard.set(false, forKey: "mainCanopyResourseSwitch")
            getCount()
        }
    }
    
    // MARK: RESERVE CANOPY RESOURSE:
    
    @objc func reserveCanopyResourseSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeReserveCanopyResourseNotification(for: arraySystemsRealm)
            NotificationManager.instance.setReserveCanopyResourseNotifications(for: arraySystemsRealm)
            UserDefaults.standard.set(true, forKey: "reserveCanopyResourseSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeReserveCanopyResourseNotification(for: arraySystemsRealm)
            UserDefaults.standard.set(false, forKey: "reserveCanopyResourseSwitch")
            getCount()
        }
    }
    
    // MARK: MAIN CANOPY JUMPS:
    
    @objc func mainCanopyJumpsSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            
            UserDefaults.standard.set(true, forKey: "mainCanopyJumpsSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()

            UserDefaults.standard.set(false, forKey: "mainCanopyJumpsSwitch")
            getCount()
        }
    }
    
    // MARK: RESERVE CANOPY REPACK:
    
    @objc func reserveCanopyRepackSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            
            
            UserDefaults.standard.set(true, forKey: "reserveCanopyRepackSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            
            UserDefaults.standard.set(false, forKey: "reserveCanopyRepackSwitch")
            getCount()
        }
    }
    
    // MARK: LICENSE:
    
    @objc func licenseSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeLicenceNotification(for: arrayAccountRealm)
            NotificationManager.instance.setLicenceNotifications(for: arrayAccountRealm)
            UserDefaults.standard.set(true, forKey: "licenseSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            NotificationManager.instance.removeLicenceNotification(for: arrayAccountRealm)
            UserDefaults.standard.set(false, forKey: "licenseSwitch")
            getCount()
        }
    }
    
    // MARK: MEDICINE:
    
    @objc func medicineSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            
            
            UserDefaults.standard.set(true, forKey: "medicineSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            
            UserDefaults.standard.set(false, forKey: "medicineSwitch")
            getCount()
        }
    }
    
    // MARK: INSURANCE:
    
    @objc func insuranceSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            vibrationOn.vibrationStandart()
            
            
            UserDefaults.standard.set(true, forKey: "insuranceSwitch")
            getCount()
        } else {
            vibrationOn.vibrationStandart()
            
            UserDefaults.standard.set(false, forKey: "insuranceSwitch")
            getCount()
        }
    }
    
    // MARK: - HELPERS:
    
    // MARK: SEND REQUEST FOR USER:
    
    private func sendRequest() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    // MARK: CHECK STATUS REQUEST:
    
    private func checkStatusRequest() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                print("Уведомления разрешены в настройках телефона")
            case .denied:
                print("Уведомления запрещены в настройках телефона")
                DispatchQueue.main.async { [weak self] in
                    self?.mainSwitch.isOn = false
                    self?.deleteNotifications()
                    self?.showAlert()
                    let mainImage = UIImage(systemName: "light.beacon.min.fill", withConfiguration: self?.configurationImage)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                    self?.mainImageView.image = mainImage
                }
            case .notDetermined:
                print("Пользователь еще не принял решение")
            case .provisional:
                print("Уведомления разрешены в режиме 'предварительного разрешения'")
            case .ephemeral:
                print("Уведомления разрешены в режиме 'временнного разрешения'")
            @unknown default:
                print("Неизвестный статус разрешения")
            }
        }
    }
    
    // MARK: SHOW ALERT:
    
    private func showAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Checking the admission / notifications", comment: ""), message: NSLocalizedString("Checking the admission message / notifications", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: { _ in
            self.mainSwitch.isOn = false
            UserDefaults.standard.set(false, forKey: "mainSwitch")
            self.notificationCenter.removeAllPendingNotificationRequests()
            self.notificationCenter.removeAllDeliveredNotifications()
            print("Уведомления не будут приходить и все стерты через Алерт")
            if self.mainSwitch.isOn == false {
                self.deleteNotifications()
            }
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Settings iphone", comment: ""), style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings)
                }
            }
        }))
        present(alert, animated: true)
    }
        
    // MARK: LOAD USER DEFAULTS ABOUT SWITCHES:
    
    private func loadUserDefaults() {
        let statusMainSwitch = UserDefaults.standard.bool(forKey: "mainSwitch")
        mainSwitch.isOn = statusMainSwitch
        mainSwitchValueChange(mainSwitch)
        
        let statusMontlySwitch = UserDefaults.standard.bool(forKey: "monthlySwitch")
        monthlySwitch.isOn = statusMontlySwitch
        
        let statusContainerSwitch = UserDefaults.standard.bool(forKey: "containerSwitch")
        containerSwitch.isOn = statusContainerSwitch
        let statusAadSwitch = UserDefaults.standard.bool(forKey: "aadSwitch")
        aadSwitch.isOn = statusAadSwitch
        let statusMainResourseSwitch = UserDefaults.standard.bool(forKey: "mainCanopyResourseSwitch")
        mainCanopyResourseSwitch.isOn = statusMainResourseSwitch
        let statusReserveResourseSwitch = UserDefaults.standard.bool(forKey: "reserveCanopyResourseSwitch")
        reserveCanopyResourseSwitch.isOn = statusReserveResourseSwitch
        
        let statusMainJumpsSwitch = UserDefaults.standard.bool(forKey: "mainCanopyJumpsSwitch")
        mainCanopyJumpsSwitch.isOn = statusMainJumpsSwitch
        let statusReserveRepackSwitch = UserDefaults.standard.bool(forKey: "reserveCanopyRepackSwitch")
        reserveCanopyRepackSwitch.isOn = statusReserveRepackSwitch
        
        let statusLicenseSwitch = UserDefaults.standard.bool(forKey: "licenseSwitch")
        licenseSwitch.isOn = statusLicenseSwitch
        let statusMedicineSwitch = UserDefaults.standard.bool(forKey: "medicineSwitch")
        medicineSwitch.isOn = statusMedicineSwitch
        let statusInsuranceSwitch = UserDefaults.standard.bool(forKey: "insuranceSwitch")
        insuranceSwitch.isOn = statusInsuranceSwitch
    }
    
    // MARK: GET COUNTS OF REQUESTS:
    
    private func getCount() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("Количество уведомлений: \(requests.count)")
            print(requests)
        }
    }
    
    // MARK: DELETE ALL NOTIFICATIONS:
    
    private func deleteNotifications() {
        firstContentView.isHidden = true
        secondContentView.isHidden = true
        threeContentView.isHidden = true
        fourContentView.isHidden = true
        
        monthlySwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "monthlySwitch")
        NotificationManager.instance.removeMonthlyNotification()
        
        containerSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "containerSwitch")
        NotificationManager.instance.removeContainerNotification(for: arraySystemsRealm)
        aadSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "aadSwitch")
        NotificationManager.instance.removeAadNotification(for: arraySystemsRealm)
        mainCanopyResourseSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "mainCanopyResourseSwitch")
        NotificationManager.instance.removeMainCanopyResourseNotification(for: arraySystemsRealm)
        reserveCanopyResourseSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "reserveCanopyResourseSwitch")
        NotificationManager.instance.removeReserveCanopyResourseNotification(for: arraySystemsRealm)
        
        mainCanopyJumpsSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "mainCanopyJumpsSwitch")
        reserveCanopyRepackSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "reserveCanopyRepackSwitch")
        
        licenseSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "licenseSwitch")
        medicineSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "medicineSwitch")
        insuranceSwitch.isOn = false
        UserDefaults.standard.set(false, forKey: "insuranceSwitch")
        
        getCount()
    }
}
