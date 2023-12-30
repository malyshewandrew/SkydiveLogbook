import UIKit

final class EditAccountVC: UIViewController {
    
    //MARK: - PROPERTIES:

    private let nicknameTextField = UITextField()
    private let medicineTextField = UITextField()
    private let insuranceTextField = UITextField()
    private let reserveCanopyTextField = UITextField()
    private let saveButtom = UIButton()
    
    //MARK: - ADD SUBVIEWS:
    func addSubviews() {
        view.addSubviews(nicknameTextField, medicineTextField, insuranceTextField, reserveCanopyTextField, saveButtom)
    }
    
    //MARK: - CONFIGURE CONSTRAINS:
    func configureConstrains() {
        
        // MARK: NICKNAME:
        
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        nicknameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nicknameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nicknameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: MEDICINE:
        
        medicineTextField.translatesAutoresizingMaskIntoConstraints = false
        medicineTextField.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 15).isActive = true
        medicineTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        medicineTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        medicineTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: INSURANCE:
        
        insuranceTextField.translatesAutoresizingMaskIntoConstraints = false
        insuranceTextField.topAnchor.constraint(equalTo: medicineTextField.bottomAnchor, constant: 15).isActive = true
        insuranceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        insuranceTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        insuranceTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyTextField.topAnchor.constraint(equalTo: insuranceTextField.bottomAnchor, constant: 15).isActive = true
        reserveCanopyTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reserveCanopyTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reserveCanopyTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: SAVE BUTTOM:
        
        saveButtom.translatesAutoresizingMaskIntoConstraints = false
        saveButtom.topAnchor.constraint(equalTo: reserveCanopyTextField.bottomAnchor, constant: 15).isActive = true
        saveButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButtom.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButtom.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    //MARK: - CONFIGURE UI:
    func configureUI() {

        // MARK: VIEW:
        
        view.backgroundColor = colorBackground
        
        // MARK: NICKNAME:
        
        nicknameTextField.backgroundColor = colorDarkGray
        
        // MARK: MEDICINE:
        
        medicineTextField.backgroundColor = colorDarkGray
        
        // MARK: INSURANCE:
        
        insuranceTextField.backgroundColor = colorDarkGray
        
        // MARK: RESERVE CANOPY:
        
        reserveCanopyTextField.backgroundColor = colorDarkGray
        
        // MARK: SAVE BUTTOM:
        
        saveButtom.backgroundColor = colorGreen
        saveButtom.addTarget(self, action: #selector(tapOnSaveButtom), for: .touchUpInside)
    }
    
    @objc private func tapOnSaveButtom() {
        var user: AccountStructure = AccountStructure(nickname: nicknameTextField.text ?? "", medicine: medicineTextField.text ?? "", insurance: insuranceTextField.text ?? "", reserveCanopy: reserveCanopyTextField.text ?? "")
        print(user)
    }
    
    //MARK: - LIFECYCLE:
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        navigationController?.navigationBar.isHidden = false
    }
    
}
