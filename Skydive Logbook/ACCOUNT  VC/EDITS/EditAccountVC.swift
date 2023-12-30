import UIKit
import AudioToolbox
import AVFoundation

final class EditAccountVC: UIViewController {
    
    //MARK: - PROPERTIES:

    
    private let nicknameButton = UIButton()
    private let nicknameTextField = UITextField()
    private let medicineButton = UIButton()
    private let medicineTextField = UITextField()
    private let insuranceButton = UIButton()
    private let insuranceTextField = UITextField()
    private let reserveCanopyButton = UIButton()
    private let reserveCanopyTextField = UITextField()
    private let saveButton = UIButton()
    private let vibrationOn = Vibration()
    private var player = AVAudioPlayer()
    
    //MARK: - LIFECYCLE:
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - ADD SUBVIEWS:
    func addSubviews() {
        view.addSubviews(nicknameButton, medicineButton, insuranceButton, reserveCanopyButton, saveButton)
        nicknameButton.addSubview(nicknameTextField)
        medicineButton.addSubview(medicineTextField)
        insuranceButton.addSubview(insuranceTextField)
        reserveCanopyButton.addSubview(reserveCanopyTextField)
    }
    
    //MARK: - CONFIGURE CONSTRAINS:
    func configureConstrains() {
        
        // MARK: NICKNAME:
        
        nicknameButton.translatesAutoresizingMaskIntoConstraints = false
        nicknameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        nicknameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nicknameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nicknameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.bottomAnchor.constraint(equalTo: nicknameButton.bottomAnchor).isActive = true
        nicknameTextField.leadingAnchor.constraint(equalTo: nicknameButton.leadingAnchor).isActive = true
        nicknameTextField.trailingAnchor.constraint(equalTo: nicknameButton.trailingAnchor).isActive = true
        nicknameTextField.heightAnchor.constraint(equalTo: nicknameButton.heightAnchor, multiplier: 0.5).isActive = true
        
        // MARK: MEDICINE:
        
        medicineButton.translatesAutoresizingMaskIntoConstraints = false
        medicineButton.topAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 15).isActive = true
        medicineButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        medicineButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        medicineButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        medicineTextField.translatesAutoresizingMaskIntoConstraints = false
        medicineTextField.bottomAnchor.constraint(equalTo: medicineButton.bottomAnchor).isActive = true
        medicineTextField.leadingAnchor.constraint(equalTo: medicineButton.leadingAnchor).isActive = true
        medicineTextField.trailingAnchor.constraint(equalTo: medicineButton.trailingAnchor).isActive = true
        medicineTextField.heightAnchor.constraint(equalTo: medicineButton.heightAnchor, multiplier: 0.5).isActive = true
        
        // MARK: INSURANCE:
        
        insuranceButton.translatesAutoresizingMaskIntoConstraints = false
        insuranceButton.topAnchor.constraint(equalTo: medicineButton.bottomAnchor, constant: 15).isActive = true
        insuranceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        insuranceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        insuranceButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        insuranceTextField.translatesAutoresizingMaskIntoConstraints = false
        insuranceTextField.bottomAnchor.constraint(equalTo: insuranceButton.bottomAnchor).isActive = true
        insuranceTextField.leadingAnchor.constraint(equalTo: insuranceButton.leadingAnchor).isActive = true
        insuranceTextField.trailingAnchor.constraint(equalTo: insuranceButton.trailingAnchor).isActive = true
        insuranceTextField.heightAnchor.constraint(equalTo: insuranceButton.heightAnchor, multiplier: 0.5).isActive = true
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyButton.topAnchor.constraint(equalTo: insuranceButton.bottomAnchor, constant: 15).isActive = true
        reserveCanopyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reserveCanopyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reserveCanopyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        reserveCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyTextField.bottomAnchor.constraint(equalTo: reserveCanopyButton.bottomAnchor).isActive = true
        reserveCanopyTextField.leadingAnchor.constraint(equalTo: reserveCanopyButton.leadingAnchor).isActive = true
        reserveCanopyTextField.trailingAnchor.constraint(equalTo: reserveCanopyButton.trailingAnchor).isActive = true
        reserveCanopyTextField.heightAnchor.constraint(equalTo: reserveCanopyButton.heightAnchor, multiplier: 0.5).isActive = true
        
        // MARK: SAVE BUTTOM:
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: reserveCanopyTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    //MARK: - CONFIGURE UI:
    func configureUI() {

        // MARK: VIEW:
        
        view.backgroundColor = colorBackground
        
        // MARK: NICKNAME:
        
        nicknameButton.setTitle("Никнейм*", for: .normal)
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
        
        // MARK: MEDICINE:
        
        medicineButton.setTitle("Справка до:*", for: .normal)
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
        
        insuranceButton.setTitle("Страховка до:*", for: .normal)
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
        
        reserveCanopyButton.setTitle("Запасной до: *", for: .normal)
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
    
    @objc private func tapOnSaveButtom() {
        saveNewAccount()
        actionButtonSaveGreenColor()
        vibrationOn.vibrationSucces()
        playSoundSucces()
        clearTextViews()
        resignFirstResponders()
    }
    
    private func saveNewAccount() {
        let account: AccountStructure = AccountStructure(nickname: nicknameTextField.text ?? "", medicine: medicineTextField.text ?? "", insurance: insuranceTextField.text ?? "", reserveCanopy: reserveCanopyTextField.text ?? "")
        arrayAccount.remove(at: 0)
        arrayAccount.insert(account, at: 0)
    }
    
    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = colorCell
        }
    }
    
    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    // MARK: CLEAR ALL TEXT FIELDS:
    
    private func clearTextViews() {
        nicknameTextField.text = ""
        medicineTextField.text = ""
        insuranceTextField.text = ""
        reserveCanopyTextField.text = ""
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        nicknameTextField.resignFirstResponder()
        medicineTextField.resignFirstResponder()
        insuranceTextField.resignFirstResponder()
        reserveCanopyTextField.resignFirstResponder()
    }
    
}
