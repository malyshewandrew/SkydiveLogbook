import Lottie
import NotificationCenter
import UIKit

final class NotificationsVS: UIViewController {
    // MARK: - PRIVATE PROPERTIES:
        
    private let notificationBackgroundLottie = LottieAnimationView(name: "NotificationsBackgroundLottie")
    private let notificationEffectLottie = LottieAnimationView(name: "EffectNewJump")
    private let notificationLogoLottie = LottieAnimationView(name: "NotificationsLogoLottie")
    private let notificationButton = UIButton()
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
    
    private let dateFormatter = DateFormatter()
    private let notificationCenter = UNUserNotificationCenter.current()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 22)
    
    // MARK: - LIFECYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        checkMainSwitch()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(notificationBackgroundLottie, notificationEffectLottie, notificationLogoLottie, notificationButton, scrollView)
        
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
        // MARK: NOTIFICATION BACKGROUND:
        
        notificationBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        notificationBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notificationBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notificationBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notificationBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: NOTIFICATION EFFECT LOTTIE:
        
        notificationEffectLottie.translatesAutoresizingMaskIntoConstraints = false
        notificationEffectLottie.topAnchor.constraint(equalTo: notificationLogoLottie.topAnchor).isActive = true
        notificationEffectLottie.bottomAnchor.constraint(equalTo: notificationLogoLottie.bottomAnchor).isActive = true
        notificationEffectLottie.leadingAnchor.constraint(equalTo: notificationLogoLottie.leadingAnchor).isActive = true
        notificationEffectLottie.trailingAnchor.constraint(equalTo: notificationLogoLottie.trailingAnchor).isActive = true
        
        // MARK: NOTIFICATION LOGO LOTTIE:
        
        notificationLogoLottie.translatesAutoresizingMaskIntoConstraints = false
        notificationLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        notificationLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notificationLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // MARK: NOTIFICATION BUTTON:
        
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.topAnchor.constraint(equalTo: notificationLogoLottie.topAnchor).isActive = true
        notificationButton.bottomAnchor.constraint(equalTo: notificationLogoLottie.bottomAnchor).isActive = true
        notificationButton.leadingAnchor.constraint(equalTo: notificationLogoLottie.leadingAnchor).isActive = true
        notificationButton.trailingAnchor.constraint(equalTo: notificationLogoLottie.trailingAnchor).isActive = true
        
        // MARK: SCROLL VIEW:
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: notificationLogoLottie.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: MAIN:
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
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
        
        // MARK: NOTIFICATION BACKGROUND:
        
        notificationBackgroundLottie.play()
        notificationBackgroundLottie.loopMode = .loop
        notificationBackgroundLottie.animationSpeed = 1
        notificationBackgroundLottie.contentMode = .scaleAspectFill
        
        // MARK: NOTIFICATION EFFECT LOTTIE:
        
        notificationEffectLottie.play()
        notificationEffectLottie.loopMode = .loop
        notificationEffectLottie.animationSpeed = 1
        notificationEffectLottie.layer.opacity = 1
        
        // MARK: NOTIFICATION LOGO LOTTIE:
        
        notificationLogoLottie.play()
        notificationLogoLottie.loopMode = .loop
        notificationLogoLottie.animationSpeed = 1
        
        // MARK: NOTIFICATION BUTTON:
        
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        
        // MARK: SCROLL VIEW:
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height / 1.6)
        scrollView.isScrollEnabled = true
        
        // MARK: MAIN:
        
        mainView.backgroundColor = .colorTabBar
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = cornerRadius15
        
        mainLabel.text = NSLocalizedString("Access to notifications / notifications", comment: "")
        mainLabel.textColor = .white
        mainLabel.font = FontManager.medium(size: 14).uiFont
        mainLabel.adjustsFontSizeToFitWidth = true
        
        mainSwitch.addTarget(self, action: #selector(mainSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: FIRST CONTENT VIEW:
        
        firstContentView.backgroundColor = .colorTabBar
        firstContentView.layer.masksToBounds = true
        firstContentView.layer.cornerRadius = cornerRadius15
        firstContentView.isHidden = true
        
        // MARK: MONTHLY:
        
        monthlyView.backgroundColor = .colorTabBar
        monthlyView.layer.masksToBounds = true
        monthlyView.layer.cornerRadius = cornerRadius15
        
        let montlyImage = UIImage(systemName: "moon.stars.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        monthlyImageView.image = montlyImage
        
        monthlyLabel.text = NSLocalizedString("Summary of the month / notifications", comment: "")
        monthlyLabel.textColor = .white
        monthlyLabel.font = FontManager.medium(size: 14).uiFont
        monthlyLabel.adjustsFontSizeToFitWidth = true
        
        monthlySwitch.addTarget(self, action: #selector(monthlySwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: SECOND CONTENT VIEW:
        
        secondContentView.backgroundColor = .colorTabBar
        secondContentView.layer.masksToBounds = true
        secondContentView.layer.cornerRadius = cornerRadius15
        secondContentView.isHidden = true
        
        // MARK: CONTAINER:
        
        containerView.backgroundColor = .colorTabBar
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = cornerRadius15
        
        let containerImage = UIImage(systemName: "backpack.fill", withConfiguration: configurationImage)?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        containerImageView.image = containerImage
        
        containerLabel.text = NSLocalizedString("Container resource / notifications", comment: "")
        containerLabel.textColor = .white
        containerLabel.font = FontManager.medium(size: 14).uiFont
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
        
        aadLabel.text = NSLocalizedString("AAD resource / notifications", comment: "")
        aadLabel.textColor = .white
        aadLabel.font = FontManager.medium(size: 14).uiFont
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
        
        mainCanopyResourseLabel.text = NSLocalizedString("Main canopy resource date / notifications", comment: "")
        mainCanopyResourseLabel.textColor = .white
        mainCanopyResourseLabel.font = FontManager.medium(size: 14).uiFont
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
        
        reserveCanopyResourseLabel.text = NSLocalizedString("Reserve canopy resource date / notifications", comment: "")
        reserveCanopyResourseLabel.textColor = .white
        reserveCanopyResourseLabel.font = FontManager.medium(size: 14).uiFont
        reserveCanopyResourseLabel.adjustsFontSizeToFitWidth = true
        
        reserveCanopyResourseSwitch.addTarget(self, action: #selector(reserveCanopyResourseSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: THREE CONTENT VIEW:
        
        threeContentView.backgroundColor = .colorTabBar
        threeContentView.layer.masksToBounds = true
        threeContentView.layer.cornerRadius = cornerRadius15
        threeContentView.isHidden = true
        
        // MARK: MAIN CANOPY JUMPS:
        
        mainCanopyJumpsView.backgroundColor = .colorTabBar
        mainCanopyJumpsView.layer.masksToBounds = true
        mainCanopyJumpsView.layer.cornerRadius = cornerRadius15
        
        let mainCanopyJumps = UIImage(systemName: "button.roundedbottom.horizontal.fill", withConfiguration: configurationImage)?.withTintColor(.colorLightBlue, renderingMode: .alwaysOriginal)
        mainCanopyJumpsImageView.image = mainCanopyJumps
        
        mainCanopyJumpsLabel.text = "Основной (по прыжкам)"
        mainCanopyJumpsLabel.textColor = .white
        mainCanopyJumpsLabel.font = FontManager.medium(size: 14).uiFont
        mainCanopyJumpsLabel.adjustsFontSizeToFitWidth = true
        
        mainCanopyJumpsSwitch.addTarget(self, action: #selector(mainCanopyJumpsSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: LINE 4:
        
        lineFourView.backgroundColor = .colorDarkGray
        
        // MARK: RESERVE CANOPY REPACK:
        
        reserveCanopyRepackView.backgroundColor = .colorTabBar
        reserveCanopyRepackView.layer.masksToBounds = true
        reserveCanopyRepackView.layer.cornerRadius = cornerRadius15
        
        let reserveCanopyRepack = UIImage(systemName: "button.roundedtop.horizontal.fill", withConfiguration: configurationImage)?.withTintColor(.colorLightBlue, renderingMode: .alwaysOriginal)
        reserveCanopyRepackImageView.image = reserveCanopyRepack
        
        reserveCanopyRepackLabel.text = "Запасной (по переукладкам)"
        reserveCanopyRepackLabel.textColor = .white
        reserveCanopyRepackLabel.font = FontManager.medium(size: 14).uiFont
        reserveCanopyRepackLabel.adjustsFontSizeToFitWidth = true
        
        reserveCanopyRepackSwitch.addTarget(self, action: #selector(reserveCanopyRepackSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: FOUR CONTENT VIEW:
        
        fourContentView.backgroundColor = .colorTabBar
        fourContentView.layer.masksToBounds = true
        fourContentView.layer.cornerRadius = cornerRadius15
        fourContentView.isHidden = true
        
        // MARK: LICENSE:
        
        licenseView.backgroundColor = .colorTabBar
        licenseView.layer.masksToBounds = true
        licenseView.layer.cornerRadius = cornerRadius15
        
        let license = UIImage(systemName: "doc.richtext", withConfiguration: configurationImage)?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        licenseImageView.image = license
        
        licenseLabel.text = NSLocalizedString("License period / notifications", comment: "")
        licenseLabel.textColor = .white
        licenseLabel.font = FontManager.medium(size: 14).uiFont
        licenseLabel.adjustsFontSizeToFitWidth = true
        
        licenseSwitch.addTarget(self, action: #selector(licenseSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: LINE 5:
        
        lineFiveView.backgroundColor = .colorDarkGray
        
        // MARK: MEDICINE:
        
        medicineView.backgroundColor = .colorTabBar
        medicineView.layer.masksToBounds = true
        medicineView.layer.cornerRadius = cornerRadius15
        
        let medicine = UIImage(systemName: "heart.text.square.fill", withConfiguration: configurationImage)?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        medicineImageView.image = medicine
        
        medicineLabel.text = NSLocalizedString("Medicine period / notifications", comment: "")
        medicineLabel.textColor = .white
        medicineLabel.font = FontManager.medium(size: 14).uiFont
        medicineLabel.adjustsFontSizeToFitWidth = true
        
        medicineSwitch.addTarget(self, action: #selector(medicineSwitchValueChange(_:)), for: .valueChanged)
        
        // MARK: LINE 6:
        
        lineSixView.backgroundColor = .colorDarkGray
        
        // MARK: INSURANCE:
        
        insuranceView.backgroundColor = .colorTabBar
        insuranceView.layer.masksToBounds = true
        insuranceView.layer.cornerRadius = cornerRadius15
        
        let insurance = UIImage(systemName: "doc.text.image", withConfiguration: configurationImage)?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        insuranceImageView.image = insurance
        
        insuranceLabel.text = NSLocalizedString("Insurance period / notifications", comment: "")
        insuranceLabel.textColor = .white
        insuranceLabel.font = FontManager.medium(size: 14).uiFont
        medicineLabel.adjustsFontSizeToFitWidth = true
        
        insuranceSwitch.addTarget(self, action: #selector(insuranceSwitchValueChange(_:)), for: .valueChanged)
    }
    
    // MARK: - HELPERS:
    
    // MARK: CHECK MAIN SWITCH:
    
    private func checkMainSwitch() {
        let statusMainSwitch = UserDefaults.standard.bool(forKey: "mainSwith")
        if statusMainSwitch {
            mainSwitch.isOn = true
            mainSwitchValueChange(mainSwitch)
            print("Проверка Main Switch при загрузке - ON")
        } else {
            print("Проверка Main Switch при загрузке - OFF")
            mainSwitch.isOn = false
            setRedMainImageView()
        }
    }
    
    // MARK: MAIN SWITCH ABOT REQUEST LOCAL NOTIFICATIONS:
    
    @objc private func mainSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            UserDefaults.standard.setValue(true, forKeyPath: "mainSwith")
            print("Main Switch ON")
            setImagesMainSwitch()
            loadUserDefaults()
            firstContentView.isHidden = false
            secondContentView.isHidden = false
            threeContentView.isHidden = false
            fourContentView.isHidden = false
        } else {
            UserDefaults.standard.setValue(false, forKeyPath: "mainSwith")
            print("Main Switch OFF")
            deleteNotifications()
            setRedMainImageView()
        }
    }
    
    // MARK: SHOW ALERT:
    
    private func showAlert() {
        let alert = UIAlertController(title: NSLocalizedString("Checking the admission / notifications", comment: ""), message: NSLocalizedString("Checking the admission message / notifications", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: { _ in
            self.mainSwitch.isOn = false
            print("Уведомления не будут приходить и все стерты через Алерт")
            if self.mainSwitch.isOn == false {
                self.deleteNotifications()
            }
            self.setRedMainImageView()
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
    
    // MARK: MONTHLY:
    
    @objc private func monthlySwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeMonthlyNotification()
            NotificationManager.instance.setMonthlyNotification(arrayJumpsRealm: arrayJumpsRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeMonthlyNotification()
            setImagesMainSwitch()
        }
    }
    
    // MARK: CONTAINER:
    
    @objc private func containerSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeContainerNotification(for: arraySystemsRealm)
            NotificationManager.instance.setContainerNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeContainerNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: AAD:
    
    @objc private func aadSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeAadNotification(for: arraySystemsRealm)
            NotificationManager.instance.setAadNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeAadNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: MAIN CANOPY RESOURSE:
    
    @objc private func mainCanopyResourseSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeMainCanopyResourseNotification(for: arraySystemsRealm)
            NotificationManager.instance.setMainCanopyResourseNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeMainCanopyResourseNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: RESERVE CANOPY RESOURSE:
    
    @objc private func reserveCanopyResourseSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeReserveCanopyResourseNotification(for: arraySystemsRealm)
            NotificationManager.instance.setReserveCanopyResourseNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeReserveCanopyResourseNotification(for: arraySystemsRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: MAIN CANOPY JUMPS:
    
    @objc private func mainCanopyJumpsSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
        } else {}
    }
    
    // MARK: RESERVE CANOPY REPACK:
    
    @objc private func reserveCanopyRepackSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
        } else {}
    }
    
    // MARK: LICENSE:
    
    @objc private func licenseSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeLicenseNotification(for: arrayAccountRealm)
            NotificationManager.instance.setLicenseNotification(for: arrayAccountRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeLicenseNotification(for: arrayAccountRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: MEDICINE:
    
    @objc private func medicineSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeMedicineNotification(for: arrayAccountRealm)
            NotificationManager.instance.setMedicineNotification(for: arrayAccountRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeMedicineNotification(for: arrayAccountRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: INSURANCE:
    
    @objc private func insuranceSwitchValueChange(_ sender: UISwitch) {
        VibrationManager.instance.vibrationStandart()
        if sender.isOn {
            NotificationManager.instance.removeInsuranceNotification(for: arrayAccountRealm)
            NotificationManager.instance.setInsuranceNotification(for: arrayAccountRealm)
            setImagesMainSwitch()
        } else {
            NotificationManager.instance.removeInsuranceNotification(for: arrayAccountRealm)
            setImagesMainSwitch()
        }
    }
    
    // MARK: - HELPERS:
        
    // MARK: LOAD USER DEFAULTS ABOUT SWITCHES:
    
    private func loadUserDefaults() {
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
    
    // MARK: DELETE ALL NOTIFICATIONS:
    
    private func deleteNotifications() {
        firstContentView.isHidden = true
        secondContentView.isHidden = true
        threeContentView.isHidden = true
        fourContentView.isHidden = true
        mainSwitch.isOn = false
        monthlySwitch.isOn = false
        containerSwitch.isOn = false
        aadSwitch.isOn = false
        mainCanopyResourseSwitch.isOn = false
        reserveCanopyResourseSwitch.isOn = false
        mainCanopyJumpsSwitch.isOn = false
        reserveCanopyRepackSwitch.isOn = false
        licenseSwitch.isOn = false
        medicineSwitch.isOn = false
        insuranceSwitch.isOn = false
        print("Уведомления не будут приходить и все стерты")
    }
    
    // MARK: NOTIFICATION BUTTON TAPPED:
    
    @objc private func notificationButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        
        var titleCount = ""
        var message = ""
        
        let value = UserDefaults.standard.bool(forKey: "monthlySwitch")
        
        if value {
            let currentDate = Date()
            let calendar = Calendar.current
            let lastDayOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.end
            if let lastDay = lastDayOfMonth {
                dateFormatter.dateFormat = "dd.MM"
                message += "\n" + NSLocalizedString("Summary of the month / notifications", comment: "") + ": " + dateFormatter.string(from: lastDay - 1) + ", 20:00"
            }
        }
        
        if let value = UserDefaults.standard.object(forKey: "containerSwitch") as? Bool, value {
            message += "\n" + NSLocalizedString("Container resource / notifications", comment: "")
        }
                
        if let value = UserDefaults.standard.object(forKey: "aadSwitch") as? Bool, value {
            message += "\n" + NSLocalizedString("AAD resource / notifications", comment: "")
        }
                
        if let value = UserDefaults.standard.object(forKey: "mainCanopyResourseSwitch") as? Bool, value {
            message += "\n" + NSLocalizedString("Main canopy resource date / notifications", comment: "")
        }
                
        if let value = UserDefaults.standard.object(forKey: "reserveCanopyResourseSwitch") as? Bool, value {
            message += "\n" + NSLocalizedString("Reserve canopy resource date / notifications", comment: "")
        }
        
        if let value = UserDefaults.standard.object(forKey: "licenseSwitch") as? Bool, value {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let accountClasses: [AccountClassRealm] = arrayAccountRealm
            for account in accountClasses {
                if let licenseDate = dateFormatter.date(from: account.licenseDate) {
                    guard let oneMonthBeforeExpiration = Calendar.current.date(byAdding: .month, value: -1, to: licenseDate) else { continue }
                    message += "\n" + NSLocalizedString("License period / notifications", comment: "") + ": " + dateFormatter.string(from: oneMonthBeforeExpiration) + ", 20:00"
                }
            }
        }
        
        titleCount = getCountNotification2()
            
        let alert = UIAlertController(title: NSLocalizedString("Notifications count / notifications", comment: "") + ": " + titleCount, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }

    // MARK: SET RED MAIN IMAGE VIEW:
    
    private func setRedMainImageView() {
        mainImageView.image = UIImage(systemName: "minus.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    }
    
    // MARK: GET COUNT NOTIFICATION 2:
    
    private func getCountNotification2() -> String {
        let arraySwitches: [UISwitch] = [monthlySwitch, containerSwitch, aadSwitch, mainCanopyResourseSwitch, reserveCanopyResourseSwitch, mainCanopyJumpsSwitch, reserveCanopyRepackSwitch, licenseSwitch, medicineSwitch, insuranceSwitch]
        
        var total = 0
        
        for item in arraySwitches {
            if item.isOn == true {
                total += 1
            }
        }
        
        return String(total)
    }
    
    // MARK: SET IMAGES MAIN SWITCH:
    
    private func setImagesMainSwitch() {
        if getCountNotification2() == String(0) {
            mainImageView.image = UIImage(systemName: "0.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(1) {
            mainImageView.image = UIImage(systemName: "1.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(2) {
            mainImageView.image = UIImage(systemName: "2.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(3) {
            mainImageView.image = UIImage(systemName: "3.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(4) {
            mainImageView.image = UIImage(systemName: "4.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(5) {
            mainImageView.image = UIImage(systemName: "5.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(6) {
            mainImageView.image = UIImage(systemName: "6.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(7) {
            mainImageView.image = UIImage(systemName: "7.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(8) {
            mainImageView.image = UIImage(systemName: "8.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(9) {
            mainImageView.image = UIImage(systemName: "9.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(10) {
            mainImageView.image = UIImage(systemName: "10.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(11) {
            mainImageView.image = UIImage(systemName: "11.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(12) {
            mainImageView.image = UIImage(systemName: "12.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(13) {
            mainImageView.image = UIImage(systemName: "13.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(14) {
            mainImageView.image = UIImage(systemName: "14.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(15) {
            mainImageView.image = UIImage(systemName: "15.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(16) {
            mainImageView.image = UIImage(systemName: "16.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(17) {
            mainImageView.image = UIImage(systemName: "17.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(18) {
            mainImageView.image = UIImage(systemName: "18.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(19) {
            mainImageView.image = UIImage(systemName: "19.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(20) {
            mainImageView.image = UIImage(systemName: "20.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(21) {
            mainImageView.image = UIImage(systemName: "21.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(22) {
            mainImageView.image = UIImage(systemName: "22.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(23) {
            mainImageView.image = UIImage(systemName: "23.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(24) {
            mainImageView.image = UIImage(systemName: "24.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(25) {
            mainImageView.image = UIImage(systemName: "25.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(26) {
            mainImageView.image = UIImage(systemName: "26.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(27) {
            mainImageView.image = UIImage(systemName: "27.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(28) {
            mainImageView.image = UIImage(systemName: "28.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(29) {
            mainImageView.image = UIImage(systemName: "29.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(30) {
            mainImageView.image = UIImage(systemName: "30.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(31) {
            mainImageView.image = UIImage(systemName: "31.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(32) {
            mainImageView.image = UIImage(systemName: "32.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(33) {
            mainImageView.image = UIImage(systemName: "33.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(34) {
            mainImageView.image = UIImage(systemName: "34.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(35) {
            mainImageView.image = UIImage(systemName: "35.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(36) {
            mainImageView.image = UIImage(systemName: "36.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(37) {
            mainImageView.image = UIImage(systemName: "37.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(38) {
            mainImageView.image = UIImage(systemName: "38.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(39) {
            mainImageView.image = UIImage(systemName: "39.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(40) {
            mainImageView.image = UIImage(systemName: "40.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(41) {
            mainImageView.image = UIImage(systemName: "41.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(42) {
            mainImageView.image = UIImage(systemName: "42.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(43) {
            mainImageView.image = UIImage(systemName: "43.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(44) {
            mainImageView.image = UIImage(systemName: "44.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(45) {
            mainImageView.image = UIImage(systemName: "45.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(46) {
            mainImageView.image = UIImage(systemName: "46.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(47) {
            mainImageView.image = UIImage(systemName: "47.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(48) {
            mainImageView.image = UIImage(systemName: "48.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(49) {
            mainImageView.image = UIImage(systemName: "49.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if getCountNotification2() == String(50) {
            mainImageView.image = UIImage(systemName: "50.circle.fill", withConfiguration: configurationImage)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        }
    }
}
