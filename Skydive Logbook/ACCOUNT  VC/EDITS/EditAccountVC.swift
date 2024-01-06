import AudioToolbox
import AVFoundation
import UIKit

final class EditAccountVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let nicknameButton = UIButton()
    private let nicknameTextField = UITextField()
    
    private let licenseTypeButton = UIButton()
    private let licenseTypeTextField = UITextField()
    
    private let licenseDateButton = UIButton()
    private let licenseDateTextField = UITextField()
    
    private let medicineButton = UIButton()
    private let medicineTextField = UITextField()
    private let insuranceButton = UIButton()
    private let insuranceTextField = UITextField()
    private let reserveCanopyButton = UIButton()
    private let reserveCanopyTextField = UITextField()
    private let saveButton = UIButton()
    private let vibrationOn = Vibration()
    private var player = AVAudioPlayer()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureGestures()
        configureAccount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAccount()
    }
    
    // MARK: - ADD SUBVIEWS:

    func addSubviews() {
        view.addSubviews(nicknameButton, licenseTypeButton, licenseDateButton, medicineButton, insuranceButton, reserveCanopyButton, saveButton)
        licenseTypeButton.addSubview(licenseTypeTextField)
        licenseDateButton.addSubview(licenseDateTextField)
        nicknameButton.addSubview(nicknameTextField)
        medicineButton.addSubview(medicineTextField)
        insuranceButton.addSubview(insuranceTextField)
        reserveCanopyButton.addSubview(reserveCanopyTextField)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: NICKNAME:
        
        nicknameButton.translatesAutoresizingMaskIntoConstraints = false
        nicknameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        nicknameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nicknameButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        nicknameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.bottomAnchor.constraint(equalTo: nicknameButton.bottomAnchor).isActive = true
        nicknameTextField.leadingAnchor.constraint(equalTo: nicknameButton.leadingAnchor).isActive = true
        nicknameTextField.trailingAnchor.constraint(equalTo: nicknameButton.trailingAnchor).isActive = true
        nicknameTextField.heightAnchor.constraint(equalTo: nicknameButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: LICENSE TYPE:
        
        licenseTypeButton.translatesAutoresizingMaskIntoConstraints = false
        licenseTypeButton.topAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 15).isActive = true
        licenseTypeButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        licenseTypeButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        licenseTypeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.327).isActive = true
        
        licenseTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        licenseTypeTextField.bottomAnchor.constraint(equalTo: licenseTypeButton.bottomAnchor).isActive = true
        licenseTypeTextField.leadingAnchor.constraint(equalTo: licenseTypeButton.leadingAnchor).isActive = true
        licenseTypeTextField.trailingAnchor.constraint(equalTo: licenseTypeButton.trailingAnchor).isActive = true
        licenseTypeTextField.heightAnchor.constraint(equalTo: licenseTypeButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: LICENSE DATE:
        
        licenseDateButton.translatesAutoresizingMaskIntoConstraints = false
        licenseDateButton.topAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 15).isActive = true
        licenseDateButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
        licenseDateButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        licenseDateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.327).isActive = true
        
        licenseDateTextField.translatesAutoresizingMaskIntoConstraints = false
        licenseDateTextField.bottomAnchor.constraint(equalTo: licenseDateButton.bottomAnchor).isActive = true
        licenseDateTextField.leadingAnchor.constraint(equalTo: licenseDateButton.leadingAnchor).isActive = true
        licenseDateTextField.trailingAnchor.constraint(equalTo: licenseDateButton.trailingAnchor).isActive = true
        licenseDateTextField.heightAnchor.constraint(equalTo: licenseDateButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: MEDICINE:
        
        medicineButton.translatesAutoresizingMaskIntoConstraints = false
        medicineButton.topAnchor.constraint(equalTo: licenseTypeButton.bottomAnchor, constant: 15).isActive = true
        medicineButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        medicineButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        medicineButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        medicineTextField.translatesAutoresizingMaskIntoConstraints = false
        medicineTextField.bottomAnchor.constraint(equalTo: medicineButton.bottomAnchor).isActive = true
        medicineTextField.leadingAnchor.constraint(equalTo: medicineButton.leadingAnchor).isActive = true
        medicineTextField.trailingAnchor.constraint(equalTo: medicineButton.trailingAnchor).isActive = true
        medicineTextField.heightAnchor.constraint(equalTo: medicineButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: INSURANCE:
        
        insuranceButton.translatesAutoresizingMaskIntoConstraints = false
        insuranceButton.topAnchor.constraint(equalTo: medicineButton.bottomAnchor, constant: 15).isActive = true
        insuranceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        insuranceButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        insuranceButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        insuranceTextField.translatesAutoresizingMaskIntoConstraints = false
        insuranceTextField.bottomAnchor.constraint(equalTo: insuranceButton.bottomAnchor).isActive = true
        insuranceTextField.leadingAnchor.constraint(equalTo: insuranceButton.leadingAnchor).isActive = true
        insuranceTextField.trailingAnchor.constraint(equalTo: insuranceButton.trailingAnchor).isActive = true
        insuranceTextField.heightAnchor.constraint(equalTo: insuranceButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyButton.topAnchor.constraint(equalTo: insuranceButton.bottomAnchor, constant: 15).isActive = true
        reserveCanopyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reserveCanopyButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        reserveCanopyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        reserveCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyTextField.bottomAnchor.constraint(equalTo: reserveCanopyButton.bottomAnchor).isActive = true
        reserveCanopyTextField.leadingAnchor.constraint(equalTo: reserveCanopyButton.leadingAnchor).isActive = true
        reserveCanopyTextField.trailingAnchor.constraint(equalTo: reserveCanopyButton.trailingAnchor).isActive = true
        reserveCanopyTextField.heightAnchor.constraint(equalTo: reserveCanopyButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: SAVE BUTTOM:
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: reserveCanopyTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = colorBackground
        
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: NICKNAME:
        
        nicknameButton.setTitle("Никнейм", for: .normal)
        nicknameButton.backgroundColor = colorCell
        nicknameButton.setTitleColor(colorLightGray, for: .normal)
        nicknameButton.contentVerticalAlignment = textAligmentTop
        nicknameButton.titleLabel?.font = fontMediumStandart12
        nicknameButton.layer.cornerRadius = cornerRadius10
        nicknameTextField.placeholder = "Имя пользователя"
        nicknameTextField.backgroundColor = colorTabBar
        nicknameTextField.font = fontMediumStandart18
        nicknameTextField.textColor = colorWhite
        nicknameTextField.layer.cornerRadius = cornerRadius10
        nicknameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        nicknameTextField.textAlignment = textAligmentCenter
        nicknameTextField.tintColor = colorWhite
        nicknameTextField.layer.masksToBounds = true
        
        // MARK: LICENSE TYPE:
        
        licenseTypeButton.setTitle("Лицензия", for: .normal)
        licenseTypeButton.backgroundColor = colorCell
        licenseTypeButton.setTitleColor(colorLightGray, for: .normal)
        licenseTypeButton.contentVerticalAlignment = textAligmentTop
        licenseTypeButton.titleLabel?.font = fontMediumStandart12
        licenseTypeButton.layer.cornerRadius = cornerRadius10
        licenseTypeTextField.placeholder = "Тип/номер"
        licenseTypeTextField.backgroundColor = colorTabBar
        licenseTypeTextField.font = fontMediumStandart18
        licenseTypeTextField.textColor = colorWhite
        licenseTypeTextField.layer.cornerRadius = cornerRadius10
        licenseTypeTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        licenseTypeTextField.textAlignment = textAligmentCenter
        licenseTypeTextField.tintColor = colorWhite
        licenseTypeTextField.layer.masksToBounds = true
        
        // MARK: LICENSE DATE:
        
        licenseDateButton.setTitle("Действительна до", for: .normal)
        licenseDateButton.backgroundColor = colorCell
        licenseDateButton.setTitleColor(colorLightGray, for: .normal)
        licenseDateButton.contentVerticalAlignment = textAligmentTop
        licenseDateButton.titleLabel?.font = fontMediumStandart12
        licenseDateButton.layer.cornerRadius = cornerRadius10
        licenseDateTextField.placeholder = "мм.дд.гггг"
        licenseDateTextField.backgroundColor = colorTabBar
        licenseDateTextField.font = fontMediumStandart18
        licenseDateTextField.textColor = colorWhite
        licenseDateTextField.layer.cornerRadius = cornerRadius10
        licenseDateTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        licenseDateTextField.textAlignment = textAligmentCenter
        licenseDateTextField.tintColor = colorWhite
        licenseDateTextField.layer.masksToBounds = true
        
        
        // MARK: MEDICINE:
        
        medicineButton.setTitle("Медицина действительна до:", for: .normal)
        medicineButton.backgroundColor = colorCell
        medicineButton.setTitleColor(colorLightGray, for: .normal)
        medicineButton.contentVerticalAlignment = textAligmentTop
        medicineButton.titleLabel?.font = fontMediumStandart12
        medicineButton.layer.cornerRadius = cornerRadius10
        medicineTextField.placeholder = "мм.дд.гггг"
        medicineTextField.backgroundColor = colorTabBar
        medicineTextField.font = fontMediumStandart18
        medicineTextField.textColor = colorWhite
        medicineTextField.layer.cornerRadius = cornerRadius10
        medicineTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        medicineTextField.textAlignment = textAligmentCenter
        medicineTextField.tintColor = colorWhite
        medicineTextField.layer.masksToBounds = true
        
        // MARK: INSURANCE:
        
        insuranceButton.setTitle("Страховка действительна до:", for: .normal)
        insuranceButton.backgroundColor = colorCell
        insuranceButton.setTitleColor(colorLightGray, for: .normal)
        insuranceButton.contentVerticalAlignment = textAligmentTop
        insuranceButton.titleLabel?.font = fontMediumStandart12
        insuranceButton.layer.cornerRadius = cornerRadius10
        insuranceTextField.placeholder = "мм.дд.гггг"
        insuranceTextField.backgroundColor = colorTabBar
        insuranceTextField.font = fontMediumStandart18
        insuranceTextField.textColor = colorWhite
        insuranceTextField.layer.cornerRadius = cornerRadius10
        insuranceTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        insuranceTextField.textAlignment = textAligmentCenter
        insuranceTextField.tintColor = colorWhite
        insuranceTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyButton.setTitle("Запасной действителен до:", for: .normal)
        reserveCanopyButton.backgroundColor = colorCell
        reserveCanopyButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopyButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyButton.titleLabel?.font = fontMediumStandart12
        reserveCanopyButton.layer.cornerRadius = cornerRadius10
        reserveCanopyTextField.placeholder = "дд.мм.гггг"
        reserveCanopyTextField.backgroundColor = colorTabBar
        reserveCanopyTextField.font = fontMediumStandart18
        reserveCanopyTextField.textColor = colorWhite
        reserveCanopyTextField.layer.cornerRadius = cornerRadius10
        reserveCanopyTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyTextField.textAlignment = textAligmentCenter
        reserveCanopyTextField.tintColor = colorWhite
        reserveCanopyTextField.layer.masksToBounds = true
        
        // MARK: SAVE BUTTOM:
        
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.backgroundColor = colorCell
        saveButton.layer.cornerRadius = cornerRadius10
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = fontMediumStandart14
        saveButton.addTarget(self, action: #selector(tapOnSaveButtom), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE GESTURES:
    
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE ACCOUNT:

    private func configureAccount() {
        if arrayAccount.count == 0 {
            nicknameTextField.text = ""
            licenseDateTextField.text = ""
            licenseDateTextField.text = ""
            medicineTextField.text = ""
            insuranceTextField.text = ""
            reserveCanopyTextField.text = ""
        } else {
            nicknameTextField.text = arrayAccount[0].nickname
            licenseTypeTextField.text = arrayAccount[0].licenseType
            licenseDateTextField.text = arrayAccount[0].licenseDate
            medicineTextField.text = arrayAccount[0].medicine
            insuranceTextField.text = arrayAccount[0].insurance
            reserveCanopyTextField.text = arrayAccount[0].reserveCanopy
        }
    }
    
    // MARK: ACTION BUTTON SAVE:
    
    @objc private func tapOnSaveButtom() {
        saveNewAccount()
        resignFirstResponders()
        actionButtonSaveGreenColor()
        vibrationOn.vibrationSucces()
        playSoundSucces()
    }
    
    // MARK: SAVE FUNC:

    private func saveNewAccount() {
        let account = AccountStructure(nickname: nicknameTextField.text ?? "", licenseType: licenseTypeTextField.text ?? "", licenseDate: licenseDateTextField.text ?? "", medicine: medicineTextField.text ?? "", insurance: insuranceTextField.text ?? "", reserveCanopy: reserveCanopyTextField.text ?? "")
        
        if arrayAccount.count == 0 {
            arrayAccount.insert(account, at: 0)
        } else {
            arrayAccount.remove(at: 0)
            arrayAccount.insert(account, at: 0)
        }
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        nicknameTextField.resignFirstResponder()
        medicineTextField.resignFirstResponder()
        insuranceTextField.resignFirstResponder()
        reserveCanopyTextField.resignFirstResponder()
    }
    
    // MARK: CHANGE COLORS BUTTON "SAVE":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = colorCell
        }
    }
    
    // MARK: PLAY SOUND BUTTON "SAVE":

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    // MARK: GESTURES:

    @objc func tapGestureDone() {
        view.endEditing(true)
    }
}
