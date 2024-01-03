import AudioToolbox
import AVFoundation
import Lottie
import UIKit

final class CalculatorVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let calculatorLottie = LottieAnimationView(name: "Calculator")
    private let weightTextField = UITextField()
    private let sizeCanopyTextField = UITextField()
    private let resultButton = UIButton()
    private let cleanButton = UIButton()
    private let resultLabel = UILabel()
    private let textView = UIView()
    private let textLabel = UILabel()
    private let vibrationOn = Vibration()
    private var player = AVAudioPlayer()

    private let viewLoadCategoryA = UIView()
    private let viewLoadCategoryB = UIView()
    private let viewLoadCategoryC = UIView()
    private let viewLoadCategoryD = UIView()
    private let viewLoadCategoryD1 = UIView()
    private let viewLoadCategoryD2 = UIView()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureGestures()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(calculatorLottie, weightTextField, sizeCanopyTextField, resultButton, cleanButton, resultLabel, textView)
        textView.addSubview(textLabel)
        resultLabel.addSubviews(viewLoadCategoryA, viewLoadCategoryB, viewLoadCategoryC, viewLoadCategoryD, viewLoadCategoryD1, viewLoadCategoryD2)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION:

        calculatorLottie.translatesAutoresizingMaskIntoConstraints = false
        calculatorLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        calculatorLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calculatorLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        calculatorLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

        // MARK: WEIGHT SKYDIVER:

        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.topAnchor.constraint(equalTo: calculatorLottie.bottomAnchor, constant: 30).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
        weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: SIZE CANOPY:

        sizeCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
        sizeCanopyTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 15).isActive = true
        sizeCanopyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sizeCanopyTextField.heightAnchor.constraint(equalToConstant: height40).isActive = true
        sizeCanopyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
        cleanButton.topAnchor.constraint(equalTo: sizeCanopyTextField.bottomAnchor, constant: 30).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        
        // MARK: RESULT BUTTON:

        resultButton.translatesAutoresizingMaskIntoConstraints = false
        resultButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
        resultButton.topAnchor.constraint(equalTo: sizeCanopyTextField.bottomAnchor, constant: 30).isActive = true
        resultButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        resultButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true

        // MARK: RESULT:

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.topAnchor.constraint(equalTo: cleanButton.bottomAnchor, constant: 30).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: INFO VIEW:

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: resultLabel.heightAnchor, multiplier: 6.5).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: INFO LABEL:

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: textView.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -10).isActive = true

        // MARK: VIE LOAD CATEGORY A:

        viewLoadCategoryA.translatesAutoresizingMaskIntoConstraints = false
        viewLoadCategoryA.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10).isActive = true
        viewLoadCategoryA.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: -5).isActive = true
        viewLoadCategoryA.heightAnchor.constraint(equalToConstant: 3).isActive = true
        viewLoadCategoryA.widthAnchor.constraint(equalTo: resultLabel.widthAnchor, multiplier: 0.16).isActive = true
        viewLoadCategoryA.backgroundColor = .systemBlue
        viewLoadCategoryA.isHidden = true

        // MARK: VIE LOAD CATEGORY B:

        viewLoadCategoryB.translatesAutoresizingMaskIntoConstraints = false
        viewLoadCategoryB.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10).isActive = true
        viewLoadCategoryB.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: -5).isActive = true
        viewLoadCategoryB.heightAnchor.constraint(equalToConstant: 3).isActive = true
        viewLoadCategoryB.widthAnchor.constraint(equalTo: resultLabel.widthAnchor, multiplier: 0.30).isActive = true
        viewLoadCategoryB.backgroundColor = .systemGreen
        viewLoadCategoryB.isHidden = true
        
        // MARK: VIE LOAD CATEGORY C:
        
        viewLoadCategoryC.translatesAutoresizingMaskIntoConstraints = false
        viewLoadCategoryC.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10).isActive = true
        viewLoadCategoryC.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: -5).isActive = true
        viewLoadCategoryC.heightAnchor.constraint(equalToConstant: 3).isActive = true
        viewLoadCategoryC.widthAnchor.constraint(equalTo: resultLabel.widthAnchor, multiplier: 0.45).isActive = true
        viewLoadCategoryC.backgroundColor = .systemYellow
        viewLoadCategoryC.isHidden = true
        
        // MARK: VIE LOAD CATEGORY D:
        
        viewLoadCategoryD.translatesAutoresizingMaskIntoConstraints = false
        viewLoadCategoryD.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10).isActive = true
        viewLoadCategoryD.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: -5).isActive = true
        viewLoadCategoryD.heightAnchor.constraint(equalToConstant: 3).isActive = true
        viewLoadCategoryD.widthAnchor.constraint(equalTo: resultLabel.widthAnchor, multiplier: 0.60).isActive = true
        viewLoadCategoryD.backgroundColor = .systemOrange
        viewLoadCategoryD.isHidden = true
        
        // MARK: VIE LOAD CATEGORY D1:
        
        viewLoadCategoryD1.translatesAutoresizingMaskIntoConstraints = false
        viewLoadCategoryD1.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10).isActive = true
        viewLoadCategoryD1.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: -5).isActive = true
        viewLoadCategoryD1.heightAnchor.constraint(equalToConstant: 3).isActive = true
        viewLoadCategoryD1.widthAnchor.constraint(equalTo: resultLabel.widthAnchor, multiplier: 0.80).isActive = true
        viewLoadCategoryD1.backgroundColor = .systemRed
        viewLoadCategoryD1.isHidden = true
        
        // MARK: VIE LOAD CATEGORY D2:
        
        viewLoadCategoryD2.translatesAutoresizingMaskIntoConstraints = false
        viewLoadCategoryD2.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10).isActive = true
        viewLoadCategoryD2.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: -5).isActive = true
        viewLoadCategoryD2.heightAnchor.constraint(equalToConstant: 3).isActive = true
        viewLoadCategoryD2.trailingAnchor.constraint(equalTo: resultLabel.trailingAnchor, constant: -10).isActive = true
        viewLoadCategoryD2.backgroundColor = .red
        viewLoadCategoryD2.isHidden = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground
        
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false

        // MARK: ANIMATION:

        calculatorLottie.play()
        calculatorLottie.loopMode = .loop

        // MARK: WEIGHT SKYDIVER:

        weightTextField.placeholder = "\(NSLocalizedString("Total weight", comment: "")) (\(NSLocalizedString("kg.", comment: "")))*"
        weightTextField.backgroundColor = colorTabBar
        weightTextField.font = fontMediumStandart14
        weightTextField.textColor = colorWhite
        weightTextField.layer.cornerRadius = cornerRadius10
        weightTextField.textAlignment = textAligmentCenter
        weightTextField.layer.borderWidth = borderWidth05
        weightTextField.layer.borderColor = colorWhiteCG
        weightTextField.setValue(colorWhite, forKeyPath: "textColor")
        weightTextField.layer.masksToBounds = true
        weightTextField.keyboardType = .numberPad
        weightTextField.returnKeyType = .done

        // MARK: SIZE CANOPY:

        sizeCanopyTextField.placeholder = "\(NSLocalizedString("Square canopy", comment: "")) (\(NSLocalizedString("ft", comment: "")))*"
        sizeCanopyTextField.backgroundColor = colorTabBar
        sizeCanopyTextField.font = fontMediumStandart14
        sizeCanopyTextField.textColor = colorWhite
        sizeCanopyTextField.layer.cornerRadius = cornerRadius10
        sizeCanopyTextField.textAlignment = textAligmentCenter
        sizeCanopyTextField.layer.borderWidth = borderWidth05
        sizeCanopyTextField.layer.borderColor = colorWhiteCG
        sizeCanopyTextField.setValue(colorWhite, forKeyPath: "textColor")
        sizeCanopyTextField.layer.masksToBounds = true
        sizeCanopyTextField.keyboardType = .numberPad
        sizeCanopyTextField.returnKeyType = .done

        // MARK: SAVE BUTTON:

        resultButton.setTitle(NSLocalizedString("Calculate", comment: ""), for: .normal)
        resultButton.backgroundColor = colorCell
        resultButton.layer.cornerRadius = cornerRadius10
        resultButton.setTitleColor(colorWhite, for: .normal)
        resultButton.titleLabel?.font = fontMediumStandart14
        resultButton.addTarget(self, action: #selector(actionButtonSaveTap), for: .touchUpInside)

        // MARK: CLEAN BUTTON:

        cleanButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
        cleanButton.backgroundColor = colorTabBar
        cleanButton.layer.cornerRadius = cornerRadius10
        cleanButton.setTitleColor(colorWhite, for: .normal)
        cleanButton.titleLabel?.font = fontMediumStandart14
        cleanButton.addTarget(self, action: #selector(actionButtonCleanTap), for: .touchUpInside)

        // MARK: RESULT:

        resultLabel.backgroundColor = colorTabBar
        resultLabel.textColor = colorWhite
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = cornerRadius10
        resultLabel.textAlignment = .center
        resultLabel.font = fontMediumStandart16
        resultLabel.isHidden = true
        
        // MARK: INFO VIEW:

        textView.backgroundColor = colorCell
        textView.layer.cornerRadius = cornerRadius10
        textView.isHidden = true

        // MARK: INFO LABEL:

        textLabel.textAlignment = .left
        textLabel.numberOfLines = numberOfLines0
        textLabel.font = fontCalculatorText
        textLabel.textColor = colorWhite
    }
    
    // MARK: CONFIGURE GESTURES:
    
    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    // MARK: - HELPERS:
    // MARK: FUNCTIONS FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonSaveGreenColor() {
        resultButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.resultButton.backgroundColor = colorCell
        }
    }

    private func actionButtonSaveRedColor() {
        resultButton.backgroundColor = colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.resultButton.backgroundColor = colorCell
        }
    }

    private func actionButtonCleanChangeColor() {
        cleanButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanButton.backgroundColor = colorTabBar
        }
    }

    // MARK: PLAY CUSTOM SOUND FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }

    // MARK: MATH RESULT FOR LOAD CANOPY:

    func giveCanopyResult(heightSkydiver: String, sizeCanopy: String) -> String {
        let result: Float = (Float(heightSkydiver) ?? 0.0) / 0.453 / (Float(sizeCanopy) ?? 0.0)
        return String(result)
    }

    // MARK: TEXT INFO FOR LOAD CANOPY:

    private func writeTextInfo(_ result: String) -> String {
        let result = Double(result) ?? 0.0
        var text = ""

        if result < 0.6 {
            viewLoadCategoryA.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorBlueCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1-50A", comment: "")
        } else if result >= 0.61 && result <= 0.89 {
            viewLoadCategoryA.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorBlueCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1-50A", comment: "")
        } else if result >= 0.90 && result <= 1.28 {
            viewLoadCategoryB.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorGreenCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("51-200B", comment: "")
        } else if result >= 1.29 && result <= 1.49 {
            viewLoadCategoryC.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorYellowCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("201-500C", comment: "")
        } else if result >= 1.50 && result <= 2.0 {
            viewLoadCategoryD.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorOrangeCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("501-1000D1", comment: "")
        } else if result >= 2.01 && result <= 2.8 {
            viewLoadCategoryD1.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorRedCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1000D2", comment: "")
        } else if result >= 2.81 {
            viewLoadCategoryD2.isHidden = false
            textView.layer.shadowRadius = 100
            textView.layer.shadowColor = colorRedCG
            textView.layer.shadowOpacity = 0.5
            text = NSLocalizedString("1000D3", comment: "")
        }
        return text
    }

    // MARK: ACTION BUTTON SAVE:

    @objc func actionButtonSaveTap() {
        guard weightTextField.text != "",
              sizeCanopyTextField.text != "",
              weightTextField.text != "0",
              sizeCanopyTextField.text != "0"
        else {
            actionButtonSaveRedColor()
            vibrationOn.vibrationError()
            weightTextField.resignFirstResponder()
            sizeCanopyTextField.resignFirstResponder()
            return
        }

        viewLoadCategoryA.isHidden = true
        viewLoadCategoryB.isHidden = true
        viewLoadCategoryC.isHidden = true
        viewLoadCategoryD.isHidden = true
        viewLoadCategoryD1.isHidden = true
        viewLoadCategoryD2.isHidden = true

        resultLabel.isHidden = false
        resultLabel.text = giveCanopyResult(heightSkydiver: weightTextField.text ?? "", sizeCanopy: sizeCanopyTextField.text ?? "")

        textLabel.text = writeTextInfo(resultLabel.text ?? "")
        textView.isHidden = false

        actionButtonSaveGreenColor()
        vibrationOn.vibrationSucces()
        playSoundSucces()
        weightTextField.text = ""
        sizeCanopyTextField.text = ""
        weightTextField.resignFirstResponder()
        sizeCanopyTextField.resignFirstResponder()
    }

    // MARK: ACTION BUTTON CLEAN:

    @objc func actionButtonCleanTap() {
        actionButtonCleanChangeColor()
        vibrationOn.vibrationSucces()
        weightTextField.text = ""
        sizeCanopyTextField.text = ""
        resultLabel.isHidden = true
        textView.isHidden = true
        weightTextField.resignFirstResponder()
        sizeCanopyTextField.resignFirstResponder()
    }
}
