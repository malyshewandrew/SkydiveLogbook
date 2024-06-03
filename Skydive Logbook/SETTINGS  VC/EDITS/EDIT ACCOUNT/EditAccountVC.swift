import AlertKit
import AudioToolbox
import AVFoundation
import RealmSwift
import UIKit
import Lottie

final class EditAccountVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let editAccountLottie = LottieAnimationView(name: "EditAccount")
    private let scrollView = UIScrollView()
    private let nicknameButton = UIButton()
    private let nicknameTextField = UITextField()
    private let licenseTypeButton = UIButton()
    private let licenseTypeTextField = UITextField()
    private let licenseDateButton = UIButton()
    private let licenseDateTextField = UITextField()
    private let licenseDatePicker = UIDatePicker()
    private let medicineButton = UIButton()
    private let medicineTextField = UITextField()
    private let medicineDatePicker = UIDatePicker()
    private let insuranceButton = UIButton()
    private let insuranceTextField = UITextField()
    private let insuranceDatePicker = UIDatePicker()
    private let reserveCanopyButton = UIButton()
    private let reserveCanopyTextField = UITextField()
    private let reserveCanopyDatePicker = UIDatePicker()
    private let cleanButton = UIButton()
    private let saveButton = UIButton()
    private var player = AVAudioPlayer()
    private let realmManager = RealmManager()
    private let account = AccountClassRealm()
    private let vibrationOn = Vibration()
    private let dateFormatter = DateFormatter()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureGestures()
        nicknameTextField.delegate = self
        licenseTypeTextField.delegate = self
        licenseDateTextField.delegate = self
        medicineTextField.delegate = self
        insuranceTextField.delegate = self
        reserveCanopyTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAccount()
        configureAccount()
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(editAccountLottie, scrollView)
        scrollView.addSubviews(nicknameButton, licenseTypeButton, licenseDateButton, medicineButton, insuranceButton, reserveCanopyButton, cleanButton, saveButton)
        licenseTypeButton.addSubviews(licenseTypeTextField)
        licenseDateButton.addSubviews(licenseDateTextField)
        nicknameButton.addSubviews(nicknameTextField)
        medicineButton.addSubviews(medicineTextField)
        insuranceButton.addSubviews(insuranceTextField)
        reserveCanopyButton.addSubviews(reserveCanopyTextField)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: ANIMATION:

        editAccountLottie.translatesAutoresizingMaskIntoConstraints = false
        editAccountLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        editAccountLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editAccountLottie.heightAnchor.constraint(equalToConstant: 100).isActive = true
        editAccountLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        // MARK: SCROLL VIEW:
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: editAccountLottie.bottomAnchor, constant: -10).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: NICKNAME:
        
        nicknameButton.translatesAutoresizingMaskIntoConstraints = false
        nicknameButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5).isActive = true
        nicknameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nicknameButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        nicknameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.bottomAnchor.constraint(equalTo: nicknameButton.bottomAnchor).isActive = true
        nicknameTextField.leadingAnchor.constraint(equalTo: nicknameButton.leadingAnchor).isActive = true
        nicknameTextField.trailingAnchor.constraint(equalTo: nicknameButton.trailingAnchor).isActive = true
        nicknameTextField.heightAnchor.constraint(equalTo: nicknameButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: LICENSE TYPE:
        
        licenseTypeButton.translatesAutoresizingMaskIntoConstraints = false
        licenseTypeButton.topAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 15).isActive = true
        licenseTypeButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
        licenseTypeButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        licenseTypeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        
        licenseTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        licenseTypeTextField.bottomAnchor.constraint(equalTo: licenseTypeButton.bottomAnchor).isActive = true
        licenseTypeTextField.leadingAnchor.constraint(equalTo: licenseTypeButton.leadingAnchor).isActive = true
        licenseTypeTextField.trailingAnchor.constraint(equalTo: licenseTypeButton.trailingAnchor).isActive = true
        licenseTypeTextField.heightAnchor.constraint(equalTo: licenseTypeButton.heightAnchor, multiplier: 0.6).isActive = true
        
        // MARK: LICENSE DATE:
        
        licenseDateButton.translatesAutoresizingMaskIntoConstraints = false
        licenseDateButton.topAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 15).isActive = true
        licenseDateButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
        licenseDateButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        licenseDateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
        
        licenseDateTextField.translatesAutoresizingMaskIntoConstraints = false
        licenseDateTextField.bottomAnchor.constraint(equalTo: licenseDateButton.bottomAnchor).isActive = true
        licenseDateTextField.leadingAnchor.constraint(equalTo: licenseDateButton.leadingAnchor).isActive = true
        licenseDateTextField.trailingAnchor.constraint(equalTo: licenseDateButton.trailingAnchor).isActive = true
        licenseDateTextField.heightAnchor.constraint(equalTo: licenseDateButton.heightAnchor, multiplier: 0.6).isActive = true
        
        licenseDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: MEDICINE:
        
        medicineButton.translatesAutoresizingMaskIntoConstraints = false
        medicineButton.topAnchor.constraint(equalTo: licenseTypeButton.bottomAnchor, constant: 15).isActive = true
        medicineButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        medicineButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        medicineButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        medicineTextField.translatesAutoresizingMaskIntoConstraints = false
        medicineTextField.bottomAnchor.constraint(equalTo: medicineButton.bottomAnchor).isActive = true
        medicineTextField.leadingAnchor.constraint(equalTo: medicineButton.leadingAnchor).isActive = true
        medicineTextField.trailingAnchor.constraint(equalTo: medicineButton.trailingAnchor).isActive = true
        medicineTextField.heightAnchor.constraint(equalTo: medicineButton.heightAnchor, multiplier: 0.6).isActive = true
        
        medicineDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: INSURANCE:
        
        insuranceButton.translatesAutoresizingMaskIntoConstraints = false
        insuranceButton.topAnchor.constraint(equalTo: medicineButton.bottomAnchor, constant: 15).isActive = true
        insuranceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        insuranceButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        insuranceButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        insuranceTextField.translatesAutoresizingMaskIntoConstraints = false
        insuranceTextField.bottomAnchor.constraint(equalTo: insuranceButton.bottomAnchor).isActive = true
        insuranceTextField.leadingAnchor.constraint(equalTo: insuranceButton.leadingAnchor).isActive = true
        insuranceTextField.trailingAnchor.constraint(equalTo: insuranceButton.trailingAnchor).isActive = true
        insuranceTextField.heightAnchor.constraint(equalTo: insuranceButton.heightAnchor, multiplier: 0.6).isActive = true
        
        insuranceDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyButton.topAnchor.constraint(equalTo: insuranceButton.bottomAnchor, constant: 15).isActive = true
        reserveCanopyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reserveCanopyButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        reserveCanopyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        reserveCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyTextField.bottomAnchor.constraint(equalTo: reserveCanopyButton.bottomAnchor).isActive = true
        reserveCanopyTextField.leadingAnchor.constraint(equalTo: reserveCanopyButton.leadingAnchor).isActive = true
        reserveCanopyTextField.trailingAnchor.constraint(equalTo: reserveCanopyButton.trailingAnchor).isActive = true
        reserveCanopyTextField.heightAnchor.constraint(equalTo: reserveCanopyButton.heightAnchor, multiplier: 0.6).isActive = true
        
        reserveCanopyDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.topAnchor.constraint(equalTo: reserveCanopyTextField.bottomAnchor, constant: 15).isActive = true
        cleanButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
        
        // MARK: SAVE BUTTOM:
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: reserveCanopyTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = false
        
        // MARK: ANIMATION:

        editAccountLottie.play()
        editAccountLottie.loopMode = .loop
        
        // MARK: SCROLL VIEW:
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.isScrollEnabled = true
        
        // MARK: NICKNAME:
        
        nicknameButton.setTitle(NSLocalizedString("Nickname / edit account vc", comment: "") + ":", for: .normal)
        nicknameButton.backgroundColor = .colorCell
        nicknameButton.setTitleColor(.colorLightGray, for: .normal)
        nicknameButton.contentVerticalAlignment = textAligmentTop
        nicknameButton.titleLabel?.font = fontMediumStandard12
        nicknameButton.layer.cornerRadius = cornerRadius15
        nicknameTextField.placeholder = NSLocalizedString("Name user / edit account vc", comment: "")
        nicknameTextField.backgroundColor = .colorTabBar
        nicknameTextField.font = fontMediumStandard18
        nicknameTextField.textColor = .colorWhite
        nicknameTextField.layer.cornerRadius = cornerRadius15
        nicknameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        nicknameTextField.textAlignment = textAligmentCenter
        nicknameTextField.tintColor = .colorWhite
        nicknameTextField.layer.masksToBounds = true
        
        // MARK: LICENSE TYPE:
        
        licenseTypeButton.setTitle(NSLocalizedString("License / edit account vc", comment: "") + ":", for: .normal)
        licenseTypeButton.backgroundColor = .colorCell
        licenseTypeButton.setTitleColor(.colorLightGray, for: .normal)
        licenseTypeButton.contentVerticalAlignment = textAligmentTop
        licenseTypeButton.titleLabel?.font = fontMediumStandard12
        licenseTypeButton.layer.cornerRadius = cornerRadius15
        licenseTypeTextField.placeholder = NSLocalizedString("Type / number / edit account vc", comment: "")
        licenseTypeTextField.backgroundColor = .colorTabBar
        licenseTypeTextField.font = fontMediumStandard18
        licenseTypeTextField.textColor = .colorWhite
        licenseTypeTextField.layer.cornerRadius = cornerRadius15
        licenseTypeTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        licenseTypeTextField.textAlignment = textAligmentCenter
        licenseTypeTextField.tintColor = .colorWhite
        licenseTypeTextField.layer.masksToBounds = true
        
        // MARK: LICENSE DATE:
        
        licenseDateButton.setTitle(NSLocalizedString("Valid until / edit account vc", comment: "") + ":", for: .normal)
        licenseDateButton.backgroundColor = .colorCell
        licenseDateButton.setTitleColor(.colorLightGray, for: .normal)
        licenseDateButton.contentVerticalAlignment = textAligmentTop
        licenseDateButton.titleLabel?.font = fontMediumStandard12
        licenseDateButton.layer.cornerRadius = cornerRadius15
        licenseDateTextField.placeholder = NSLocalizedString("Date / dd.mm.yyyy / edit account vc", comment: "")
        licenseDateTextField.backgroundColor = .colorTabBar
        licenseDateTextField.font = fontMediumStandard18
        licenseDateTextField.textColor = .colorWhite
        licenseDateTextField.layer.cornerRadius = cornerRadius15
        licenseDateTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        licenseDateTextField.textAlignment = textAligmentCenter
        licenseDateTextField.tintColor = .colorWhite
        licenseDateTextField.layer.masksToBounds = true
        licenseDateTextField.inputView = licenseDatePicker
        licenseDatePicker.datePickerMode = .date
        licenseDatePicker.preferredDatePickerStyle = .wheels
        licenseDatePicker.backgroundColor = .colorTabBar
        licenseDatePicker.addTarget(self, action: #selector(licenseDatePickerValueChanged), for: .valueChanged)
        
        // MARK: MEDICINE:
        
        medicineButton.setTitle(NSLocalizedString("Medicine / edit account vc", comment: "") + ":", for: .normal)
        medicineButton.backgroundColor = .colorCell
        medicineButton.setTitleColor(.colorLightGray, for: .normal)
        medicineButton.contentVerticalAlignment = textAligmentTop
        medicineButton.titleLabel?.font = fontMediumStandard12
        medicineButton.layer.cornerRadius = cornerRadius15
        medicineTextField.placeholder = NSLocalizedString("Date / dd.mm.yyyy / edit account vc", comment: "")
        medicineTextField.backgroundColor = .colorTabBar
        medicineTextField.font = fontMediumStandard18
        medicineTextField.textColor = .colorWhite
        medicineTextField.layer.cornerRadius = cornerRadius15
        medicineTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        medicineTextField.textAlignment = textAligmentCenter
        medicineTextField.tintColor = .colorWhite
        medicineTextField.layer.masksToBounds = true
        medicineTextField.inputView = medicineDatePicker
        medicineDatePicker.datePickerMode = .date
        medicineDatePicker.preferredDatePickerStyle = .wheels
        medicineDatePicker.backgroundColor = .colorTabBar
        medicineDatePicker.addTarget(self, action: #selector(medicineDatePickerValueChanged), for: .valueChanged)
        
        // MARK: INSURANCE:
        
        insuranceButton.setTitle(NSLocalizedString("Insurance / edit account vc", comment: "") + ":", for: .normal)
        insuranceButton.backgroundColor = .colorCell
        insuranceButton.setTitleColor(.colorLightGray, for: .normal)
        insuranceButton.contentVerticalAlignment = textAligmentTop
        insuranceButton.titleLabel?.font = fontMediumStandard12
        insuranceButton.layer.cornerRadius = cornerRadius15
        insuranceTextField.placeholder = NSLocalizedString("Date / dd.mm.yyyy / edit account vc", comment: "")
        insuranceTextField.backgroundColor = .colorTabBar
        insuranceTextField.font = fontMediumStandard18
        insuranceTextField.textColor = .colorWhite
        insuranceTextField.layer.cornerRadius = cornerRadius15
        insuranceTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        insuranceTextField.textAlignment = textAligmentCenter
        insuranceTextField.tintColor = .colorWhite
        insuranceTextField.layer.masksToBounds = true
        insuranceTextField.inputView = insuranceDatePicker
        insuranceDatePicker.datePickerMode = .date
        insuranceDatePicker.preferredDatePickerStyle = .wheels
        insuranceDatePicker.backgroundColor = .colorTabBar
        insuranceDatePicker.addTarget(self, action: #selector(insuranceDatePickerValueChanged), for: .valueChanged)
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyButton.setTitle(NSLocalizedString("Reserve canopy / edit account vc", comment: "") + ":", for: .normal)
        reserveCanopyButton.backgroundColor = .colorCell
        reserveCanopyButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopyButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyButton.titleLabel?.font = fontMediumStandard12
        reserveCanopyButton.layer.cornerRadius = cornerRadius15
        reserveCanopyTextField.placeholder = NSLocalizedString("Date / dd.mm.yyyy / edit account vc", comment: "")
        reserveCanopyTextField.backgroundColor = .colorTabBar
        reserveCanopyTextField.font = fontMediumStandard18
        reserveCanopyTextField.textColor = .colorWhite
        reserveCanopyTextField.layer.cornerRadius = cornerRadius15
        reserveCanopyTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyTextField.textAlignment = textAligmentCenter
        reserveCanopyTextField.tintColor = .colorWhite
        reserveCanopyTextField.layer.masksToBounds = true
        reserveCanopyTextField.inputView = reserveCanopyDatePicker
        reserveCanopyDatePicker.datePickerMode = .date
        reserveCanopyDatePicker.preferredDatePickerStyle = .wheels
        reserveCanopyDatePicker.backgroundColor = .colorTabBar
        reserveCanopyDatePicker.addTarget(self, action: #selector(reserveCanopyDatePickerValueChanged), for: .valueChanged)
        
        // MARK: CLEAN BUTTON:

        cleanButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
        cleanButton.backgroundColor = .colorTabBar
        cleanButton.titleLabel?.font = fontMediumStandard14
        cleanButton.setTitleColor(.colorWhite, for: .normal)
        cleanButton.setTitleColor(.systemBlue, for: .highlighted)
        cleanButton.layer.cornerRadius = cornerRadius15
        cleanButton.addTarget(self, action: #selector(cleanButtonTapped), for: .touchUpInside)
        
        // MARK: SAVE BUTTOM:
        
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.backgroundColor = .colorCell
        saveButton.layer.cornerRadius = cornerRadius15
        saveButton.setTitleColor(.colorWhite, for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .highlighted)
        saveButton.titleLabel?.font = fontMediumStandard14
        saveButton.addTarget(self, action: #selector(saveButtomTapped), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE GESTURES:
    
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - LOAD ACCOUNT FROM REALM:
    
    private func loadAccount() {
        arrayAccountRealm = realmManager.localRealm.objects(AccountClassRealm.self).map { $0 }
    }
    
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE ACCOUNT:

    private func configureAccount() {
        if let account = arrayAccountRealm.first {
            nicknameTextField.text = account.nickname.isEmpty ? "" : account.nickname
            licenseTypeTextField.text = account.licenseType.isEmpty ? "" : account.licenseType
            licenseDateTextField.text = account.licenseDate.isEmpty ? "" : account.licenseDate
            medicineTextField.text = account.medicine.isEmpty ? "" : account.medicine
            insuranceTextField.text = account.insurance.isEmpty ? "" : account.insurance
            reserveCanopyTextField.text = account.reserveCanopy.isEmpty ? "" : account.reserveCanopy
        } else {
            nicknameTextField.text = ""
            licenseTypeTextField.text = ""
            licenseDateTextField.text = ""
            medicineTextField.text = ""
            insuranceTextField.text = ""
            reserveCanopyTextField.text = ""
        }
    }

    // MARK: ACTION BUTTON SAVE:
    
    @objc private func saveButtomTapped() {
        saveNewAccount()
        DispatchQueue.main.async {
            self.resignFirstResponders()
            self.actionButtonSaveGreenColor()
            self.playSoundSucces()
            self.alertKitSuccess()
        }
    }
    
    // MARK: SAVE FUNC:

    private func saveNewAccount() {
        
        let existingAccounts = realmManager.localRealm.objects(AccountClassRealm.self)
        try? realmManager.localRealm.write {
            realmManager.localRealm.delete(existingAccounts)
            let newAccount = AccountClassRealm()
            newAccount.nickname = nicknameTextField.text ?? ""
            newAccount.licenseType = licenseTypeTextField.text ?? ""
            newAccount.licenseDate = licenseDateTextField.text ?? ""
            newAccount.medicine = medicineTextField.text ?? ""
            newAccount.insurance = insuranceTextField.text ?? ""
            newAccount.reserveCanopy = reserveCanopyTextField.text ?? ""
            realmManager.localRealm.add(newAccount, update: .all)
        }


    }
    
    // MARK: ACTION FOR TAP ON CLEAN BUTTON:

    @objc private func cleanButtonTapped() {
        nicknameTextField.text = ""
        licenseTypeTextField.text = ""
        licenseDateTextField.text = ""
        medicineTextField.text = ""
        insuranceTextField.text = ""
        reserveCanopyTextField.text = ""
        actionButtonCleanChangeColor()
        resignFirstResponders()
        alertKitClear()
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        nicknameTextField.resignFirstResponder()
        licenseTypeTextField.resignFirstResponder()
        licenseDateTextField.resignFirstResponder()
        medicineTextField.resignFirstResponder()
        insuranceTextField.resignFirstResponder()
        reserveCanopyTextField.resignFirstResponder()
    }
    
    // MARK: CHANGE COLORS BUTTON "SAVE":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = .colorCell
        }
    }
    
    private func actionButtonSaveRedColor() {
        saveButton.backgroundColor = .colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = .colorCell
        }
    }
    
    private func actionButtonCleanChangeColor() {
        cleanButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanButton.backgroundColor = .colorTabBar
        }
    }
    
    // MARK: PLAY SOUND BUTTON "SAVE":

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
    
    // MARK: GESTURES:

    @objc func tapGestureDone() {
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
    
    // MARK: ALERT KIT CLEAR:

    private func alertKitClear() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: DATE PICKER:

    @objc private func licenseDatePickerValueChanged() {
        getDateToLicense()
    }
    
    @objc private func medicineDatePickerValueChanged() {
        getDateToMedicine()
    }
    
    @objc private func insuranceDatePickerValueChanged() {
        getDateToInsurance()
    }
    
    @objc private func reserveCanopyDatePickerValueChanged() {
        getDateToReserveCanopy()
    }
    
    // MARK: DATE FORMATTER:

    private func getDateToLicense() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        licenseDateTextField.text = dateFormatter.string(from: licenseDatePicker.date)
    }
    
    private func getDateToMedicine() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        medicineTextField.text = dateFormatter.string(from: medicineDatePicker.date)
    }
    
    private func getDateToInsurance() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        insuranceTextField.text = dateFormatter.string(from: insuranceDatePicker.date)
    }
    
    private func getDateToReserveCanopy() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        reserveCanopyTextField.text = dateFormatter.string(from: reserveCanopyDatePicker.date)
    }
}

// MARK: - EXTENSION:

extension EditAccountVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vibrationOn.vibrationStandart()
    }
}
