import AudioToolbox
import AVFoundation
import UIKit

protocol EditSystemCellDelegate {
    func saveSystem(_ system: SystemStructure)
}

final class EditSystemCell: UITableViewCell {
    // MARK: - PROPERTIES:

    // NAME SYSTEM:
    private let nameSystemButton = UIButton()
    private let nameSystemTextField = UITextField()
    
    // CONTAINER:
    private let containerNameButton = UIButton()
    private let containerNameTextField = UITextField()
    
    private let containerDomButton = UIButton()
    private let containerDomTextField = UITextField()
    private let containerDomPickerView = UIDatePicker()
    
    private let containerSerialNumberButton = UIButton()
    private let containerSerialNumberTextField = UITextField()
    
    private let containerServiceLifeYearsButton = UIButton()
    private let containerServiceLifeYearsTextField = UITextField()
    
    // LINE ONE:
    
    private let lineOneView = UIView()
    
    // AAD:
    private let aadNameButton = UIButton()
    private let aadNameTextField = UITextField()
    
    private let aadDomButton = UIButton()
    private let aadDomTextField = UITextField()
    private let aadDomPickerView = UIDatePicker()
    
    private let aadSerialNumberButton = UIButton()
    private let aadSerialNumberTextField = UITextField()
    
    private let aadServiceLifeYearsButton = UIButton()
    private let aadServiceLifeYearsTextField = UITextField()
    
    // LINE TWO:
    
    private let lineTwoView = UIView()
    
    // MAIN CANOPY:
    private let mainCanopyNameButton = UIButton()
    private let mainCanopyNameTextField = UITextField()
    private let mainCanopyPickerView = UIPickerView()
    
    private let mainCanopyDomButton = UIButton()
    private let mainCanopyDomTextField = UITextField()
    private let mainCanopyDomPickerView = UIDatePicker()
    
    private let mainCanopySerialNumberButton = UIButton()
    private let mainCanopySerialNumberTextField = UITextField()
    
    private let mainCanopyServiceLifeYearsButton = UIButton()
    private let mainCanopyServiceLifeYearsTextField = UITextField()
    
    private let mainCanopyServiceLifeJumpsButton = UIButton()
    private let mainCanopyServiceLifeJumpsTextField = UITextField()
    
    private let mainCanopyCountJumpsButton = UIButton()
    private let mainCanopyCountJumpsTextField = UITextField()
    
    // LINE THREE:
    
    private let lineThreeView = UIView()
    
    // RESERVE CANOPY:
    private let reserveCanopyNameButton = UIButton()
    private let reserveCanopyNameTextField = UITextField()
    
    private let reserveCanopyDomButton = UIButton()
    private let reserveCanopyDomTextField = UITextField()
    private let reserveCanopyDomPickerView = UIDatePicker()
    
    private let reserveCanopySerialNumberButton = UIButton()
    private let reserveCanopySerialNumberTextField = UITextField()
    
    private let reserveCanopyServiceLifeYearsButton = UIButton()
    private let reserveCanopyServiceLifeYearsTextField = UITextField()
    
    private let reserveCanopyCountRepackButton = UIButton()
    private let reserveCanopyCountRepackTextField = UITextField()
    
    private let reserveCanopyDatePackButton = UIButton()
    private let reserveCanopyDatePackTextField = UITextField()
    private let reserveCanopyDatePackPickerView = UIDatePicker()
    
    // COMMENT:
    private let commentSystemButton = UIButton()
    private let commentSystemTextField = UITextField()
    
    //SAVE BUTTON:
    private let saveButton = UIButton()
    
    // HELPERS
    private let vibrationOn = Vibration()
    private var player = AVAudioPlayer()
    
    // Delegate:
    var delegate: EditSystemCellDelegate?
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUI()
        mainCanopyPickerView.delegate = self
        mainCanopyPickerView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(nameSystemButton,
                                containerNameButton, containerDomButton, containerSerialNumberButton, containerServiceLifeYearsButton,
                                lineOneView,
                                aadNameButton, aadDomButton, aadSerialNumberButton, aadServiceLifeYearsButton,
                                lineTwoView,
                                mainCanopyNameButton, mainCanopyDomButton, mainCanopySerialNumberButton, mainCanopyServiceLifeYearsButton, mainCanopyServiceLifeJumpsButton, mainCanopyCountJumpsButton,
                                lineThreeView,
                                reserveCanopyNameButton, reserveCanopyDomButton, reserveCanopySerialNumberButton, reserveCanopyServiceLifeYearsButton, reserveCanopyCountRepackButton, reserveCanopyDatePackButton,
                                commentSystemButton,
                                saveButton)
        
        nameSystemButton.addSubview(nameSystemTextField)
        
        containerNameButton.addSubview(containerNameTextField)
        containerDomButton.addSubview(containerDomTextField)
        containerSerialNumberButton.addSubview(containerSerialNumberTextField)
        containerServiceLifeYearsButton.addSubview(containerServiceLifeYearsTextField)
        
        aadNameButton.addSubview(aadNameTextField)
        aadDomButton.addSubview(aadDomTextField)
        aadSerialNumberButton.addSubview(aadSerialNumberTextField)
        aadServiceLifeYearsButton.addSubview(aadServiceLifeYearsTextField)
        
        mainCanopyNameButton.addSubview(mainCanopyNameTextField)
        mainCanopyDomButton.addSubview(mainCanopyDomTextField)
        mainCanopySerialNumberButton.addSubview(mainCanopySerialNumberTextField)
        mainCanopyServiceLifeYearsButton.addSubview(mainCanopyServiceLifeYearsTextField)
        mainCanopyServiceLifeJumpsButton.addSubview(mainCanopyServiceLifeJumpsTextField)
        mainCanopyCountJumpsButton.addSubview(mainCanopyCountJumpsTextField)
        
        reserveCanopyNameButton.addSubview(reserveCanopyNameTextField)
        reserveCanopyDomButton.addSubview(reserveCanopyDomTextField)
        reserveCanopySerialNumberButton.addSubview(reserveCanopySerialNumberTextField)
        reserveCanopyServiceLifeYearsButton.addSubview(reserveCanopyServiceLifeYearsTextField)
        reserveCanopyCountRepackButton.addSubview(reserveCanopyCountRepackTextField)
        reserveCanopyDatePackButton.addSubview(reserveCanopyDatePackTextField)
        
        commentSystemButton.addSubview(commentSystemTextField)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: NAME SYSTEM:
        
        nameSystemButton.translatesAutoresizingMaskIntoConstraints = false
        nameSystemButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        nameSystemButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameSystemButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.2).isActive = true
        nameSystemButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.86).isActive = true

        nameSystemTextField.translatesAutoresizingMaskIntoConstraints = false
        nameSystemTextField.bottomAnchor.constraint(equalTo: nameSystemButton.bottomAnchor, constant: 0).isActive = true
        nameSystemTextField.centerXAnchor.constraint(equalTo: nameSystemButton.centerXAnchor).isActive = true
        nameSystemTextField.heightAnchor.constraint(equalTo: nameSystemButton.heightAnchor, multiplier: 0.5).isActive = true
        nameSystemTextField.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CONTAINER NAME:
        
        containerNameButton.translatesAutoresizingMaskIntoConstraints = false
        containerNameButton.topAnchor.constraint(equalTo: nameSystemButton.bottomAnchor, constant: 15).isActive = true
        containerNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        containerNameButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        containerNameButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        containerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        containerNameTextField.bottomAnchor.constraint(equalTo: containerNameButton.bottomAnchor, constant: 0).isActive = true
        containerNameTextField.centerXAnchor.constraint(equalTo: containerNameButton.centerXAnchor).isActive = true
        containerNameTextField.heightAnchor.constraint(equalTo: containerNameButton.heightAnchor, multiplier: 0.5).isActive = true
        containerNameTextField.widthAnchor.constraint(equalTo: containerNameButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CONTAINER DOM:
        
        containerDomButton.translatesAutoresizingMaskIntoConstraints = false
        containerDomButton.topAnchor.constraint(equalTo: nameSystemButton.bottomAnchor, constant: 15).isActive = true
        containerDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        containerDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        containerDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        containerDomTextField.translatesAutoresizingMaskIntoConstraints = false
        containerDomTextField.bottomAnchor.constraint(equalTo: containerDomButton.bottomAnchor, constant: 0).isActive = true
        containerDomTextField.centerXAnchor.constraint(equalTo: containerDomButton.centerXAnchor).isActive = true
        containerDomTextField.heightAnchor.constraint(equalTo: containerDomButton.heightAnchor, multiplier: 0.5).isActive = true
        containerDomTextField.widthAnchor.constraint(equalTo: containerDomButton.widthAnchor, multiplier: 1).isActive = true
        
        containerDomPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: CONTAINER SERIAL NUMBER:
        
        containerSerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        containerSerialNumberButton.topAnchor.constraint(equalTo: containerNameButton.bottomAnchor, constant: 5).isActive = true
        containerSerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        containerSerialNumberButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        containerSerialNumberButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        containerSerialNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        containerSerialNumberTextField.bottomAnchor.constraint(equalTo: containerSerialNumberButton.bottomAnchor, constant: 0).isActive = true
        containerSerialNumberTextField.centerXAnchor.constraint(equalTo: containerSerialNumberButton.centerXAnchor).isActive = true
        containerSerialNumberTextField.heightAnchor.constraint(equalTo: containerSerialNumberButton.heightAnchor, multiplier: 0.5).isActive = true
        containerSerialNumberTextField.widthAnchor.constraint(equalTo: containerSerialNumberButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CONTAINER SERVICE LIFE:
        
        containerServiceLifeYearsButton.translatesAutoresizingMaskIntoConstraints = false
        containerServiceLifeYearsButton.topAnchor.constraint(equalTo: containerDomButton.bottomAnchor, constant: 5).isActive = true
        containerServiceLifeYearsButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        containerServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        containerServiceLifeYearsButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        containerServiceLifeYearsTextField.translatesAutoresizingMaskIntoConstraints = false
        containerServiceLifeYearsTextField.bottomAnchor.constraint(equalTo: containerServiceLifeYearsButton.bottomAnchor, constant: 0).isActive = true
        containerServiceLifeYearsTextField.centerXAnchor.constraint(equalTo: containerServiceLifeYearsButton.centerXAnchor).isActive = true
        containerServiceLifeYearsTextField.heightAnchor.constraint(equalTo: containerServiceLifeYearsButton.heightAnchor, multiplier: 0.5).isActive = true
        containerServiceLifeYearsTextField.widthAnchor.constraint(equalTo: containerServiceLifeYearsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: LINE ONE:
        
        lineOneView.translatesAutoresizingMaskIntoConstraints = false
        lineOneView.topAnchor.constraint(equalTo: containerServiceLifeYearsButton.bottomAnchor, constant: 10).isActive = true
        lineOneView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        lineOneView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineOneView.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 0.9).isActive = true
        
        // MARK: AAD NAME:
        
        aadNameButton.translatesAutoresizingMaskIntoConstraints = false
        aadNameButton.topAnchor.constraint(equalTo: lineOneView.bottomAnchor, constant: 10).isActive = true
        aadNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        aadNameButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        aadNameButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        aadNameTextField.translatesAutoresizingMaskIntoConstraints = false
        aadNameTextField.bottomAnchor.constraint(equalTo: aadNameButton.bottomAnchor, constant: 0).isActive = true
        aadNameTextField.centerXAnchor.constraint(equalTo: aadNameButton.centerXAnchor).isActive = true
        aadNameTextField.heightAnchor.constraint(equalTo: aadNameButton.heightAnchor, multiplier: 0.5).isActive = true
        aadNameTextField.widthAnchor.constraint(equalTo: aadNameButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: AAD DOM:
        
        aadDomButton.translatesAutoresizingMaskIntoConstraints = false
        aadDomButton.topAnchor.constraint(equalTo: containerSerialNumberButton.bottomAnchor, constant: 20).isActive = true
        aadDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        aadDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        aadDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        aadDomTextField.translatesAutoresizingMaskIntoConstraints = false
        aadDomTextField.bottomAnchor.constraint(equalTo: aadDomButton.bottomAnchor, constant: 0).isActive = true
        aadDomTextField.centerXAnchor.constraint(equalTo: aadDomButton.centerXAnchor).isActive = true
        aadDomTextField.heightAnchor.constraint(equalTo: aadDomButton.heightAnchor, multiplier: 0.5).isActive = true
        aadDomTextField.widthAnchor.constraint(equalTo: aadDomButton.widthAnchor, multiplier: 1).isActive = true
        
        aadDomPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: AAD SERIAL NUMBER:
        
        aadSerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        aadSerialNumberButton.topAnchor.constraint(equalTo: aadNameButton.bottomAnchor, constant: 5).isActive = true
        aadSerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        aadSerialNumberButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        aadSerialNumberButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        aadSerialNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        aadSerialNumberTextField.bottomAnchor.constraint(equalTo: aadSerialNumberButton.bottomAnchor, constant: 0).isActive = true
        aadSerialNumberTextField.centerXAnchor.constraint(equalTo: aadSerialNumberButton.centerXAnchor).isActive = true
        aadSerialNumberTextField.heightAnchor.constraint(equalTo: aadSerialNumberButton.heightAnchor, multiplier: 0.5).isActive = true
        aadSerialNumberTextField.widthAnchor.constraint(equalTo: aadSerialNumberButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CONTAINER SERVICE LIFE YEARS:
        
        aadServiceLifeYearsButton.translatesAutoresizingMaskIntoConstraints = false
        aadServiceLifeYearsButton.topAnchor.constraint(equalTo: aadDomButton.bottomAnchor, constant: 5).isActive = true
        aadServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        aadServiceLifeYearsButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        aadServiceLifeYearsButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        aadServiceLifeYearsTextField.translatesAutoresizingMaskIntoConstraints = false
        aadServiceLifeYearsTextField.bottomAnchor.constraint(equalTo: aadServiceLifeYearsButton.bottomAnchor, constant: 0).isActive = true
        aadServiceLifeYearsTextField.centerXAnchor.constraint(equalTo: aadServiceLifeYearsButton.centerXAnchor).isActive = true
        aadServiceLifeYearsTextField.heightAnchor.constraint(equalTo: aadServiceLifeYearsButton.heightAnchor, multiplier: 0.5).isActive = true
        aadServiceLifeYearsTextField.widthAnchor.constraint(equalTo: aadServiceLifeYearsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: LINE TWO:
        
        lineTwoView.translatesAutoresizingMaskIntoConstraints = false
        lineTwoView.topAnchor.constraint(equalTo: aadServiceLifeYearsButton.bottomAnchor, constant: 10).isActive = true
        lineTwoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        lineTwoView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineTwoView.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 0.9).isActive = true
        
        // MARK: MAIN CANOPY NAME:
        
        mainCanopyNameButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyNameButton.topAnchor.constraint(equalTo: lineTwoView.bottomAnchor, constant: 10).isActive = true
        mainCanopyNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        mainCanopyNameButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        mainCanopyNameButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyNameTextField.bottomAnchor.constraint(equalTo: mainCanopyNameButton.bottomAnchor, constant: 0).isActive = true
        mainCanopyNameTextField.centerXAnchor.constraint(equalTo: mainCanopyNameButton.centerXAnchor).isActive = true
        mainCanopyNameTextField.heightAnchor.constraint(equalTo: mainCanopyNameButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopyNameTextField.widthAnchor.constraint(equalTo: mainCanopyNameButton.widthAnchor, multiplier: 1).isActive = true
        
        mainCanopyPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: MAIN CANOPY DOM:
        
        mainCanopyDomButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyDomButton.topAnchor.constraint(equalTo: aadSerialNumberButton.bottomAnchor, constant: 20).isActive = true
        mainCanopyDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        mainCanopyDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        mainCanopyDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopyDomTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyDomTextField.bottomAnchor.constraint(equalTo: mainCanopyDomButton.bottomAnchor, constant: 0).isActive = true
        mainCanopyDomTextField.centerXAnchor.constraint(equalTo: mainCanopyDomButton.centerXAnchor).isActive = true
        mainCanopyDomTextField.heightAnchor.constraint(equalTo: mainCanopyDomButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopyDomTextField.widthAnchor.constraint(equalTo: mainCanopyDomButton.widthAnchor, multiplier: 1).isActive = true
        
        mainCanopyDomPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: MAIN CANOPY SERIAL NUMBER:
        
        mainCanopySerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopySerialNumberButton.topAnchor.constraint(equalTo: mainCanopyNameButton.bottomAnchor, constant: 5).isActive = true
        mainCanopySerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        mainCanopySerialNumberButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        mainCanopySerialNumberButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopySerialNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopySerialNumberTextField.bottomAnchor.constraint(equalTo: mainCanopySerialNumberButton.bottomAnchor, constant: 0).isActive = true
        mainCanopySerialNumberTextField.centerXAnchor.constraint(equalTo: mainCanopySerialNumberButton.centerXAnchor).isActive = true
        mainCanopySerialNumberTextField.heightAnchor.constraint(equalTo: mainCanopySerialNumberButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopySerialNumberTextField.widthAnchor.constraint(equalTo: mainCanopySerialNumberButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: MAIN CANOPY SERVICE LIFE YEARS:
        
        mainCanopyServiceLifeYearsButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyServiceLifeYearsButton.topAnchor.constraint(equalTo: mainCanopyNameButton.bottomAnchor, constant: 5).isActive = true
        mainCanopyServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        mainCanopyServiceLifeYearsButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        mainCanopyServiceLifeYearsButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopyServiceLifeYearsTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyServiceLifeYearsTextField.bottomAnchor.constraint(equalTo: mainCanopyServiceLifeYearsButton.bottomAnchor, constant: 0).isActive = true
        mainCanopyServiceLifeYearsTextField.centerXAnchor.constraint(equalTo: mainCanopyServiceLifeYearsButton.centerXAnchor).isActive = true
        mainCanopyServiceLifeYearsTextField.heightAnchor.constraint(equalTo: mainCanopyServiceLifeYearsButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopyServiceLifeYearsTextField.widthAnchor.constraint(equalTo: mainCanopyServiceLifeYearsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: MAIN CANOPY SERVICE LIFE JUMPS:
        
        mainCanopyServiceLifeJumpsButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyServiceLifeJumpsButton.topAnchor.constraint(equalTo: mainCanopySerialNumberButton.bottomAnchor, constant: 5).isActive = true
        mainCanopyServiceLifeJumpsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        mainCanopyServiceLifeJumpsButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        mainCanopyServiceLifeJumpsButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopyServiceLifeJumpsTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyServiceLifeJumpsTextField.bottomAnchor.constraint(equalTo: mainCanopyServiceLifeJumpsButton.bottomAnchor, constant: 0).isActive = true
        mainCanopyServiceLifeJumpsTextField.centerXAnchor.constraint(equalTo: mainCanopyServiceLifeJumpsButton.centerXAnchor).isActive = true
        mainCanopyServiceLifeJumpsTextField.heightAnchor.constraint(equalTo: mainCanopyServiceLifeJumpsButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopyServiceLifeJumpsTextField.widthAnchor.constraint(equalTo: mainCanopyServiceLifeJumpsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: MAIN CANOPY COUNT JUMPS:
        
        mainCanopyCountJumpsButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyCountJumpsButton.topAnchor.constraint(equalTo: mainCanopyServiceLifeYearsButton.bottomAnchor, constant: 5).isActive = true
        mainCanopyCountJumpsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        mainCanopyCountJumpsButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        mainCanopyCountJumpsButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopyCountJumpsTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyCountJumpsTextField.bottomAnchor.constraint(equalTo: mainCanopyCountJumpsButton.bottomAnchor, constant: 0).isActive = true
        mainCanopyCountJumpsTextField.centerXAnchor.constraint(equalTo: mainCanopyCountJumpsButton.centerXAnchor).isActive = true
        mainCanopyCountJumpsTextField.heightAnchor.constraint(equalTo: mainCanopyCountJumpsButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopyCountJumpsTextField.widthAnchor.constraint(equalTo: mainCanopyCountJumpsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: LINE THREE:
        
        lineThreeView.translatesAutoresizingMaskIntoConstraints = false
        lineThreeView.topAnchor.constraint(equalTo: mainCanopyCountJumpsButton.bottomAnchor, constant: 10).isActive = true
        lineThreeView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        lineThreeView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineThreeView.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 0.9).isActive = true
        
        // MARK: RESERVE CANOPY NAME:
        
        reserveCanopyNameButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyNameButton.topAnchor.constraint(equalTo: lineThreeView.bottomAnchor, constant: 10).isActive = true
        reserveCanopyNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        reserveCanopyNameButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        reserveCanopyNameButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyNameTextField.bottomAnchor.constraint(equalTo: reserveCanopyNameButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyNameTextField.centerXAnchor.constraint(equalTo: reserveCanopyNameButton.centerXAnchor).isActive = true
        reserveCanopyNameTextField.heightAnchor.constraint(equalTo: reserveCanopyNameButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyNameTextField.widthAnchor.constraint(equalTo: reserveCanopyNameButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: RESERVE CANOPY DOM:
        
        reserveCanopyDomButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDomButton.topAnchor.constraint(equalTo: mainCanopyServiceLifeJumpsButton.bottomAnchor, constant: 20).isActive = true
        reserveCanopyDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        reserveCanopyDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        reserveCanopyDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDomTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDomTextField.bottomAnchor.constraint(equalTo: reserveCanopyDomButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyDomTextField.centerXAnchor.constraint(equalTo: reserveCanopyDomButton.centerXAnchor).isActive = true
        reserveCanopyDomTextField.heightAnchor.constraint(equalTo: reserveCanopyDomButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyDomTextField.widthAnchor.constraint(equalTo: reserveCanopyDomButton.widthAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDomPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: RESERVE CANOPY SERIAL NUMBER:
        
        reserveCanopySerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopySerialNumberButton.topAnchor.constraint(equalTo: reserveCanopyNameButton.bottomAnchor, constant: 5).isActive = true
        reserveCanopySerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        reserveCanopySerialNumberButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        reserveCanopySerialNumberButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopySerialNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopySerialNumberTextField.bottomAnchor.constraint(equalTo: reserveCanopySerialNumberButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopySerialNumberTextField.centerXAnchor.constraint(equalTo: reserveCanopySerialNumberButton.centerXAnchor).isActive = true
        reserveCanopySerialNumberTextField.heightAnchor.constraint(equalTo: reserveCanopySerialNumberButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopySerialNumberTextField.widthAnchor.constraint(equalTo: reserveCanopySerialNumberButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: RESERVE CANOPY SERVICE LIFE YEARS:
        
        reserveCanopyServiceLifeYearsButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyServiceLifeYearsButton.topAnchor.constraint(equalTo: reserveCanopyNameButton.bottomAnchor, constant: 5).isActive = true
        reserveCanopyServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        reserveCanopyServiceLifeYearsButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        reserveCanopyServiceLifeYearsButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyServiceLifeYearsTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyServiceLifeYearsTextField.bottomAnchor.constraint(equalTo: reserveCanopyServiceLifeYearsButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyServiceLifeYearsTextField.centerXAnchor.constraint(equalTo: reserveCanopyServiceLifeYearsButton.centerXAnchor).isActive = true
        reserveCanopyServiceLifeYearsTextField.heightAnchor.constraint(equalTo: reserveCanopyServiceLifeYearsButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyServiceLifeYearsTextField.widthAnchor.constraint(equalTo: reserveCanopyServiceLifeYearsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: RESERVE CANOPY COUNT REPACK:

        reserveCanopyCountRepackButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyCountRepackButton.topAnchor.constraint(equalTo: reserveCanopySerialNumberButton.bottomAnchor, constant: 5).isActive = true
        reserveCanopyCountRepackButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        reserveCanopyCountRepackButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        reserveCanopyCountRepackButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyCountRepackTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyCountRepackTextField.bottomAnchor.constraint(equalTo: reserveCanopyCountRepackButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyCountRepackTextField.centerXAnchor.constraint(equalTo: reserveCanopyCountRepackButton.centerXAnchor).isActive = true
        reserveCanopyCountRepackTextField.heightAnchor.constraint(equalTo: reserveCanopyCountRepackButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyCountRepackTextField.widthAnchor.constraint(equalTo: reserveCanopyCountRepackButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: RESERVE CANOPY DATE PACK:

        reserveCanopyDatePackButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDatePackButton.topAnchor.constraint(equalTo: reserveCanopySerialNumberButton.bottomAnchor, constant: 5).isActive = true
        reserveCanopyDatePackButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        reserveCanopyDatePackButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        reserveCanopyDatePackButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDatePackTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDatePackTextField.bottomAnchor.constraint(equalTo: reserveCanopyDatePackButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyDatePackTextField.centerXAnchor.constraint(equalTo: reserveCanopyDatePackButton.centerXAnchor).isActive = true
        reserveCanopyDatePackTextField.heightAnchor.constraint(equalTo: reserveCanopyDatePackButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyDatePackTextField.widthAnchor.constraint(equalTo: reserveCanopyDatePackButton.widthAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDatePackPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: COMMENT SYSTEM:
        commentSystemButton.translatesAutoresizingMaskIntoConstraints = false
        commentSystemButton.topAnchor.constraint(equalTo: reserveCanopyDatePackButton.bottomAnchor, constant: 15).isActive = true
        commentSystemButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        commentSystemButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.2).isActive = true
        commentSystemButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.86).isActive = true

        commentSystemTextField.translatesAutoresizingMaskIntoConstraints = false
        commentSystemTextField.bottomAnchor.constraint(equalTo: commentSystemButton.bottomAnchor, constant: 0).isActive = true
        commentSystemTextField.centerXAnchor.constraint(equalTo: commentSystemButton.centerXAnchor).isActive = true
        commentSystemTextField.heightAnchor.constraint(equalTo: commentSystemButton.heightAnchor, multiplier: 0.5).isActive = true
        commentSystemTextField.widthAnchor.constraint(equalTo: commentSystemButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: SAVE BUTTON:

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: commentSystemButton.bottomAnchor, constant: 15).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.34).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        saveButton.addTarget(self, action: #selector(actionButtonSaveTap), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        selectionStyle = .none
        contentView.backgroundColor = colorBackground
        
        // MARK: NAME SYSTEM:
        
        nameSystemButton.setTitle("Название системы*", for: .normal)
        nameSystemButton.backgroundColor = colorCell
        nameSystemButton.setTitleColor(colorLightGray, for: .normal)
        nameSystemButton.contentVerticalAlignment = textAligmentTop
        nameSystemButton.titleLabel?.font = fontMediumStandart12
        nameSystemButton.layer.cornerRadius = cornerRadius10
        nameSystemTextField.placeholder = "Название"
        nameSystemTextField.backgroundColor = colorTabBar
        nameSystemTextField.font = fontMediumStandart18
        nameSystemTextField.textColor = colorWhite
        nameSystemTextField.layer.cornerRadius = cornerRadius10
        nameSystemTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        nameSystemTextField.textAlignment = textAligmentCenter
        nameSystemTextField.tintColor = colorWhite
        nameSystemTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER NAME:

        containerNameButton.setTitle("Ранец*", for: .normal)
        containerNameButton.backgroundColor = colorCell
        containerNameButton.setTitleColor(colorLightGray, for: .normal)
        containerNameButton.contentVerticalAlignment = textAligmentTop
        containerNameButton.titleLabel?.font = fontMediumStandart10
        containerNameButton.layer.cornerRadius = cornerRadius10
        containerNameTextField.placeholder = "Название ранца"
        containerNameTextField.backgroundColor = colorTabBar
        containerNameTextField.font = fontRegularStandart12
        containerNameTextField.textColor = colorWhite
        containerNameTextField.layer.cornerRadius = cornerRadius10
        containerNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerNameTextField.textAlignment = textAligmentCenter
        containerNameTextField.tintColor = colorWhite
        containerNameTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER DOM:
        
        containerDomButton.setTitle("Дата изготовления*", for: .normal)
        containerDomButton.backgroundColor = colorCell
        containerDomButton.setTitleColor(colorLightGray, for: .normal)
        containerDomButton.contentVerticalAlignment = textAligmentTop
        containerDomButton.titleLabel?.font = fontMediumStandart10
        containerDomButton.layer.cornerRadius = cornerRadius10
        containerDomTextField.placeholder = "мм.гггг"
        containerDomTextField.backgroundColor = colorTabBar
        containerDomTextField.font = fontRegularStandart12
        containerDomTextField.textColor = colorWhite
        containerDomTextField.layer.cornerRadius = cornerRadius10
        containerDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerDomTextField.textAlignment = textAligmentCenter
        containerDomTextField.tintColor = colorWhite
        containerDomTextField.layer.masksToBounds = true
        containerDomTextField.inputView = containerDomPickerView
        containerDomPickerView.setValue(colorWhite, forKeyPath: "textColor")
        containerDomPickerView.datePickerMode = .date
        containerDomPickerView.preferredDatePickerStyle = .wheels
        containerDomPickerView.maximumDate = Date()
        containerDomPickerView.backgroundColor = colorTabBar
        containerDomPickerView.datePickerMode = .date
        containerDomPickerView.addTarget(self, action: #selector(containerDomPickerValueChanged), for: .valueChanged)
        
        // MARK: CONTAINER SERIAL NUMBER:
        
        containerSerialNumberButton.setTitle("Серийный номер*", for: .normal)
        containerSerialNumberButton.backgroundColor = colorCell
        containerSerialNumberButton.setTitleColor(colorLightGray, for: .normal)
        containerSerialNumberButton.contentVerticalAlignment = textAligmentTop
        containerSerialNumberButton.titleLabel?.font = fontMediumStandart10
        containerSerialNumberButton.layer.cornerRadius = cornerRadius10
        containerSerialNumberTextField.placeholder = "№"
        containerSerialNumberTextField.backgroundColor = colorTabBar
        containerSerialNumberTextField.font = fontRegularStandart12
        containerSerialNumberTextField.textColor = colorWhite
        containerSerialNumberTextField.layer.cornerRadius = cornerRadius10
        containerSerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerSerialNumberTextField.textAlignment = textAligmentCenter
        containerSerialNumberTextField.tintColor = colorWhite
        containerSerialNumberTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER SERVICE LIFE:
        
        containerServiceLifeYearsButton.setTitle("Гарантийный ресурс*", for: .normal)
        containerServiceLifeYearsButton.backgroundColor = colorCell
        containerServiceLifeYearsButton.setTitleColor(colorLightGray, for: .normal)
        containerServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        containerServiceLifeYearsButton.titleLabel?.font = fontMediumStandart10
        containerServiceLifeYearsButton.layer.cornerRadius = cornerRadius10
        containerServiceLifeYearsTextField.placeholder = "Количество лет"
        containerServiceLifeYearsTextField.backgroundColor = colorTabBar
        containerServiceLifeYearsTextField.font = fontRegularStandart12
        containerServiceLifeYearsTextField.textColor = colorWhite
        containerServiceLifeYearsTextField.layer.cornerRadius = cornerRadius10
        containerServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerServiceLifeYearsTextField.textAlignment = textAligmentCenter
        containerServiceLifeYearsTextField.tintColor = colorWhite
        containerServiceLifeYearsTextField.keyboardType = .numberPad
        containerServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: LINE ONE:
        
        lineOneView.backgroundColor = colorDarkGray
        
        // MARK: AAD NAME:
        
        aadNameButton.setTitle("Страхующий прибор*", for: .normal)
        aadNameButton.backgroundColor = colorCell
        aadNameButton.setTitleColor(colorLightGray, for: .normal)
        aadNameButton.contentVerticalAlignment = textAligmentTop
        aadNameButton.titleLabel?.font = fontMediumStandart10
        aadNameButton.layer.cornerRadius = cornerRadius10
        aadNameTextField.placeholder = "Название прибора"
        aadNameTextField.backgroundColor = colorTabBar
        aadNameTextField.font = fontRegularStandart12
        aadNameTextField.textColor = colorWhite
        aadNameTextField.layer.cornerRadius = cornerRadius10
        aadNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadNameTextField.textAlignment = textAligmentCenter
        aadNameTextField.tintColor = colorWhite
        aadNameTextField.layer.masksToBounds = true
        
        // MARK: AAD DOM:
        
        aadDomButton.setTitle("Дата изготовления*", for: .normal)
        aadDomButton.backgroundColor = colorCell
        aadDomButton.setTitleColor(colorLightGray, for: .normal)
        aadDomButton.contentVerticalAlignment = textAligmentTop
        aadDomButton.titleLabel?.font = fontMediumStandart10
        aadDomButton.layer.cornerRadius = cornerRadius10
        aadDomTextField.placeholder = "мм.гггг"
        aadDomTextField.backgroundColor = colorTabBar
        aadDomTextField.font = fontRegularStandart12
        aadDomTextField.textColor = colorWhite
        aadDomTextField.layer.cornerRadius = cornerRadius10
        aadDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadDomTextField.textAlignment = textAligmentCenter
        aadDomTextField.tintColor = colorWhite
        aadDomTextField.layer.masksToBounds = true
        aadDomTextField.inputView = aadDomPickerView
        aadDomPickerView.setValue(colorWhite, forKeyPath: "textColor")
        aadDomPickerView.datePickerMode = .date
        aadDomPickerView.preferredDatePickerStyle = .wheels
        aadDomPickerView.maximumDate = Date()
        aadDomPickerView.backgroundColor = colorTabBar
        aadDomPickerView.addTarget(self, action: #selector(aadDomPickerValueChanged), for: .valueChanged)
        
        // MARK: AAD SERIAL NUMBER:
        
        aadSerialNumberButton.setTitle("Серийный номер*", for: .normal)
        aadSerialNumberButton.backgroundColor = colorCell
        aadSerialNumberButton.setTitleColor(colorLightGray, for: .normal)
        aadSerialNumberButton.contentVerticalAlignment = textAligmentTop
        aadSerialNumberButton.titleLabel?.font = fontMediumStandart10
        aadSerialNumberButton.layer.cornerRadius = cornerRadius10
        aadSerialNumberTextField.placeholder = "№"
        aadSerialNumberTextField.backgroundColor = colorTabBar
        aadSerialNumberTextField.font = fontRegularStandart12
        aadSerialNumberTextField.textColor = colorWhite
        aadSerialNumberTextField.layer.cornerRadius = cornerRadius10
        aadSerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadSerialNumberTextField.textAlignment = textAligmentCenter
        aadSerialNumberTextField.tintColor = colorWhite
        aadSerialNumberTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER SERVISE LIFE YEARS:
        
        aadServiceLifeYearsButton.setTitle("Гарантийный ресурс*", for: .normal)
        aadServiceLifeYearsButton.backgroundColor = colorCell
        aadServiceLifeYearsButton.setTitleColor(colorLightGray, for: .normal)
        aadServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        aadServiceLifeYearsButton.titleLabel?.font = fontMediumStandart10
        aadServiceLifeYearsButton.layer.cornerRadius = cornerRadius10
        aadServiceLifeYearsTextField.placeholder = "Количество лет"
        aadServiceLifeYearsTextField.backgroundColor = colorTabBar
        aadServiceLifeYearsTextField.font = fontRegularStandart12
        aadServiceLifeYearsTextField.textColor = colorWhite
        aadServiceLifeYearsTextField.layer.cornerRadius = cornerRadius10
        aadServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadServiceLifeYearsTextField.textAlignment = textAligmentCenter
        aadServiceLifeYearsTextField.tintColor = colorWhite
        aadServiceLifeYearsTextField.keyboardType = .numberPad
        aadServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: LINE TWO:
        
        lineTwoView.backgroundColor = colorDarkGray
        
        // MARK: MAIN CANOPY NAME:
        
        mainCanopyNameButton.setTitle("Основной парашют*", for: .normal)
        mainCanopyNameButton.backgroundColor = colorCell
        mainCanopyNameButton.setTitleColor(colorLightGray, for: .normal)
        mainCanopyNameButton.contentVerticalAlignment = textAligmentTop
        mainCanopyNameButton.titleLabel?.font = fontMediumStandart10
        mainCanopyNameButton.layer.cornerRadius = cornerRadius10
        mainCanopyNameTextField.placeholder = "Название парашюта"
        mainCanopyNameTextField.backgroundColor = colorTabBar
        mainCanopyNameTextField.font = fontRegularStandart12
        mainCanopyNameTextField.textColor = colorWhite
        mainCanopyNameTextField.layer.cornerRadius = cornerRadius10
        mainCanopyNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyNameTextField.textAlignment = textAligmentCenter
        mainCanopyNameTextField.tintColor = colorWhite
        mainCanopyNameTextField.layer.masksToBounds = true
        mainCanopyNameTextField.inputView = mainCanopyPickerView
        mainCanopyPickerView.backgroundColor = colorTabBar
        
        // MARK: MAIN CANOPY DOM:
        
        mainCanopyDomButton.setTitle("Дата изготовления*", for: .normal)
        mainCanopyDomButton.backgroundColor = colorCell
        mainCanopyDomButton.setTitleColor(colorLightGray, for: .normal)
        mainCanopyDomButton.contentVerticalAlignment = textAligmentTop
        mainCanopyDomButton.titleLabel?.font = fontMediumStandart10
        mainCanopyDomButton.layer.cornerRadius = cornerRadius10
        mainCanopyDomTextField.placeholder = "мм.гггг"
        mainCanopyDomTextField.backgroundColor = colorTabBar
        mainCanopyDomTextField.font = fontRegularStandart12
        mainCanopyDomTextField.textColor = colorWhite
        mainCanopyDomTextField.layer.cornerRadius = cornerRadius10
        mainCanopyDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyDomTextField.textAlignment = textAligmentCenter
        mainCanopyDomTextField.tintColor = colorWhite
        mainCanopyDomTextField.layer.masksToBounds = true
        mainCanopyDomTextField.inputView = mainCanopyDomPickerView
        mainCanopyDomPickerView.setValue(colorWhite, forKeyPath: "textColor")
        mainCanopyDomPickerView.datePickerMode = .date
        mainCanopyDomPickerView.preferredDatePickerStyle = .wheels
        mainCanopyDomPickerView.maximumDate = Date()
        mainCanopyDomPickerView.backgroundColor = colorTabBar
        mainCanopyDomPickerView.addTarget(self, action: #selector(mainCanopyDomPickerValueChanged), for: .valueChanged)
        
        // MARK: MAIN CANOPY SERIAL NUMBER:
        
        mainCanopySerialNumberButton.setTitle("Серийный номер*", for: .normal)
        mainCanopySerialNumberButton.backgroundColor = colorCell
        mainCanopySerialNumberButton.setTitleColor(colorLightGray, for: .normal)
        mainCanopySerialNumberButton.contentVerticalAlignment = textAligmentTop
        mainCanopySerialNumberButton.titleLabel?.font = fontMediumStandart10
        mainCanopySerialNumberButton.layer.cornerRadius = cornerRadius10
        mainCanopySerialNumberTextField.placeholder = "№"
        mainCanopySerialNumberTextField.backgroundColor = colorTabBar
        mainCanopySerialNumberTextField.font = fontRegularStandart12
        mainCanopySerialNumberTextField.textColor = colorWhite
        mainCanopySerialNumberTextField.layer.cornerRadius = cornerRadius10
        mainCanopySerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopySerialNumberTextField.textAlignment = textAligmentCenter
        mainCanopySerialNumberTextField.tintColor = colorWhite
        mainCanopySerialNumberTextField.layer.masksToBounds = true
        
        // MARK: MAIN CANOPY SERVICE LIFE YEARS:
        
        mainCanopyServiceLifeYearsButton.setTitle("Гарантийный ресурс*", for: .normal)
        mainCanopyServiceLifeYearsButton.backgroundColor = colorCell
        mainCanopyServiceLifeYearsButton.setTitleColor(colorLightGray, for: .normal)
        mainCanopyServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        mainCanopyServiceLifeYearsButton.titleLabel?.font = fontMediumStandart10
        mainCanopyServiceLifeYearsButton.layer.cornerRadius = cornerRadius10
        mainCanopyServiceLifeYearsTextField.placeholder = "Количество лет"
        mainCanopyServiceLifeYearsTextField.backgroundColor = colorTabBar
        mainCanopyServiceLifeYearsTextField.font = fontRegularStandart12
        mainCanopyServiceLifeYearsTextField.textColor = colorWhite
        mainCanopyServiceLifeYearsTextField.layer.cornerRadius = cornerRadius10
        mainCanopyServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyServiceLifeYearsTextField.textAlignment = textAligmentCenter
        mainCanopyServiceLifeYearsTextField.tintColor = colorWhite
        mainCanopyServiceLifeYearsTextField.keyboardType = .numberPad
        mainCanopyServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: MAIN CANOPY SERVICE LIFE JUMPS:
        
        mainCanopyServiceLifeJumpsButton.setTitle("Гарантийный ресурс*", for: .normal)
        mainCanopyServiceLifeJumpsButton.backgroundColor = colorCell
        mainCanopyServiceLifeJumpsButton.setTitleColor(colorLightGray, for: .normal)
        mainCanopyServiceLifeJumpsButton.contentVerticalAlignment = textAligmentTop
        mainCanopyServiceLifeJumpsButton.titleLabel?.font = fontMediumStandart10
        mainCanopyServiceLifeJumpsButton.layer.cornerRadius = cornerRadius10
        mainCanopyServiceLifeJumpsTextField.placeholder = "Количество прыжков"
        mainCanopyServiceLifeJumpsTextField.backgroundColor = colorTabBar
        mainCanopyServiceLifeJumpsTextField.font = fontRegularStandart12
        mainCanopyServiceLifeJumpsTextField.textColor = colorWhite
        mainCanopyServiceLifeJumpsTextField.layer.cornerRadius = cornerRadius10
        mainCanopyServiceLifeJumpsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyServiceLifeJumpsTextField.textAlignment = textAligmentCenter
        mainCanopyServiceLifeJumpsTextField.tintColor = colorWhite
        mainCanopyServiceLifeJumpsTextField.keyboardType = .numberPad
        mainCanopyServiceLifeJumpsTextField.layer.masksToBounds = true
        
        // MARK: MAIN CANOPY COUNT JUMPS:
        
        mainCanopyCountJumpsButton.setTitle("Количество применений*", for: .normal)
        mainCanopyCountJumpsButton.backgroundColor = colorCell
        mainCanopyCountJumpsButton.setTitleColor(colorLightGray, for: .normal)
        mainCanopyCountJumpsButton.contentVerticalAlignment = textAligmentTop
        mainCanopyCountJumpsButton.titleLabel?.font = fontMediumStandart10
        mainCanopyCountJumpsButton.layer.cornerRadius = cornerRadius10
        mainCanopyCountJumpsTextField.placeholder = "Значение при покупке"
        mainCanopyCountJumpsTextField.backgroundColor = colorTabBar
        mainCanopyCountJumpsTextField.font = fontRegularStandart12
        mainCanopyCountJumpsTextField.textColor = colorWhite
        mainCanopyCountJumpsTextField.layer.cornerRadius = cornerRadius10
        mainCanopyCountJumpsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyCountJumpsTextField.textAlignment = textAligmentCenter
        mainCanopyCountJumpsTextField.tintColor = colorWhite
        mainCanopyCountJumpsTextField.keyboardType = .numberPad
        mainCanopyCountJumpsTextField.layer.masksToBounds = true
        
        // MARK: LINE THREE:
        
        lineThreeView.backgroundColor = colorDarkGray
        
        // MARK: RESERVE CANOPY NAME:
        
        reserveCanopyNameButton.setTitle("Запасной парашют*", for: .normal)
        reserveCanopyNameButton.backgroundColor = colorCell
        reserveCanopyNameButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopyNameButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyNameButton.titleLabel?.font = fontMediumStandart10
        reserveCanopyNameButton.layer.cornerRadius = cornerRadius10
        reserveCanopyNameTextField.placeholder = "Название парашюта"
        reserveCanopyNameTextField.backgroundColor = colorTabBar
        reserveCanopyNameTextField.font = fontRegularStandart12
        reserveCanopyNameTextField.textColor = colorWhite
        reserveCanopyNameTextField.layer.cornerRadius = cornerRadius10
        reserveCanopyNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyNameTextField.textAlignment = textAligmentCenter
        reserveCanopyNameTextField.tintColor = colorWhite
        reserveCanopyNameTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY DOM:
        
        reserveCanopyDomButton.setTitle("Дата изготовления*", for: .normal)
        reserveCanopyDomButton.backgroundColor = colorCell
        reserveCanopyDomButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopyDomButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyDomButton.titleLabel?.font = fontMediumStandart10
        reserveCanopyDomButton.layer.cornerRadius = cornerRadius10
        reserveCanopyDomTextField.placeholder = "мм.гггг"
        reserveCanopyDomTextField.backgroundColor = colorTabBar
        reserveCanopyDomTextField.font = fontRegularStandart12
        reserveCanopyDomTextField.textColor = colorWhite
        reserveCanopyDomTextField.layer.cornerRadius = cornerRadius10
        reserveCanopyDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyDomTextField.textAlignment = textAligmentCenter
        reserveCanopyDomTextField.tintColor = colorWhite
        reserveCanopyDomTextField.layer.masksToBounds = true
        reserveCanopyDomTextField.inputView = reserveCanopyDomPickerView
        reserveCanopyDomPickerView.setValue(colorWhite, forKeyPath: "textColor")
        reserveCanopyDomPickerView.datePickerMode = .date
        reserveCanopyDomPickerView.preferredDatePickerStyle = .wheels
        reserveCanopyDomPickerView.maximumDate = Date()
        reserveCanopyDomPickerView.backgroundColor = colorTabBar
        reserveCanopyDomPickerView.addTarget(self, action: #selector(reserveCanopyDomPickerValueChanged), for: .valueChanged)
        
        // MARK: RESERVE CANOPY SERIAL NUMBER:
        
        reserveCanopySerialNumberButton.setTitle("Серийный номер*", for: .normal)
        reserveCanopySerialNumberButton.backgroundColor = colorCell
        reserveCanopySerialNumberButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopySerialNumberButton.contentVerticalAlignment = textAligmentTop
        reserveCanopySerialNumberButton.titleLabel?.font = fontMediumStandart10
        reserveCanopySerialNumberButton.layer.cornerRadius = cornerRadius10
        reserveCanopySerialNumberTextField.placeholder = "№"
        reserveCanopySerialNumberTextField.backgroundColor = colorTabBar
        reserveCanopySerialNumberTextField.font = fontRegularStandart12
        reserveCanopySerialNumberTextField.textColor = colorWhite
        reserveCanopySerialNumberTextField.layer.cornerRadius = cornerRadius10
        reserveCanopySerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopySerialNumberTextField.textAlignment = textAligmentCenter
        reserveCanopySerialNumberTextField.tintColor = colorWhite
        reserveCanopySerialNumberTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY SERVICE LIFE YEARS:
        
        reserveCanopyServiceLifeYearsButton.setTitle("Гарантийный ресурс*", for: .normal)
        reserveCanopyServiceLifeYearsButton.backgroundColor = colorCell
        reserveCanopyServiceLifeYearsButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopyServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyServiceLifeYearsButton.titleLabel?.font = fontMediumStandart10
        reserveCanopyServiceLifeYearsButton.layer.cornerRadius = cornerRadius10
        reserveCanopyServiceLifeYearsTextField.placeholder = "Количество лет"
        reserveCanopyServiceLifeYearsTextField.backgroundColor = colorTabBar
        reserveCanopyServiceLifeYearsTextField.font = fontRegularStandart12
        reserveCanopyServiceLifeYearsTextField.textColor = colorWhite
        reserveCanopyServiceLifeYearsTextField.layer.cornerRadius = cornerRadius10
        reserveCanopyServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyServiceLifeYearsTextField.textAlignment = textAligmentCenter
        reserveCanopyServiceLifeYearsTextField.tintColor = colorWhite
        reserveCanopyServiceLifeYearsTextField.keyboardType = .numberPad
        reserveCanopyServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY COUNT REPACK:
        
        reserveCanopyCountRepackButton.setTitle("Количество переукладок*", for: .normal)
        reserveCanopyCountRepackButton.backgroundColor = colorCell
        reserveCanopyCountRepackButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopyCountRepackButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyCountRepackButton.titleLabel?.font = fontMediumStandart10
        reserveCanopyCountRepackButton.layer.cornerRadius = cornerRadius10
        reserveCanopyCountRepackTextField.placeholder = "#"
        reserveCanopyCountRepackTextField.backgroundColor = colorTabBar
        reserveCanopyCountRepackTextField.font = fontRegularStandart12
        reserveCanopyCountRepackTextField.textColor = colorWhite
        reserveCanopyCountRepackTextField.layer.cornerRadius = cornerRadius10
        reserveCanopyCountRepackTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyCountRepackTextField.textAlignment = textAligmentCenter
        reserveCanopyCountRepackTextField.tintColor = colorWhite
        reserveCanopyCountRepackTextField.keyboardType = .numberPad
        reserveCanopyCountRepackTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY DATE PACK:

        reserveCanopyDatePackButton.setTitle("Дата укладки", for: .normal)
        reserveCanopyDatePackButton.backgroundColor = colorCell
        reserveCanopyDatePackButton.setTitleColor(colorLightGray, for: .normal)
        reserveCanopyDatePackButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyDatePackButton.titleLabel?.font = fontMediumStandart10
        reserveCanopyDatePackButton.layer.cornerRadius = cornerRadius10
        reserveCanopyDatePackTextField.placeholder = "дд.мм.гггг"
        reserveCanopyDatePackTextField.backgroundColor = colorTabBar
        reserveCanopyDatePackTextField.font = fontRegularStandart12
        reserveCanopyDatePackTextField.textColor = colorWhite
        reserveCanopyDatePackTextField.layer.cornerRadius = cornerRadius10
        reserveCanopyDatePackTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyDatePackTextField.textAlignment = textAligmentCenter
        reserveCanopyDatePackTextField.tintColor = colorWhite
        reserveCanopyDatePackTextField.layer.masksToBounds = true
        reserveCanopyDatePackTextField.inputView = reserveCanopyDatePackPickerView
        reserveCanopyDatePackPickerView.setValue(colorWhite, forKeyPath: "textColor")
        reserveCanopyDatePackPickerView.datePickerMode = .date
        reserveCanopyDatePackPickerView.preferredDatePickerStyle = .wheels
        reserveCanopyDatePackPickerView.maximumDate = Date()
        reserveCanopyDatePackPickerView.backgroundColor = colorTabBar
        reserveCanopyDatePackPickerView.addTarget(self, action: #selector(reserveCanopyDatePackPickerValueChanged), for: .valueChanged)
        
        // COMMENT SYSTEM:
        commentSystemButton.setTitle("Комментарий", for: .normal)
        commentSystemButton.backgroundColor = colorCell
        commentSystemButton.setTitleColor(colorLightGray, for: .normal)
        commentSystemButton.contentVerticalAlignment = textAligmentTop
        commentSystemButton.titleLabel?.font = fontMediumStandart12
        commentSystemButton.layer.cornerRadius = cornerRadius10
        commentSystemTextField.placeholder = "Опционально"
        commentSystemTextField.backgroundColor = colorTabBar
        commentSystemTextField.font = fontRegularStandart12
        commentSystemTextField.textColor = colorWhite
        commentSystemTextField.layer.cornerRadius = cornerRadius10
        commentSystemTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        commentSystemTextField.textAlignment = textAligmentCenter
        commentSystemTextField.tintColor = colorWhite
        commentSystemTextField.layer.masksToBounds = true
        
        // MARK: SAVE BUTTON:

        saveButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        saveButton.backgroundColor = colorCell
        saveButton.layer.cornerRadius = cornerRadius10
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = fontMediumStandart14
        
        // MARK: - TAP ON FREE SPACE FOR CLOSE ALL VIEWS:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - HELPERS:
    
    func configure(_ system: SystemStructure) {
        nameSystemTextField.text = system.name
        containerNameTextField.text = system.container.name
        containerDomTextField.text = system.container.dom
        containerSerialNumberTextField.text = system.container.serialNumber
        containerServiceLifeYearsTextField.text = system.container.serviceLifeYears
        aadNameTextField.text = system.aad.name
        aadDomTextField.text = system.aad.dom
        aadSerialNumberTextField.text = system.aad.serialNumber
        aadServiceLifeYearsTextField.text = system.aad.serviceLifeYears
        mainCanopyNameTextField.text = system.mainCanopy.name
        mainCanopyDomTextField.text = system.mainCanopy.dom
        mainCanopySerialNumberTextField.text = system.mainCanopy.serialNumber
        mainCanopyServiceLifeYearsTextField.text = system.mainCanopy.serviceLifeYears
        mainCanopyServiceLifeJumpsTextField.text = system.mainCanopy.serviceLifeJumps
        mainCanopyCountJumpsTextField.text = system.mainCanopy.countJumps
        reserveCanopyNameTextField.text = system.reserveCanopy.name
        reserveCanopyDomTextField.text = system.reserveCanopy.dom
        reserveCanopySerialNumberTextField.text = system.reserveCanopy.serialNumber
        reserveCanopyServiceLifeYearsTextField.text = system.reserveCanopy.serviceLifeYears
        reserveCanopyCountRepackTextField.text = system.reserveCanopy.countRepack
        reserveCanopyDatePackTextField.text = system.reserveCanopy.datePack
        commentSystemTextField.text = system.comment
    }
    
    // MARK: ACTION BUTTON SAVE:

    @objc private func actionButtonSaveTap() {
        guard nameSystemTextField.text != "",
        containerNameTextField.text != "",
        containerDomTextField.text != "",
        containerSerialNumberTextField.text != "",
        containerServiceLifeYearsTextField.text != "",
        aadNameTextField.text != "",
        aadDomTextField.text != "",
        aadSerialNumberTextField.text != "",
        aadServiceLifeYearsTextField.text != "",
        mainCanopyNameTextField.text != "",
        mainCanopyDomTextField.text != "",
        mainCanopyCountJumpsTextField.text != "",
        mainCanopyServiceLifeYearsTextField.text != "",
        mainCanopyServiceLifeJumpsTextField.text != "",
        mainCanopyCountJumpsTextField.text != "",
        reserveCanopyNameTextField.text != "",
        reserveCanopyDomTextField.text != "",
        reserveCanopySerialNumberTextField.text != "",
        reserveCanopyServiceLifeYearsTextField.text != "",
        reserveCanopyCountRepackTextField.text != ""
        else {
            resignFirstResponders()
            actionButtonSaveRedColor()
            vibrationOn.vibrationError()
            return
        }
        saveNewSystem()
        actionButtonSaveGreenColor()
        vibrationOn.vibrationSucces()
        playSoundSucces()
        resignFirstResponders()
        clearTextViews()
    }
    
    // MARK: SAVE AND ADD NEW SYSTEM IN ARRAY SYSTEM:

    func saveNewSystem() {
        let newSystem = SystemStructure(name: nameSystemTextField.text ?? "", container: .init(name: containerNameTextField.text ?? "", dom: containerDomTextField.text ?? "", serialNumber: containerSerialNumberTextField.text ?? "", serviceLifeYears: containerServiceLifeYearsTextField.text ?? ""), aad: .init(name: aadNameTextField.text ?? "", dom: aadDomTextField.text ?? "", serialNumber: aadSerialNumberTextField.text ?? "", serviceLifeYears: aadServiceLifeYearsTextField.text ?? ""), mainCanopy: .init(name: mainCanopyNameTextField.text ?? "", dom: mainCanopyDomTextField.text ?? "", serialNumber: mainCanopySerialNumberTextField.text ?? "", serviceLifeYears: mainCanopyServiceLifeYearsTextField.text ?? "", serviceLifeJumps: mainCanopyServiceLifeJumpsTextField.text ?? "", countJumps: mainCanopyCountJumpsTextField.text ?? ""), reserveCanopy: .init(name: reserveCanopyNameTextField.text ?? "", dom: reserveCanopyDomTextField.text ?? "", serialNumber: reserveCanopySerialNumberTextField.text ?? "", serviceLifeYears: reserveCanopyServiceLifeYearsTextField.text ?? "", countRepack: reserveCanopyCountRepackTextField.text ?? "", datePack: reserveCanopyDatePackTextField.text ?? ""), comment: commentSystemTextField.text ?? "")
        delegate?.saveSystem(newSystem)
    }
    
    // MARK: CLEAR ALL TEXT FIELDS:
    
    private func clearTextViews() {
        nameSystemTextField.text = ""
        containerNameTextField.text = ""
        containerDomTextField.text = ""
        containerSerialNumberTextField.text = ""
        containerServiceLifeYearsTextField.text = ""
        aadNameTextField.text = ""
        aadDomTextField.text = ""
        aadSerialNumberTextField.text = ""
        aadServiceLifeYearsTextField.text = ""
        mainCanopyNameTextField.text = ""
        mainCanopyDomTextField.text = ""
        mainCanopySerialNumberTextField.text = ""
        mainCanopyServiceLifeYearsTextField.text = ""
        mainCanopyServiceLifeJumpsTextField.text = ""
        mainCanopyCountJumpsTextField.text = ""
        reserveCanopyNameTextField.text = ""
        reserveCanopyDomTextField.text = ""
        reserveCanopySerialNumberTextField.text = ""
        reserveCanopyServiceLifeYearsTextField.text = ""
        reserveCanopyCountRepackTextField.text = ""
        reserveCanopyDatePackTextField.text = ""
        commentSystemTextField.text = ""
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        nameSystemTextField.resignFirstResponder()
        containerNameTextField.resignFirstResponder()
        containerDomTextField.resignFirstResponder()
        containerSerialNumberTextField.resignFirstResponder()
        containerServiceLifeYearsTextField.resignFirstResponder()
        aadNameTextField.resignFirstResponder()
        aadDomTextField.resignFirstResponder()
        aadSerialNumberTextField.resignFirstResponder()
        aadServiceLifeYearsTextField.resignFirstResponder()
        mainCanopyNameTextField.resignFirstResponder()
        mainCanopyDomTextField.resignFirstResponder()
        mainCanopyCountJumpsTextField.resignFirstResponder()
        mainCanopyServiceLifeYearsTextField.resignFirstResponder()
        mainCanopyServiceLifeJumpsTextField.resignFirstResponder()
        mainCanopyCountJumpsTextField.resignFirstResponder()
        reserveCanopyNameTextField.resignFirstResponder()
        reserveCanopyDomTextField.resignFirstResponder()
        reserveCanopySerialNumberTextField.resignFirstResponder()
        reserveCanopyServiceLifeYearsTextField.resignFirstResponder()
        reserveCanopyCountRepackTextField.resignFirstResponder()
        reserveCanopyDatePackTextField.resignFirstResponder()
        commentSystemTextField.resignFirstResponder()
    }
    
    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = colorCell
        }
    }
    
    private func actionButtonSaveRedColor() {
        saveButton.backgroundColor = colorRed
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
    
    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc private func tapGestureDone() {
        contentView.endEditing(true)
    }

    // MARK: DATE PICKERS:

    @objc private func containerDomPickerValueChanged() {
        getDateFromPickerToContainer()
    }
    
    @objc private func aadDomPickerValueChanged() {
        getDateFromPickerToAad()
    }
    
    @objc private func mainCanopyDomPickerValueChanged() {
        getDateFromPickerToMainCanopy()
    }
    
    @objc private func reserveCanopyDomPickerValueChanged() {
        getDateFromPickerToReserveCanopy()
    }
    
    @objc private func reserveCanopyDatePackPickerValueChanged() {
        getDateFromPickerToReserveCanopyDatePack()
    }
    
    // MARK: DATE FORMATTERS:

    private func getDateFromPickerToContainer() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        containerDomTextField.text = dateFormatter.string(from: containerDomPickerView.date)
    }
    
    private func getDateFromPickerToAad() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        aadDomTextField.text = dateFormatter.string(from: aadDomPickerView.date)
    }
    
    private func getDateFromPickerToMainCanopy() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        mainCanopyDomTextField.text = dateFormatter.string(from: mainCanopyDomPickerView.date)
    }
    
    private func getDateFromPickerToReserveCanopy() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        reserveCanopyDomTextField.text = dateFormatter.string(from: reserveCanopyDomPickerView.date)
    }
    
    private func getDateFromPickerToReserveCanopyDatePack() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        reserveCanopyDatePackTextField.text = dateFormatter.string(from: reserveCanopyDatePackPickerView.date)
    }
}

// MARK: - EXTENSIONS FOR PICKER VIEW DELEGATE:

extension EditSystemCell: UIPickerViewDelegate {
    // MARK: ФУНКЦИЯ КОТОРАЯ ПРИСВАИВАЕТ ЗНАЧЕНИЕ ИЗ ПИКЕР ВЬЮ В ТЕКСТ ФИЛД:

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if arrayCanopiesPickerViewValues.count == 0 {
            return
        }
        
        if pickerView == mainCanopyPickerView {
            mainCanopyNameTextField.text = arrayCanopiesPickerViewValues.sorted()[row]
        }
    }
}

extension EditSystemCell: UIPickerViewDataSource {
    // MARK: - КОЛИЧЕСТВО КОЛОНОК В PICKER VIEW:
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // MARK: - КОЛИЧЕСТВО ТЕКСТОВЫХ ВАРИАНТОВ ДЛЯ ПИКЕРА ИЗ МАССИВА:

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == mainCanopyPickerView {
            return arrayCanopiesPickerViewValues.count
        }
        return 0
    }
    
    // MARK: - ВАРИАНТЫ ДЛЯ ЗАПОЛНЕНИЯ ПИКЕРА ТЕКСТОМ ИЗ ЗНАЧЕНИЙ В МАССИВЕ:

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if arrayCanopiesPickerViewValues.count == 0 {
            return ""
        }
        
        if pickerView == mainCanopyPickerView {
            return arrayCanopiesPickerViewValues.sorted()[row]
        }
        return ""
    }
}
