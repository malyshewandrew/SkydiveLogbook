import UIKit

final class PermissionVC: UIViewController {
    
    //MARK: - PROPERTIES:

    private let medicineTextField = UITextField()
    private let insuranceTextField = UITextField()
    private let reserveCanopyTextField = UITextField()
    private let saveButtom = UIButton()
    
    
    //MARK: - ADD SUBVIEWS:
    func addSubviews() {
        view.addSubviews(medicineTextField, insuranceTextField, reserveCanopyTextField, saveButtom)
    }
    
    //MARK: - CONFIGURE CONSTRAINS:
    func configureConstrains() {
        
        // MARK: MEDICINE:
        
        medicineTextField.translatesAutoresizingMaskIntoConstraints = false
        medicineTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
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
        print("test")
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
