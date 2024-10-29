import AlertKit
import AudioToolbox
import AVFoundation
import Lottie
import UIKit

final class CalculatorVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private var player = AVAudioPlayer()

    private let calculatorGradientLottie = LottieAnimationView(name: "CalculatorGradient")
    private let calculatorBlackView = UIView()
    private let calculatorBackgroundLottie = LottieAnimationView(name: "CalculatorBackground")

    private let canopyTitleLabel = UILabel()
    private let canopyLogoLottie = LottieAnimationView(name: "Calculator")
    private let weightCanopyTextField = UITextField()
    private let sizeCanopyTextField = UITextField()
    private let cleanCanopyButton = UIButton()
    private let resultCanopyButton = UIButton()
    private let resultCanopyLabel = UILabel()
    private let canopyTextView = UIView()
    private let resultCanopyTextLabel = UILabel()
    private let canopyAlertButton = UIButton()

    private let viewLoadCategoryA = UIView()
    private let viewLoadCategoryB = UIView()
    private let viewLoadCategoryC = UIView()
    private let viewLoadCategoryD = UIView()
    private let viewLoadCategoryD1 = UIView()
    private let viewLoadCategoryD2 = UIView()
    
    private let wingTitleLabel = UILabel()
    private let wingLogoLottie = LottieAnimationView(name: "WingLogo")
    private let heightJumpTextField = UITextField()
    private let heightOpenTextField = UITextField()
    private let windSpeedTextField = UITextField()
    private let windSpeedPickerView = UIPickerView()
    private let qualityTextField = UITextField()
    private let qualityPickerView = UIPickerView()
    private let resultWingButton = UIButton()
    private let resultWingView = UIView()
    private let resultWingLabel = UILabel()
    private let cleanWingButton = UIButton()
    private let qualityValues: [Float] = Array(stride(from: 0.0, through: 10.0, by: 0.5))
    private let windValues: [Float] = Array(stride(from: 0.0, through: 15.0, by: 0.5))
    private let wingAlertButton = UIButton()

    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()

    private var arrayViews: [UIView] = []
    private let canopyView = UIView()
    private let wingsuitView = UIView()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureGestures()
        scrollView.delegate = self
        weightCanopyTextField.delegate = self
        sizeCanopyTextField.delegate = self
        heightJumpTextField.delegate = self
        heightOpenTextField.delegate = self
        windSpeedTextField.delegate = self
        qualityTextField.delegate = self
        addViews()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(calculatorGradientLottie, calculatorBlackView, calculatorBackgroundLottie, scrollView, pageControl)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: CALCULATOR GRADIENT:

        calculatorGradientLottie.translatesAutoresizingMaskIntoConstraints = false
        calculatorGradientLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        calculatorGradientLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        calculatorGradientLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        calculatorGradientLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        // MARK: CALCULATOR VIEW:

        calculatorBlackView.translatesAutoresizingMaskIntoConstraints = false
        calculatorBlackView.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        calculatorBlackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        calculatorBlackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        calculatorBlackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        // MARK: CALCULATOR BACKGROUND:

        calculatorBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        calculatorBackgroundLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -175).isActive = true
        calculatorBackgroundLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        calculatorBackgroundLottie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        calculatorBackgroundLottie.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        // MARK: SCROLL VIEW:

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // MARK: PAGE CONTROL:

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: height40).isActive = true
        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false

        // MARK: CALCULATOR GRADIENT:

        calculatorGradientLottie.play()
        calculatorGradientLottie.loopMode = .loop
        calculatorGradientLottie.animationSpeed = 1
        calculatorGradientLottie.contentMode = .scaleAspectFill

        // MARK: CALCULATOR VIEW:

        calculatorBlackView.backgroundColor = .colorBackground
        calculatorBlackView.layer.opacity = 0.6

        // MARK: CALCULATOR BACKGROUND:

        calculatorBackgroundLottie.play()
        calculatorBackgroundLottie.loopMode = .loop
        calculatorBackgroundLottie.animationSpeed = 1
        calculatorBackgroundLottie.contentMode = .scaleAspectFill

        // MARK: SCROLL VIEW:

        scrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * 2, height: 200)
        scrollView.isPagingEnabled = true

        // MARK: PAGE CONTROL:

        pageControl.numberOfPages = 2
        pageControl.backgroundStyle = .prominent
        pageControl.currentPageIndicatorTintColor = .colorLightBlue
        pageControl.preferredIndicatorImage = UIImage(systemName: "smallcircle.filled.circle.fill")
        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false

        arrayViews.append(canopyView)
        arrayViews.append(wingsuitView)
    }

    // MARK: CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }

    private func addViews() {
        add(view: arrayViews[0], position: 0)
        add(view: arrayViews[1], position: 1)
    }

    // MARK: - HELPERS:

    // MARK: PAGE CONTROL:

    private func add(view _: UIView, position: CGFloat) {
        let screenWidth = UIScreen.main.bounds.width
        let view = UIView()
        scrollView.addSubviews(view)
        view.frame = CGRect(x: screenWidth * position, y: 0, width: screenWidth, height: UIScreen.main.bounds.height)

        if position == 0 {
            scrollView.addSubviews(canopyView)
            canopyView.frame = CGRect(x: screenWidth * position, y: 0, width: screenWidth, height: UIScreen.main.bounds.height)

            canopyView.addSubviews(canopyTitleLabel, canopyLogoLottie, weightCanopyTextField, sizeCanopyTextField, resultCanopyButton, cleanCanopyButton, resultCanopyLabel, canopyTextView, canopyAlertButton)
            canopyTextView.addSubview(resultCanopyTextLabel)
            resultCanopyLabel.addSubviews(viewLoadCategoryA, viewLoadCategoryB, viewLoadCategoryC, viewLoadCategoryD, viewLoadCategoryD1, viewLoadCategoryD2)
            
            // MARK: CANOPY TITLE LABEL:
            
            canopyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            canopyTitleLabel.topAnchor.constraint(equalTo: canopyView.topAnchor, constant: 15).isActive = true
            canopyTitleLabel.centerXAnchor.constraint(equalTo: canopyView.centerXAnchor).isActive = true

            // MARK: ANIMATION CANOPY LOGO:

            canopyLogoLottie.translatesAutoresizingMaskIntoConstraints = false
            canopyLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
            canopyLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            canopyLogoLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
            canopyLogoLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
            
            // MARK: CANOPY ALERT BUTTON:
            
            canopyAlertButton.translatesAutoresizingMaskIntoConstraints = false
            canopyAlertButton.centerXAnchor.constraint(equalTo: canopyLogoLottie.centerXAnchor).isActive = true
            canopyAlertButton.centerYAnchor.constraint(equalTo: canopyLogoLottie.centerYAnchor).isActive = true
            canopyAlertButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
            canopyAlertButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

            // MARK: WEIGHT SKYDIVER:

            weightCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
            weightCanopyTextField.topAnchor.constraint(equalTo: canopyLogoLottie.bottomAnchor, constant: 10).isActive = true
            weightCanopyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            weightCanopyTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
            weightCanopyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

            // MARK: SIZE CANOPY:

            sizeCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
            sizeCanopyTextField.topAnchor.constraint(equalTo: weightCanopyTextField.bottomAnchor, constant: 15).isActive = true
            sizeCanopyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            sizeCanopyTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
            sizeCanopyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

            // MARK: CLEAN BUTTON:

            cleanCanopyButton.translatesAutoresizingMaskIntoConstraints = false
            cleanCanopyButton.topAnchor.constraint(equalTo: sizeCanopyTextField.bottomAnchor, constant: 20).isActive = true
            cleanCanopyButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
            cleanCanopyButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
            cleanCanopyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true

            // MARK: RESULT BUTTON:

            resultCanopyButton.translatesAutoresizingMaskIntoConstraints = false
            resultCanopyButton.topAnchor.constraint(equalTo: sizeCanopyTextField.bottomAnchor, constant: 20).isActive = true
            resultCanopyButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
            resultCanopyButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
            resultCanopyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true

            // MARK: RESULT:

            resultCanopyLabel.translatesAutoresizingMaskIntoConstraints = false
            resultCanopyLabel.topAnchor.constraint(equalTo: cleanCanopyButton.bottomAnchor, constant: 20).isActive = true
            resultCanopyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            resultCanopyLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
            resultCanopyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

            // MARK: INFO VIEW:

            canopyTextView.translatesAutoresizingMaskIntoConstraints = false
            canopyTextView.topAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: 20).isActive = true
            canopyTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            canopyTextView.heightAnchor.constraint(greaterThanOrEqualTo: resultCanopyTextLabel.heightAnchor, constant: 10).isActive = true
            canopyTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

            // MARK: INFO LABEL:

            resultCanopyTextLabel.translatesAutoresizingMaskIntoConstraints = false
            resultCanopyTextLabel.centerXAnchor.constraint(equalTo: canopyTextView.centerXAnchor).isActive = true
            resultCanopyTextLabel.centerYAnchor.constraint(equalTo: canopyTextView.centerYAnchor).isActive = true
            resultCanopyTextLabel.leadingAnchor.constraint(equalTo: canopyTextView.leadingAnchor, constant: 10).isActive = true
            resultCanopyTextLabel.trailingAnchor.constraint(equalTo: canopyTextView.trailingAnchor, constant: -10).isActive = true

            // MARK: VIE LOAD CATEGORY A:

            viewLoadCategoryA.translatesAutoresizingMaskIntoConstraints = false
            viewLoadCategoryA.leadingAnchor.constraint(equalTo: resultCanopyLabel.leadingAnchor, constant: 10).isActive = true
            viewLoadCategoryA.bottomAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: -5).isActive = true
            viewLoadCategoryA.heightAnchor.constraint(equalToConstant: 3).isActive = true
            viewLoadCategoryA.widthAnchor.constraint(equalTo: resultCanopyLabel.widthAnchor, multiplier: 0.16).isActive = true
            viewLoadCategoryA.backgroundColor = .systemBlue
            viewLoadCategoryA.isHidden = true

            // MARK: VIE LOAD CATEGORY B:

            viewLoadCategoryB.translatesAutoresizingMaskIntoConstraints = false
            viewLoadCategoryB.leadingAnchor.constraint(equalTo: resultCanopyLabel.leadingAnchor, constant: 10).isActive = true
            viewLoadCategoryB.bottomAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: -5).isActive = true
            viewLoadCategoryB.heightAnchor.constraint(equalToConstant: 3).isActive = true
            viewLoadCategoryB.widthAnchor.constraint(equalTo: resultCanopyLabel.widthAnchor, multiplier: 0.30).isActive = true
            viewLoadCategoryB.backgroundColor = .systemGreen
            viewLoadCategoryB.isHidden = true

            // MARK: VIE LOAD CATEGORY C:

            viewLoadCategoryC.translatesAutoresizingMaskIntoConstraints = false
            viewLoadCategoryC.leadingAnchor.constraint(equalTo: resultCanopyLabel.leadingAnchor, constant: 10).isActive = true
            viewLoadCategoryC.bottomAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: -5).isActive = true
            viewLoadCategoryC.heightAnchor.constraint(equalToConstant: 3).isActive = true
            viewLoadCategoryC.widthAnchor.constraint(equalTo: resultCanopyLabel.widthAnchor, multiplier: 0.45).isActive = true
            viewLoadCategoryC.backgroundColor = .systemYellow
            viewLoadCategoryC.isHidden = true

            // MARK: VIE LOAD CATEGORY D:

            viewLoadCategoryD.translatesAutoresizingMaskIntoConstraints = false
            viewLoadCategoryD.leadingAnchor.constraint(equalTo: resultCanopyLabel.leadingAnchor, constant: 10).isActive = true
            viewLoadCategoryD.bottomAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: -5).isActive = true
            viewLoadCategoryD.heightAnchor.constraint(equalToConstant: 3).isActive = true
            viewLoadCategoryD.widthAnchor.constraint(equalTo: resultCanopyLabel.widthAnchor, multiplier: 0.60).isActive = true
            viewLoadCategoryD.backgroundColor = .systemOrange
            viewLoadCategoryD.isHidden = true

            // MARK: VIE LOAD CATEGORY D1:

            viewLoadCategoryD1.translatesAutoresizingMaskIntoConstraints = false
            viewLoadCategoryD1.leadingAnchor.constraint(equalTo: resultCanopyLabel.leadingAnchor, constant: 10).isActive = true
            viewLoadCategoryD1.bottomAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: -5).isActive = true
            viewLoadCategoryD1.heightAnchor.constraint(equalToConstant: 3).isActive = true
            viewLoadCategoryD1.widthAnchor.constraint(equalTo: resultCanopyLabel.widthAnchor, multiplier: 0.80).isActive = true
            viewLoadCategoryD1.backgroundColor = .systemRed
            viewLoadCategoryD1.isHidden = true

            // MARK: VIE LOAD CATEGORY D2:

            viewLoadCategoryD2.translatesAutoresizingMaskIntoConstraints = false
            viewLoadCategoryD2.leadingAnchor.constraint(equalTo: resultCanopyLabel.leadingAnchor, constant: 10).isActive = true
            viewLoadCategoryD2.bottomAnchor.constraint(equalTo: resultCanopyLabel.bottomAnchor, constant: -5).isActive = true
            viewLoadCategoryD2.heightAnchor.constraint(equalToConstant: 3).isActive = true
            viewLoadCategoryD2.trailingAnchor.constraint(equalTo: resultCanopyLabel.trailingAnchor, constant: -10).isActive = true
            viewLoadCategoryD2.backgroundColor = .red
            viewLoadCategoryD2.isHidden = true
            
            // MARK: CANOPY TITLE LABEL:
            
            canopyTitleLabel.isHidden = true
            canopyTitleLabel.textColor = .colorWhite
            canopyTitleLabel.font = FontManager.thin(size: 10).uiFont
            canopyTitleLabel.text = NSLocalizedString("Canopy title / calculator", comment: "")

            // MARK: ANIMATION:

            canopyLogoLottie.play()
            canopyLogoLottie.loopMode = .loop
            
            // MARK: CANOPY ALERT BUTTON:
            
            canopyAlertButton.addTarget(self, action: #selector(canopyAlertButtonTapped), for: .touchUpInside)

            // MARK: WEIGHT SKYDIVER:

            weightCanopyTextField.placeholder = "\(NSLocalizedString("Total weight", comment: "")) (\(NSLocalizedString("kg.", comment: "")))*"
            weightCanopyTextField.backgroundColor = .colorTabBar
            weightCanopyTextField.font = FontManager.medium(size: 14).uiFont
            weightCanopyTextField.textColor = .colorWhite
            weightCanopyTextField.layer.cornerRadius = cornerRadius15
            weightCanopyTextField.textAlignment = textAligmentCenter
            weightCanopyTextField.layer.masksToBounds = true
            weightCanopyTextField.keyboardType = .numberPad
            weightCanopyTextField.returnKeyType = .done

            // MARK: SIZE CANOPY:

            sizeCanopyTextField.placeholder = "\(NSLocalizedString("Square canopy", comment: "")) (\(NSLocalizedString("ft", comment: "")))*"
            sizeCanopyTextField.backgroundColor = .colorTabBar
            sizeCanopyTextField.font = FontManager.medium(size: 14).uiFont
            sizeCanopyTextField.textColor = .colorWhite
            sizeCanopyTextField.layer.cornerRadius = cornerRadius15
            sizeCanopyTextField.textAlignment = textAligmentCenter
            sizeCanopyTextField.layer.masksToBounds = true
            sizeCanopyTextField.keyboardType = .numberPad
            sizeCanopyTextField.returnKeyType = .done
            
            // MARK: CLEAN BUTTON:

            cleanCanopyButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
            cleanCanopyButton.backgroundColor = .colorTabBar
            cleanCanopyButton.layer.cornerRadius = cornerRadius15
            cleanCanopyButton.setTitleColor(.colorWhite, for: .normal)
            cleanCanopyButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
            cleanCanopyButton.addTarget(self, action: #selector(actionButtonCleanCanopyTap), for: .touchUpInside)

            // MARK: SAVE BUTTON:

            resultCanopyButton.setTitle(NSLocalizedString("Calculate", comment: ""), for: .normal)
            resultCanopyButton.backgroundColor = .colorCell
            resultCanopyButton.layer.cornerRadius = cornerRadius15
            resultCanopyButton.setTitleColor(.colorWhite, for: .normal)
            resultCanopyButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
            resultCanopyButton.addTarget(self, action: #selector(actionButtonCanopySaveTap), for: .touchUpInside)

            // MARK: RESULT:

            resultCanopyLabel.backgroundColor = .colorTabBar
            resultCanopyLabel.textColor = .colorWhite
            resultCanopyLabel.layer.masksToBounds = true
            resultCanopyLabel.layer.cornerRadius = cornerRadius15
            resultCanopyLabel.textAlignment = .center
            resultCanopyLabel.font = FontManager.bold(size: 16).uiFont
            resultCanopyLabel.isHidden = true

            // MARK: INFO VIEW:

            canopyTextView.backgroundColor = .colorCell
            canopyTextView.layer.cornerRadius = cornerRadius15
            canopyTextView.isHidden = true

            // MARK: INFO LABEL:

            resultCanopyTextLabel.textAlignment = .left
            resultCanopyTextLabel.numberOfLines = 0
            resultCanopyTextLabel.font = FontManager.regular(size: 10).uiFont
            resultCanopyTextLabel.textColor = .colorWhite
            
        } else if position == 1 {
            qualityPickerView.delegate = self
            qualityPickerView.dataSource = self
            
            windSpeedPickerView.delegate = self
            windSpeedPickerView.dataSource = self
            
            scrollView.addSubview(wingsuitView)
            wingsuitView.frame = CGRect(x: screenWidth * position, y: 0, width: screenWidth, height: UIScreen.main.bounds.height)
            
            wingsuitView.addSubviews(wingTitleLabel, wingLogoLottie, heightJumpTextField, heightOpenTextField, windSpeedTextField, qualityTextField, cleanWingButton, resultWingButton, resultWingView, wingAlertButton)
            resultWingView.addSubviews(resultWingLabel)
            
            // MARK: WING TITLE LABEL:
            
            wingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            wingTitleLabel.topAnchor.constraint(equalTo: wingsuitView.topAnchor, constant: 15).isActive = true
            wingTitleLabel.centerXAnchor.constraint(equalTo: wingsuitView.centerXAnchor).isActive = true
        
            // MARK: ANIMATION WING LOGO:

            wingLogoLottie.translatesAutoresizingMaskIntoConstraints = false
            wingLogoLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
            wingLogoLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            wingLogoLottie.heightAnchor.constraint(equalToConstant: 175).isActive = true
            wingLogoLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
            
            // MARK: WING ALERT BUTTON:
            
            wingAlertButton.translatesAutoresizingMaskIntoConstraints = false
            wingAlertButton.centerXAnchor.constraint(equalTo: wingLogoLottie.centerXAnchor).isActive = true
            wingAlertButton.centerYAnchor.constraint(equalTo: wingLogoLottie.centerYAnchor).isActive = true
            wingAlertButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
            wingAlertButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            // MARK: HEIGHT JUMP:

            heightJumpTextField.translatesAutoresizingMaskIntoConstraints = false
            heightJumpTextField.topAnchor.constraint(equalTo: wingLogoLottie.bottomAnchor, constant: -45).isActive = true
            heightJumpTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            heightJumpTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
            heightJumpTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
            
            // MARK: HEIGHT OPEN:

            heightOpenTextField.translatesAutoresizingMaskIntoConstraints = false
            heightOpenTextField.topAnchor.constraint(equalTo: heightJumpTextField.bottomAnchor, constant: 15).isActive = true
            heightOpenTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            heightOpenTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
            heightOpenTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
            
            // MARK: WIND SPEED:

            windSpeedTextField.translatesAutoresizingMaskIntoConstraints = false
            windSpeedTextField.topAnchor.constraint(equalTo: heightOpenTextField.bottomAnchor, constant: 15).isActive = true
            windSpeedTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
            windSpeedTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
            windSpeedTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
            
            windSpeedPickerView.translatesAutoresizingMaskIntoConstraints = false
            
            // MARK: QUALITY:

            qualityTextField.translatesAutoresizingMaskIntoConstraints = false
            qualityTextField.topAnchor.constraint(equalTo: heightOpenTextField.bottomAnchor, constant: 15).isActive = true
            qualityTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
            qualityTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
            qualityTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
            
            qualityPickerView.translatesAutoresizingMaskIntoConstraints = false
            
            // MARK: CLEAN BUTTON:

            cleanWingButton.translatesAutoresizingMaskIntoConstraints = false
            cleanWingButton.topAnchor.constraint(equalTo: qualityTextField.bottomAnchor, constant: 20).isActive = true
            cleanWingButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
            cleanWingButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
            cleanWingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true

            // MARK: RESULT BUTTON:

            resultWingButton.translatesAutoresizingMaskIntoConstraints = false
            resultWingButton.topAnchor.constraint(equalTo: qualityTextField.bottomAnchor, constant: 20).isActive = true
            resultWingButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
            resultWingButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
            resultWingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
            
            // MARK: INFO VIEW:

            resultWingView.translatesAutoresizingMaskIntoConstraints = false
            resultWingView.topAnchor.constraint(equalTo: cleanWingButton.bottomAnchor, constant: 20).isActive = true
            resultWingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            resultWingView.heightAnchor.constraint(greaterThanOrEqualTo: resultWingLabel.heightAnchor, constant: 20).isActive = true
            resultWingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

            // MARK: INFO LABEL:

            resultWingLabel.translatesAutoresizingMaskIntoConstraints = false
            resultWingLabel.centerXAnchor.constraint(equalTo: resultWingView.centerXAnchor).isActive = true
            resultWingLabel.centerYAnchor.constraint(equalTo: resultWingView.centerYAnchor).isActive = true
            resultWingLabel.leadingAnchor.constraint(equalTo: resultWingView.leadingAnchor, constant: 10).isActive = true
            resultWingLabel.trailingAnchor.constraint(equalTo: resultWingView.trailingAnchor, constant: -10).isActive = true

            // MARK: WING TITLE LABEL:
            
            wingTitleLabel.isHidden = true
            wingTitleLabel.textColor = .colorWhite
            wingTitleLabel.font = FontManager.thin(size: 10).uiFont
            wingTitleLabel.text = NSLocalizedString("Wing title / calculator", comment: "")
            
            // MARK: ANIMATION:

            wingLogoLottie.play()
            wingLogoLottie.loopMode = .loop
            wingLogoLottie.animationSpeed = 0.7
            
            // MARK: WING ALERT BUTTON:
            
            wingAlertButton.addTarget(self, action: #selector(wingAlertButtonTapped), for: .touchUpInside)
            
            // MARK: HEIGHT OPEN:

            heightJumpTextField.placeholder = "\(NSLocalizedString("Height jump / calculator", comment: "")) (\(NSLocalizedString("m.", comment: "")))*"
            heightJumpTextField.backgroundColor = .colorTabBar
            heightJumpTextField.font = FontManager.medium(size: 14).uiFont
            heightJumpTextField.textColor = .colorWhite
            heightJumpTextField.layer.cornerRadius = cornerRadius15
            heightJumpTextField.textAlignment = textAligmentCenter
            heightJumpTextField.layer.masksToBounds = true
            heightJumpTextField.keyboardType = .numberPad
            heightJumpTextField.returnKeyType = .done

            // MARK: HEIGHT OPEN:

            heightOpenTextField.placeholder = "\(NSLocalizedString("Height open / calculator", comment: "")) (\(NSLocalizedString("m.", comment: "")))*"
            heightOpenTextField.backgroundColor = .colorTabBar
            heightOpenTextField.font = FontManager.medium(size: 14).uiFont
            heightOpenTextField.textColor = .colorWhite
            heightOpenTextField.layer.cornerRadius = cornerRadius15
            heightOpenTextField.textAlignment = textAligmentCenter
            heightOpenTextField.layer.masksToBounds = true
            heightOpenTextField.keyboardType = .numberPad
            heightOpenTextField.returnKeyType = .done
            
            // MARK: WIND SPEED:

            windSpeedTextField.placeholder = "\(NSLocalizedString("Wind speed / calculator", comment: ""))*"
            windSpeedTextField.backgroundColor = .colorTabBar
            windSpeedTextField.font = FontManager.medium(size: 14).uiFont
            windSpeedTextField.textColor = .colorWhite
            windSpeedTextField.layer.cornerRadius = cornerRadius15
            windSpeedTextField.textAlignment = textAligmentCenter
            windSpeedTextField.layer.masksToBounds = true
            windSpeedTextField.inputView = windSpeedPickerView
            windSpeedTextField.returnKeyType = .done
            windSpeedPickerView.backgroundColor = .colorTabBar
            
            // MARK: QUALITY:

            qualityTextField.placeholder = "\(NSLocalizedString("Quality / calculator", comment: ""))*"
            qualityTextField.backgroundColor = .colorTabBar
            qualityTextField.font = FontManager.medium(size: 14).uiFont
            qualityTextField.textColor = .colorWhite
            qualityTextField.layer.cornerRadius = cornerRadius15
            qualityTextField.textAlignment = textAligmentCenter
            qualityTextField.layer.masksToBounds = true
            qualityTextField.inputView = qualityPickerView
            qualityTextField.returnKeyType = .done
            qualityPickerView.backgroundColor = .colorTabBar
            
            // MARK: CLEAN BUTTON:

            cleanWingButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
            cleanWingButton.backgroundColor = .colorTabBar
            cleanWingButton.layer.cornerRadius = cornerRadius15
            cleanWingButton.setTitleColor(.colorWhite, for: .normal)
            cleanWingButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
            cleanWingButton.addTarget(self, action: #selector(actionButtonCleanWingTap), for: .touchUpInside)

            // MARK: SAVE BUTTON:

            resultWingButton.setTitle(NSLocalizedString("Calculate", comment: ""), for: .normal)
            resultWingButton.backgroundColor = .colorCell
            resultWingButton.layer.cornerRadius = cornerRadius15
            resultWingButton.setTitleColor(.colorWhite, for: .normal)
            resultWingButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
            resultWingButton.addTarget(self, action: #selector(actionButtonWingSaveTap), for: .touchUpInside)
            
            // MARK: RESULT:
            
            resultWingView.isHidden = true
            resultWingView.backgroundColor = .colorCell
            resultWingView.layer.masksToBounds = true
            resultWingView.layer.cornerRadius = cornerRadius15

            resultWingLabel.backgroundColor = .colorCell
            resultWingLabel.textColor = .colorWhite
            resultWingLabel.layer.masksToBounds = true
            resultWingLabel.layer.cornerRadius = cornerRadius15
            resultWingLabel.textAlignment = .center
            resultWingLabel.font = FontManager.regular(size: 14).uiFont
            resultWingLabel.isHidden = true
            resultWingLabel.numberOfLines = 0

        }
    }

    // MARK: MATH RESULT FOR LOAD CANOPY:

    private func giveCanopyResult(weightSkydiver: String, sizeCanopy: String) -> String {
        let result: Float = (Float(weightSkydiver) ?? 0.0) / 0.453 / (Float(sizeCanopy) ?? 0.0)
        return String(result)
    }
    
    // MARK: MATH RESULT FOR LOAD WING:
    
    private func giveWingResult(heightJump: String, heightOpen: String, quality: String, windSpeed: String) -> String {
        var result: Int = 0
        if quality == "0.0" {
            let height: Float = (Float(heightJump) ?? 0.0) - (Float(heightOpen) ?? 0.0)
            let time: Float = height / 50
            let resultFloat = ((Float(windSpeed) ?? 0.0) * 0.5) * time
            result = Int(resultFloat)
        } else {
            let height: Float = (Float(heightJump) ?? 0.0) - (Float(heightOpen) ?? 0.0)
            let time: Float = (height / 50) * (Float(quality) ?? 0.0)
            let resultFloat = height * (Float(quality) ?? 0.0) + ((Float(windSpeed) ?? 0.0) * 0.5) * time
            result = Int(resultFloat)
        }
        return String(result)
    }

    // MARK: TEXT INFO FOR LOAD CANOPY:

    private func writeTextInfo(_ result: String) -> String {
        let result = Double(result) ?? 0.0
        var text = ""
        if result < 0.6 {
            viewLoadCategoryA.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorLightBlue.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1-50A", comment: "")
        } else if result >= 0.61 && result <= 0.89 {
            viewLoadCategoryA.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorLightBlue.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1-50A", comment: "")
        } else if result >= 0.90 && result <= 1.28 {
            viewLoadCategoryB.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorGreen.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("51-200B", comment: "")
        } else if result >= 1.29 && result <= 1.49 {
            viewLoadCategoryC.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorYellow.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("201-500C", comment: "")
        } else if result >= 1.50 && result <= 2.0 {
            viewLoadCategoryD.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorOrange.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("501-1000D1", comment: "")
        } else if result >= 2.01 && result <= 2.8 {
            viewLoadCategoryD1.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorDarkRed.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1000D2", comment: "")
        } else if result >= 2.81 {
            viewLoadCategoryD2.isHidden = false
            canopyTextView.layer.shadowRadius = 100
            canopyTextView.layer.shadowColor = UIColor.colorDarkRed.cgColor
            canopyTextView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1000D3", comment: "")
        }
        return text
    }

    // MARK: ACTION BUTTON CANOPY SAVE:

    @objc private func actionButtonCanopySaveTap() {
        
        guard weightCanopyTextField.text != "" else {
            showCanopyError(textField: weightCanopyTextField)
            return
        }
        
        guard sizeCanopyTextField.text != "" else {
            showCanopyError(textField: sizeCanopyTextField)
            return
        }
        
        guard weightCanopyTextField.text != "",
              sizeCanopyTextField.text != "",
              weightCanopyTextField.text != "0",
              sizeCanopyTextField.text != "0"
        else {
            actionButtonCanopySaveRedColor()
            alertKitError()
            weightCanopyTextField.resignFirstResponder()
            sizeCanopyTextField.resignFirstResponder()
            return
        }

        viewLoadCategoryA.isHidden = true
        viewLoadCategoryB.isHidden = true
        viewLoadCategoryC.isHidden = true
        viewLoadCategoryD.isHidden = true
        viewLoadCategoryD1.isHidden = true
        viewLoadCategoryD2.isHidden = true

        resultCanopyLabel.isHidden = false
        resultCanopyLabel.text = giveCanopyResult(weightSkydiver: weightCanopyTextField.text ?? "", sizeCanopy: sizeCanopyTextField.text ?? "")

        resultCanopyTextLabel.text = writeTextInfo(resultCanopyLabel.text ?? "")
        canopyTextView.isHidden = false

        actionButtonCanopySaveGreenColor()
        playSoundSucces()
        cleanCanopyTextViews()
        resignCanopyFirstResponders()
        alertKitSuccess()
    }
    
    // MARK: ACTION BUTTON WING SAVE:
    
    @objc private func actionButtonWingSaveTap() {
        
        guard heightJumpTextField.text != "" else {
            showWingError(textField: heightJumpTextField)
            return
        }
        
        guard heightOpenTextField.text != "" else {
            showWingError(textField: heightOpenTextField)
            return
        }
        
        guard windSpeedTextField.text != "" else {
            showWingError(textField: windSpeedTextField)
            return
        }
        
        guard qualityTextField.text != "" else {
            showWingError(textField: qualityTextField)
            return
        }
        
        guard heightJumpTextField.text != "",
              heightOpenTextField.text != "",
              windSpeedTextField.text != "",
              qualityTextField.text != "",
              heightJumpTextField.text != "0",
              heightOpenTextField.text != "0",
              heightOpenTextField.text != "0",
              qualityTextField.text != "0"
        else {
            actionButtonWingSaveRedColor()
            alertKitError()
            heightJumpTextField.resignFirstResponder()
            heightOpenTextField.resignFirstResponder()
            windSpeedTextField.resignFirstResponder()
            qualityTextField.resignFirstResponder()
            return
        }
        resultWingView.isHidden = false
        resultWingLabel.isHidden = false
        resultWingLabel.text = NSLocalizedString("Distance / calculator", comment: "") + " = " + giveWingResult(heightJump: heightJumpTextField.text ?? "", heightOpen: heightOpenTextField.text ?? "", quality: qualityTextField.text ?? "", windSpeed: windSpeedTextField.text ?? "") + " " + NSLocalizedString("m.", comment: "")

        actionButtonWingSaveGreenColor()
        playSoundSucces()
        cleanWingTextViews()
        resignWingFirstResponders()
        alertKitSuccess()
        resetSelectPickerView()
    }

    // MARK: ACTION BUTTON CLEAN CANOPY:

    @objc private func actionButtonCleanCanopyTap() {
        actionButtonCanopyCleanChangeColor()
        cleanCanopyTextViews()
        resultCanopyLabel.isHidden = true
        canopyTextView.isHidden = true
        alertKitSuccess()
    }
    
    // MARK: ACTION BUTTON CLEAN WING:

    @objc private func actionButtonCleanWingTap() {
        actionButtonWingCleanChangeColor()
        cleanWingTextViews()
        resultWingView.isHidden = true
        resultWingLabel.isHidden = true
        alertKitSuccess()
    }

    // MARK: CLEAN ALL TEXT FIELDS CANOPY:

    private func cleanCanopyTextViews() {
        weightCanopyTextField.text = ""
        sizeCanopyTextField.text = ""
    }
    
    // MARK: CLEAN ALL TEXT FIELDS WING:
    
    private func cleanWingTextViews() {
        heightJumpTextField.text = ""
        heightOpenTextField.text = ""
        windSpeedTextField.text = ""
        qualityTextField.text = ""
    }

    // MARK: CLOSE ALL TEXT FIELDS CANOPY:

    private func resignCanopyFirstResponders() {
        weightCanopyTextField.resignFirstResponder()
        sizeCanopyTextField.resignFirstResponder()
    }
    
    // MARK: CLOSE ALL TEXT FIELDS WING:
    
    private func resignWingFirstResponders() {
        heightJumpTextField.resignFirstResponder()
        heightOpenTextField.resignFirstResponder()
        windSpeedTextField.resignFirstResponder()
        qualityTextField.resignFirstResponder()
    }

    // MARK: FUNCTIONS FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonCanopySaveGreenColor() {
        resultCanopyButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.resultCanopyButton.backgroundColor = .colorCell
        }
    }
    
    private func actionButtonWingSaveGreenColor() {
        resultWingButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.resultWingButton.backgroundColor = .colorCell
        }
    }

    private func actionButtonCanopySaveRedColor() {
        resultCanopyButton.backgroundColor = .colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.resultCanopyButton.backgroundColor = .colorCell
        }
    }
    
    private func actionButtonWingSaveRedColor() {
        resultWingButton.backgroundColor = .colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.resultWingButton.backgroundColor = .colorCell
        }
    }

    private func actionButtonCanopyCleanChangeColor() {
        cleanCanopyButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanCanopyButton.backgroundColor = .colorTabBar
        }
    }
    
    private func actionButtonWingCleanChangeColor() {
        cleanWingButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanWingButton.backgroundColor = .colorTabBar
        }
    }

    // MARK: PLAY CUSTOM SOUND FOR BUTTON SAVE:

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

    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
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
    
    // MARK: SHOW ERROR FOR EMPTY FIELDS CANOPY:
    
    private func showCanopyError(textField: UITextField) {
        textField.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            textField.backgroundColor = .colorTabBar
        }
        resignCanopyFirstResponders()
        actionButtonCanopySaveRedColor()
        alertKitError()
    }
    
    // MARK: SHOW ERROR FOR EMPTY FIELDS WING:
    
    private func showWingError(textField: UITextField) {
        textField.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            textField.backgroundColor = .colorTabBar
        }
        resignWingFirstResponders()
        actionButtonWingSaveRedColor()
        alertKitError()
    }
    
    // MARK: RESET SELECT PICKER VIEW:
    
    private func resetSelectPickerView() {
        windSpeedPickerView.selectRow(0, inComponent: 0, animated: true)
        qualityPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    // MARK: ALERT FOR CANOPY:
    
    @objc private func canopyAlertButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("Warning / calculator", comment: ""), message: NSLocalizedString("Warning canopy message / calculator", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: ALERT FOR WING:
    
    @objc private func wingAlertButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("Warning / calculator", comment: ""), message: NSLocalizedString("Warning wing message / calculator", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - EXTENSION:

extension CalculatorVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(page)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        VibrationManager.instance.vibrationStandart()
    }
}

extension CalculatorVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == windSpeedPickerView {
            return 1
        } else if pickerView == qualityPickerView {
            return 1
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == windSpeedPickerView {
            return windValues.count
        } else if pickerView == qualityPickerView {
            return qualityValues.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == windSpeedPickerView {
            return formatValue(windValues[row], expectedValue: nil)
        } else if pickerView == qualityPickerView {
            return formatValue(qualityValues[row], expectedValue: nil)
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == windSpeedPickerView {
            let selectedValue = windValues[row]
            windSpeedTextField.text = formatValue(selectedValue, expectedValue: nil)
        } else if pickerView == qualityPickerView {
            let selectedValue = qualityValues[row]
            qualityTextField.text = formatValue(selectedValue, expectedValue: nil)
        }
    }

    func formatValue(_ value: Float, expectedValue: Float?) -> String {
        if let expected = expectedValue, abs(value - expected) < 0.001 {
            return String(format: "%.1f", expected)
        } else {
            return String(format: "%.1f", value)
        }
    }

}

extension CalculatorVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "1234567890")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        VibrationManager.instance.vibrationStandart()
        if textField == windSpeedTextField {
            windSpeedTextField.text = String(windValues[0])
        } else if textField == qualityTextField {
            qualityTextField.text = String(qualityValues[0])
        }
    }
}
