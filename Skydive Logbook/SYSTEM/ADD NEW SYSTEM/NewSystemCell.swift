import AudioToolbox
import AVFoundation
import UIKit
import RealmSwift
import AlertKit
import Adapty

final class NewSystemCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let nameSystemButton = UIButton()
    private let nameSystemTextField = UITextField()
    
    private let containerNameButton = UIButton()
    private let containerNameTextField = UITextField()
    
    private let containerDomButton = UIButton()
    private let containerDomTextField = UITextField()
    private let containerDomDatePicker = UIDatePicker()
    
    private let containerSerialNumberButton = UIButton()
    private let containerSerialNumberTextField = UITextField()
    
    private let containerServiceLifeYearsButton = UIButton()
    private let containerServiceLifeYearsTextField = UITextField()
    
    private let lineOneView = UIView()
    
    private let aadNameButton = UIButton()
    private let aadNameTextField = UITextField()
    
    private let aadDomButton = UIButton()
    private let aadDomTextField = UITextField()
    private let aadDomDatePicker = UIDatePicker()
    
    private let aadSerialNumberButton = UIButton()
    private let aadSerialNumberTextField = UITextField()
    
    private let aadServiceLifeYearsButton = UIButton()
    private let aadServiceLifeYearsTextField = UITextField()
    
    private let lineTwoView = UIView()
    
    private let mainCanopyNameButton = UIButton()
    private let mainCanopyNameTextField = UITextField()
    private let mainCanopyPickerView = UIPickerView()
    
    private let mainCanopyDomButton = UIButton()
    private let mainCanopyDomTextField = UITextField()
    private let mainCanopyDomDatePicker = UIDatePicker()
    
    private let mainCanopySerialNumberButton = UIButton()
    private let mainCanopySerialNumberTextField = UITextField()
    
    private let mainCanopyServiceLifeYearsButton = UIButton()
    private let mainCanopyServiceLifeYearsTextField = UITextField()
    
    private let mainCanopyServiceLifeJumpsButton = UIButton()
    private let mainCanopyServiceLifeJumpsTextField = UITextField()
    
    private let mainCanopyCountJumpsButton = UIButton()
    private let mainCanopyCountJumpsTextField = UITextField()
    
    private let lineThreeView = UIView()
    
    private let reserveCanopyNameButton = UIButton()
    private let reserveCanopyNameTextField = UITextField()
    
    private let reserveCanopyDomButton = UIButton()
    private let reserveCanopyDomTextField = UITextField()
    private let reserveCanopyDomDatePicker = UIDatePicker()
    
    private let reserveCanopySerialNumberButton = UIButton()
    private let reserveCanopySerialNumberTextField = UITextField()
    
    private let reserveCanopyServiceLifeYearsButton = UIButton()
    private let reserveCanopyServiceLifeYearsTextField = UITextField()
    
    private let reserveCanopyCountRepackButton = UIButton()
    private let reserveCanopyCountRepackTextField = UITextField()
    
    private let reserveCanopyDatePackButton = UIButton()
    private let reserveCanopyDatePackTextField = UITextField()
    
    private let commentSystemButton = UIButton()
    private let commentSystemTextField = UITextField()
    
    private let cleanButton = UIButton()
    private let saveButton = UIButton()
    
    private let dateFormatter = DateFormatter()
    private let realmManager = RealmManager()
    
    private var player = AVAudioPlayer()
    var showPaymentAlert: (() -> ())?
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUI()
        configureGestures()
        mainCanopyPickerView.delegate = self
        mainCanopyPickerView.dataSource = self
        nameSystemTextField.delegate = self
        containerNameTextField.delegate = self
        containerDomTextField.delegate = self
        containerSerialNumberTextField.delegate = self
        containerServiceLifeYearsTextField.delegate = self
        aadNameTextField.delegate = self
        aadDomTextField.delegate = self
        aadSerialNumberTextField.delegate = self
        aadServiceLifeYearsTextField.delegate = self
        mainCanopyNameTextField.delegate = self
        mainCanopyDomTextField.delegate = self
        mainCanopySerialNumberTextField.delegate = self
        mainCanopyServiceLifeYearsTextField.delegate = self
        mainCanopyServiceLifeJumpsTextField.delegate = self
        mainCanopyCountJumpsTextField.delegate = self
        reserveCanopyNameTextField.delegate = self
        reserveCanopyDomTextField.delegate = self
        reserveCanopySerialNumberTextField.delegate = self
        reserveCanopyServiceLifeYearsTextField.delegate = self
        reserveCanopyCountRepackTextField.delegate = self
        reserveCanopyDatePackTextField.delegate = self
        commentSystemTextField.delegate = self
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
                                cleanButton, saveButton)
        
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
        nameSystemButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameSystemButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        nameSystemTextField.translatesAutoresizingMaskIntoConstraints = false
        nameSystemTextField.bottomAnchor.constraint(equalTo: nameSystemButton.bottomAnchor, constant: 0).isActive = true
        nameSystemTextField.centerXAnchor.constraint(equalTo: nameSystemButton.centerXAnchor).isActive = true
        nameSystemTextField.heightAnchor.constraint(equalTo: nameSystemButton.heightAnchor, multiplier: 0.5).isActive = true
        nameSystemTextField.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CONTAINER NAME:
        
        containerNameButton.translatesAutoresizingMaskIntoConstraints = false
        containerNameButton.topAnchor.constraint(equalTo: nameSystemButton.bottomAnchor, constant: 15).isActive = true
        containerNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        containerDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        containerDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        containerDomTextField.translatesAutoresizingMaskIntoConstraints = false
        containerDomTextField.bottomAnchor.constraint(equalTo: containerDomButton.bottomAnchor, constant: 0).isActive = true
        containerDomTextField.centerXAnchor.constraint(equalTo: containerDomButton.centerXAnchor).isActive = true
        containerDomTextField.heightAnchor.constraint(equalTo: containerDomButton.heightAnchor, multiplier: 0.5).isActive = true
        containerDomTextField.widthAnchor.constraint(equalTo: containerDomButton.widthAnchor, multiplier: 1).isActive = true
        
        containerDomDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: CONTAINER SERIAL NUMBER:
        
        containerSerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        containerSerialNumberButton.topAnchor.constraint(equalTo: containerNameButton.bottomAnchor, constant: 5).isActive = true
        containerSerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        containerServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
        lineOneView.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 0.25).isActive = true
        
        // MARK: AAD NAME:
        
        aadNameButton.translatesAutoresizingMaskIntoConstraints = false
        aadNameButton.topAnchor.constraint(equalTo: lineOneView.bottomAnchor, constant: 10).isActive = true
        aadNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        aadDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        aadDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        aadDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        aadDomTextField.translatesAutoresizingMaskIntoConstraints = false
        aadDomTextField.bottomAnchor.constraint(equalTo: aadDomButton.bottomAnchor, constant: 0).isActive = true
        aadDomTextField.centerXAnchor.constraint(equalTo: aadDomButton.centerXAnchor).isActive = true
        aadDomTextField.heightAnchor.constraint(equalTo: aadDomButton.heightAnchor, multiplier: 0.5).isActive = true
        aadDomTextField.widthAnchor.constraint(equalTo: aadDomButton.widthAnchor, multiplier: 1).isActive = true
        
        aadDomDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: AAD SERIAL NUMBER:
        
        aadSerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        aadSerialNumberButton.topAnchor.constraint(equalTo: aadNameButton.bottomAnchor, constant: 5).isActive = true
        aadSerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        aadSerialNumberButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        aadSerialNumberButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        aadSerialNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        aadSerialNumberTextField.bottomAnchor.constraint(equalTo: aadSerialNumberButton.bottomAnchor, constant: 0).isActive = true
        aadSerialNumberTextField.centerXAnchor.constraint(equalTo: aadSerialNumberButton.centerXAnchor).isActive = true
        aadSerialNumberTextField.heightAnchor.constraint(equalTo: aadSerialNumberButton.heightAnchor, multiplier: 0.5).isActive = true
        aadSerialNumberTextField.widthAnchor.constraint(equalTo: aadSerialNumberButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: AAD SERVICE LIFE YEARS:
        
        aadServiceLifeYearsButton.translatesAutoresizingMaskIntoConstraints = false
        aadServiceLifeYearsButton.topAnchor.constraint(equalTo: aadDomButton.bottomAnchor, constant: 5).isActive = true
        aadServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
        lineTwoView.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 0.25).isActive = true
        
        // MARK: MAIN CANOPY NAME:
        
        mainCanopyNameButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyNameButton.topAnchor.constraint(equalTo: lineTwoView.bottomAnchor, constant: 10).isActive = true
        mainCanopyNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        mainCanopyDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        mainCanopyDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        mainCanopyDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        mainCanopyDomTextField.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyDomTextField.bottomAnchor.constraint(equalTo: mainCanopyDomButton.bottomAnchor, constant: 0).isActive = true
        mainCanopyDomTextField.centerXAnchor.constraint(equalTo: mainCanopyDomButton.centerXAnchor).isActive = true
        mainCanopyDomTextField.heightAnchor.constraint(equalTo: mainCanopyDomButton.heightAnchor, multiplier: 0.5).isActive = true
        mainCanopyDomTextField.widthAnchor.constraint(equalTo: mainCanopyDomButton.widthAnchor, multiplier: 1).isActive = true
        
        mainCanopyDomDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: MAIN CANOPY SERIAL NUMBER:
        
        mainCanopySerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        mainCanopySerialNumberButton.topAnchor.constraint(equalTo: mainCanopyNameButton.bottomAnchor, constant: 5).isActive = true
        mainCanopySerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        mainCanopyServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
        mainCanopyServiceLifeJumpsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        mainCanopyCountJumpsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
        lineThreeView.widthAnchor.constraint(equalTo: nameSystemButton.widthAnchor, multiplier: 0.25).isActive = true
        
        // MARK: RESERVE CANOPY NAME:
        
        reserveCanopyNameButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyNameButton.topAnchor.constraint(equalTo: lineThreeView.bottomAnchor, constant: 10).isActive = true
        reserveCanopyNameButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        reserveCanopyDomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyDomButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        reserveCanopyDomButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDomTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDomTextField.bottomAnchor.constraint(equalTo: reserveCanopyDomButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyDomTextField.centerXAnchor.constraint(equalTo: reserveCanopyDomButton.centerXAnchor).isActive = true
        reserveCanopyDomTextField.heightAnchor.constraint(equalTo: reserveCanopyDomButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyDomTextField.widthAnchor.constraint(equalTo: reserveCanopyDomButton.widthAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDomDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: RESERVE CANOPY SERIAL NUMBER:
        
        reserveCanopySerialNumberButton.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopySerialNumberButton.topAnchor.constraint(equalTo: reserveCanopyNameButton.bottomAnchor, constant: 5).isActive = true
        reserveCanopySerialNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        reserveCanopyServiceLifeYearsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
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
        reserveCanopyCountRepackButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
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
        reserveCanopyDatePackButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyDatePackButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        reserveCanopyDatePackButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true
        
        reserveCanopyDatePackTextField.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDatePackTextField.bottomAnchor.constraint(equalTo: reserveCanopyDatePackButton.bottomAnchor, constant: 0).isActive = true
        reserveCanopyDatePackTextField.centerXAnchor.constraint(equalTo: reserveCanopyDatePackButton.centerXAnchor).isActive = true
        reserveCanopyDatePackTextField.heightAnchor.constraint(equalTo: reserveCanopyDatePackButton.heightAnchor, multiplier: 0.5).isActive = true
        reserveCanopyDatePackTextField.widthAnchor.constraint(equalTo: reserveCanopyDatePackButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: COMMENT SYSTEM:
        commentSystemButton.translatesAutoresizingMaskIntoConstraints = false
        commentSystemButton.topAnchor.constraint(equalTo: reserveCanopyDatePackButton.bottomAnchor, constant: 15).isActive = true
        commentSystemButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        commentSystemButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.2).isActive = true
        commentSystemButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        commentSystemButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        commentSystemTextField.translatesAutoresizingMaskIntoConstraints = false
        commentSystemTextField.bottomAnchor.constraint(equalTo: commentSystemButton.bottomAnchor, constant: 0).isActive = true
        commentSystemTextField.centerXAnchor.constraint(equalTo: commentSystemButton.centerXAnchor).isActive = true
        commentSystemTextField.heightAnchor.constraint(equalTo: commentSystemButton.heightAnchor, multiplier: 0.5).isActive = true
        commentSystemTextField.widthAnchor.constraint(equalTo: commentSystemButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.topAnchor.constraint(equalTo: commentSystemTextField.bottomAnchor, constant: 15).isActive = true
        cleanButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cleanButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        cleanButton.addTarget(self, action: #selector(actionButtonCleanTap), for: .touchUpInside)
        
        // MARK: SAVE BUTTON:

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: commentSystemTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        saveButton.addTarget(self, action: #selector(actionButtonSaveTap), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        selectionStyle = .none
        contentView.backgroundColor = .colorBackground
        
        // MARK: NAME SYSTEM:
        
        nameSystemButton.setTitle(NSLocalizedString("Name system / new system cell", comment: "") + "*", for: .normal)
        nameSystemButton.backgroundColor = .colorCell
        nameSystemButton.setTitleColor(.colorLightGray, for: .normal)
        nameSystemButton.contentVerticalAlignment = textAligmentTop
        nameSystemButton.titleLabel?.font = FontManager.medium(size: 12).uiFont
        nameSystemButton.layer.cornerRadius = cornerRadius15
        nameSystemTextField.placeholder = NSLocalizedString("Name / new system cell", comment: "")
        nameSystemTextField.backgroundColor = .colorTabBar
        nameSystemTextField.font = FontManager.medium(size: 18).uiFont
        nameSystemTextField.textColor = .colorWhite
        nameSystemTextField.layer.cornerRadius = cornerRadius15
        nameSystemTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        nameSystemTextField.textAlignment = textAligmentCenter
        nameSystemTextField.tintColor = .colorWhite
        nameSystemTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER NAME:

        containerNameButton.setTitle(NSLocalizedString("Container / new system cell", comment: "") + "*", for: .normal)
        containerNameButton.backgroundColor = .colorCell
        containerNameButton.setTitleColor(.colorLightGray, for: .normal)
        containerNameButton.contentVerticalAlignment = textAligmentTop
        containerNameButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        containerNameButton.layer.cornerRadius = cornerRadius15
        containerNameTextField.placeholder = NSLocalizedString("Name container / new system cell", comment: "")
        containerNameTextField.backgroundColor = .colorTabBar
        containerNameTextField.font = FontManager.regular(size: 12).uiFont
        containerNameTextField.textColor = .colorWhite
        containerNameTextField.layer.cornerRadius = cornerRadius15
        containerNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerNameTextField.textAlignment = textAligmentCenter
        containerNameTextField.tintColor = .colorWhite
        containerNameTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER DOM:
        
        containerDomButton.setTitle(NSLocalizedString("DOM / new system cell", comment: "") + "*", for: .normal)
        containerDomButton.backgroundColor = .colorCell
        containerDomButton.setTitleColor(.colorLightGray, for: .normal)
        containerDomButton.contentVerticalAlignment = textAligmentTop
        containerDomButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        containerDomButton.layer.cornerRadius = cornerRadius15
        containerDomTextField.placeholder = NSLocalizedString("Date mm.yyyy / new system cell", comment: "")
        containerDomTextField.backgroundColor = .colorTabBar
        containerDomTextField.font = FontManager.regular(size: 12).uiFont
        containerDomTextField.textColor = .colorWhite
        containerDomTextField.layer.cornerRadius = cornerRadius15
        containerDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerDomTextField.textAlignment = textAligmentCenter
        containerDomTextField.tintColor = .colorWhite
        containerDomTextField.layer.masksToBounds = true
        containerDomTextField.inputView = containerDomDatePicker
        containerDomDatePicker.datePickerMode = .date
        containerDomDatePicker.preferredDatePickerStyle = .wheels
        containerDomDatePicker.maximumDate = Date()
        containerDomDatePicker.backgroundColor = .colorTabBar
        containerDomDatePicker.datePickerMode = .date
        containerDomDatePicker.addTarget(self, action: #selector(containerDomPickerValueChanged), for: .valueChanged)
        
        // MARK: CONTAINER SERIAL NUMBER:
        
        containerSerialNumberButton.setTitle(NSLocalizedString("Serial number / new system cell", comment: "") + "*", for: .normal)
        containerSerialNumberButton.backgroundColor = .colorCell
        containerSerialNumberButton.setTitleColor(.colorLightGray, for: .normal)
        containerSerialNumberButton.contentVerticalAlignment = textAligmentTop
        containerSerialNumberButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        containerSerialNumberButton.layer.cornerRadius = cornerRadius15
        containerSerialNumberTextField.placeholder = "№"
        containerSerialNumberTextField.backgroundColor = .colorTabBar
        containerSerialNumberTextField.font = FontManager.regular(size: 12).uiFont
        containerSerialNumberTextField.textColor = .colorWhite
        containerSerialNumberTextField.layer.cornerRadius = cornerRadius15
        containerSerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerSerialNumberTextField.textAlignment = textAligmentCenter
        containerSerialNumberTextField.tintColor = .colorWhite
        containerSerialNumberTextField.layer.masksToBounds = true
        
        // MARK: CONTAINER SERVICE LIFE:
        
        containerServiceLifeYearsButton.setTitle(NSLocalizedString("Warranty resource / new system cell", comment: "") + "*", for: .normal)
        containerServiceLifeYearsButton.backgroundColor = .colorCell
        containerServiceLifeYearsButton.setTitleColor(.colorLightGray, for: .normal)
        containerServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        containerServiceLifeYearsButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        containerServiceLifeYearsButton.layer.cornerRadius = cornerRadius15
        containerServiceLifeYearsTextField.placeholder = NSLocalizedString("Counts of years / new system cell", comment: "")
        containerServiceLifeYearsTextField.backgroundColor = .colorTabBar
        containerServiceLifeYearsTextField.font = FontManager.regular(size: 12).uiFont
        containerServiceLifeYearsTextField.textColor = .colorWhite
        containerServiceLifeYearsTextField.layer.cornerRadius = cornerRadius15
        containerServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        containerServiceLifeYearsTextField.textAlignment = textAligmentCenter
        containerServiceLifeYearsTextField.tintColor = .colorWhite
        containerServiceLifeYearsTextField.keyboardType = .numberPad
        containerServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: LINE ONE:
        
        lineOneView.backgroundColor = .colorDarkGray
        
        // MARK: AAD NAME:
        
        aadNameButton.setTitle(NSLocalizedString("AAD / new system cell", comment: "") + "*", for: .normal)
        aadNameButton.backgroundColor = .colorCell
        aadNameButton.setTitleColor(.colorLightGray, for: .normal)
        aadNameButton.contentVerticalAlignment = textAligmentTop
        aadNameButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        aadNameButton.layer.cornerRadius = cornerRadius15
        aadNameTextField.placeholder = NSLocalizedString("Name AAD / new system cell", comment: "")
        aadNameTextField.backgroundColor = .colorTabBar
        aadNameTextField.font = FontManager.regular(size: 12).uiFont
        aadNameTextField.textColor = .colorWhite
        aadNameTextField.layer.cornerRadius = cornerRadius15
        aadNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadNameTextField.textAlignment = textAligmentCenter
        aadNameTextField.tintColor = .colorWhite
        aadNameTextField.layer.masksToBounds = true
        
        // MARK: AAD DOM:
        
        aadDomButton.setTitle(NSLocalizedString("DOM / new system cell", comment: "") + "*", for: .normal)
        aadDomButton.backgroundColor = .colorCell
        aadDomButton.setTitleColor(.colorLightGray, for: .normal)
        aadDomButton.contentVerticalAlignment = textAligmentTop
        aadDomButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        aadDomButton.layer.cornerRadius = cornerRadius15
        aadDomTextField.placeholder = NSLocalizedString("Date mm.yyyy / new system cell", comment: "")
        aadDomTextField.backgroundColor = .colorTabBar
        aadDomTextField.font = FontManager.regular(size: 12).uiFont
        aadDomTextField.textColor = .colorWhite
        aadDomTextField.layer.cornerRadius = cornerRadius15
        aadDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadDomTextField.textAlignment = textAligmentCenter
        aadDomTextField.tintColor = .colorWhite
        aadDomTextField.layer.masksToBounds = true
        aadDomTextField.inputView = aadDomDatePicker
        aadDomDatePicker.datePickerMode = .date
        aadDomDatePicker.preferredDatePickerStyle = .wheels
        aadDomDatePicker.maximumDate = Date()
        aadDomDatePicker.backgroundColor = .colorTabBar
        aadDomDatePicker.addTarget(self, action: #selector(aadDomPickerValueChanged), for: .valueChanged)
        
        // MARK: AAD SERIAL NUMBER:
        
        aadSerialNumberButton.setTitle(NSLocalizedString("Serial number / new system cell", comment: "") + "*", for: .normal)
        aadSerialNumberButton.backgroundColor = .colorCell
        aadSerialNumberButton.setTitleColor(.colorLightGray, for: .normal)
        aadSerialNumberButton.contentVerticalAlignment = textAligmentTop
        aadSerialNumberButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        aadSerialNumberButton.layer.cornerRadius = cornerRadius15
        aadSerialNumberTextField.placeholder = "№"
        aadSerialNumberTextField.backgroundColor = .colorTabBar
        aadSerialNumberTextField.font = FontManager.regular(size: 12).uiFont
        aadSerialNumberTextField.textColor = .colorWhite
        aadSerialNumberTextField.layer.cornerRadius = cornerRadius15
        aadSerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadSerialNumberTextField.textAlignment = textAligmentCenter
        aadSerialNumberTextField.tintColor = .colorWhite
        aadSerialNumberTextField.layer.masksToBounds = true
        
        // MARK: AAD SERVISE LIFE YEARS:
        
        aadServiceLifeYearsButton.setTitle(NSLocalizedString("Warranty resource / new system cell", comment: "") + "*", for: .normal)
        aadServiceLifeYearsButton.backgroundColor = .colorCell
        aadServiceLifeYearsButton.setTitleColor(.colorLightGray, for: .normal)
        aadServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        aadServiceLifeYearsButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        aadServiceLifeYearsButton.layer.cornerRadius = cornerRadius15
        aadServiceLifeYearsTextField.placeholder = NSLocalizedString("Counts of years / new system cell", comment: "")
        aadServiceLifeYearsTextField.backgroundColor = .colorTabBar
        aadServiceLifeYearsTextField.font = FontManager.regular(size: 12).uiFont
        aadServiceLifeYearsTextField.textColor = .colorWhite
        aadServiceLifeYearsTextField.layer.cornerRadius = cornerRadius15
        aadServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aadServiceLifeYearsTextField.textAlignment = textAligmentCenter
        aadServiceLifeYearsTextField.tintColor = .colorWhite
        aadServiceLifeYearsTextField.keyboardType = .numberPad
        aadServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: LINE TWO:
        
        lineTwoView.backgroundColor = .colorDarkGray
        
        // MARK: MAIN CANOPY NAME:
        
        mainCanopyNameButton.setTitle(NSLocalizedString("Main canopy / new system cell", comment: "") + "*", for: .normal)
        mainCanopyNameButton.backgroundColor = .colorCell
        mainCanopyNameButton.setTitleColor(.colorLightGray, for: .normal)
        mainCanopyNameButton.contentVerticalAlignment = textAligmentTop
        mainCanopyNameButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        mainCanopyNameButton.layer.cornerRadius = cornerRadius15
        mainCanopyNameTextField.placeholder = NSLocalizedString("Name main canopy / new system cell", comment: "")
        mainCanopyNameTextField.backgroundColor = .colorTabBar
        mainCanopyNameTextField.font = FontManager.regular(size: 12).uiFont
        mainCanopyNameTextField.textColor = .colorWhite
        mainCanopyNameTextField.layer.cornerRadius = cornerRadius15
        mainCanopyNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyNameTextField.textAlignment = textAligmentCenter
        mainCanopyNameTextField.tintColor = .colorWhite
        mainCanopyNameTextField.layer.masksToBounds = true
        mainCanopyNameTextField.inputView = mainCanopyPickerView
        mainCanopyPickerView.backgroundColor = .colorTabBar
        
        // MARK: MAIN CANOPY DOM:
        
        mainCanopyDomButton.setTitle(NSLocalizedString("DOM / new system cell", comment: "") + "*", for: .normal)
        mainCanopyDomButton.backgroundColor = .colorCell
        mainCanopyDomButton.setTitleColor(.colorLightGray, for: .normal)
        mainCanopyDomButton.contentVerticalAlignment = textAligmentTop
        mainCanopyDomButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        mainCanopyDomButton.layer.cornerRadius = cornerRadius15
        mainCanopyDomTextField.placeholder = NSLocalizedString("Date mm.yyyy / new system cell", comment: "")
        mainCanopyDomTextField.backgroundColor = .colorTabBar
        mainCanopyDomTextField.font = FontManager.regular(size: 12).uiFont
        mainCanopyDomTextField.textColor = .colorWhite
        mainCanopyDomTextField.layer.cornerRadius = cornerRadius15
        mainCanopyDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyDomTextField.textAlignment = textAligmentCenter
        mainCanopyDomTextField.tintColor = .colorWhite
        mainCanopyDomTextField.layer.masksToBounds = true
        mainCanopyDomTextField.inputView = mainCanopyDomDatePicker
        mainCanopyDomDatePicker.datePickerMode = .date
        mainCanopyDomDatePicker.preferredDatePickerStyle = .wheels
        mainCanopyDomDatePicker.maximumDate = Date()
        mainCanopyDomDatePicker.backgroundColor = .colorTabBar
        mainCanopyDomDatePicker.addTarget(self, action: #selector(mainCanopyDomPickerValueChanged), for: .valueChanged)
        
        // MARK: MAIN CANOPY SERIAL NUMBER:
        
        mainCanopySerialNumberButton.setTitle(NSLocalizedString("Serial number / new system cell", comment: "") + "*", for: .normal)
        mainCanopySerialNumberButton.backgroundColor = .colorCell
        mainCanopySerialNumberButton.setTitleColor(.colorLightGray, for: .normal)
        mainCanopySerialNumberButton.contentVerticalAlignment = textAligmentTop
        mainCanopySerialNumberButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        mainCanopySerialNumberButton.layer.cornerRadius = cornerRadius15
        mainCanopySerialNumberTextField.placeholder = "№"
        mainCanopySerialNumberTextField.backgroundColor = .colorTabBar
        mainCanopySerialNumberTextField.font = FontManager.regular(size: 12).uiFont
        mainCanopySerialNumberTextField.textColor = .colorWhite
        mainCanopySerialNumberTextField.layer.cornerRadius = cornerRadius15
        mainCanopySerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopySerialNumberTextField.textAlignment = textAligmentCenter
        mainCanopySerialNumberTextField.tintColor = .colorWhite
        mainCanopySerialNumberTextField.layer.masksToBounds = true
        
        // MARK: MAIN CANOPY SERVICE LIFE YEARS:
        
        mainCanopyServiceLifeYearsButton.setTitle(NSLocalizedString("Warranty resource / new system cell", comment: "") + "*", for: .normal)
        mainCanopyServiceLifeYearsButton.backgroundColor = .colorCell
        mainCanopyServiceLifeYearsButton.setTitleColor(.colorLightGray, for: .normal)
        mainCanopyServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        mainCanopyServiceLifeYearsButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        mainCanopyServiceLifeYearsButton.layer.cornerRadius = cornerRadius15
        mainCanopyServiceLifeYearsTextField.placeholder = NSLocalizedString("Counts of years / new system cell", comment: "")
        mainCanopyServiceLifeYearsTextField.backgroundColor = .colorTabBar
        mainCanopyServiceLifeYearsTextField.font = FontManager.regular(size: 12).uiFont
        mainCanopyServiceLifeYearsTextField.textColor = .colorWhite
        mainCanopyServiceLifeYearsTextField.layer.cornerRadius = cornerRadius15
        mainCanopyServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyServiceLifeYearsTextField.textAlignment = textAligmentCenter
        mainCanopyServiceLifeYearsTextField.tintColor = .colorWhite
        mainCanopyServiceLifeYearsTextField.keyboardType = .numberPad
        mainCanopyServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: MAIN CANOPY SERVICE LIFE JUMPS:
        
        mainCanopyServiceLifeJumpsButton.setTitle(NSLocalizedString("Warranty resource / new system cell", comment: "") + "*", for: .normal)
        mainCanopyServiceLifeJumpsButton.backgroundColor = .colorCell
        mainCanopyServiceLifeJumpsButton.setTitleColor(.colorLightGray, for: .normal)
        mainCanopyServiceLifeJumpsButton.contentVerticalAlignment = textAligmentTop
        mainCanopyServiceLifeJumpsButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        mainCanopyServiceLifeJumpsButton.layer.cornerRadius = cornerRadius15
        mainCanopyServiceLifeJumpsTextField.placeholder = NSLocalizedString("Counts of jumps / new system cell", comment: "")
        mainCanopyServiceLifeJumpsTextField.backgroundColor = .colorTabBar
        mainCanopyServiceLifeJumpsTextField.font = FontManager.regular(size: 12).uiFont
        mainCanopyServiceLifeJumpsTextField.textColor = .colorWhite
        mainCanopyServiceLifeJumpsTextField.layer.cornerRadius = cornerRadius15
        mainCanopyServiceLifeJumpsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyServiceLifeJumpsTextField.textAlignment = textAligmentCenter
        mainCanopyServiceLifeJumpsTextField.tintColor = .colorWhite
        mainCanopyServiceLifeJumpsTextField.keyboardType = .numberPad
        mainCanopyServiceLifeJumpsTextField.layer.masksToBounds = true
        
        // MARK: MAIN CANOPY COUNT JUMPS:
        
        mainCanopyCountJumpsButton.setTitle(NSLocalizedString("Counts of jumps main canopy / new system cell", comment: "") + "*", for: .normal)
        mainCanopyCountJumpsButton.backgroundColor = .colorCell
        mainCanopyCountJumpsButton.setTitleColor(.colorLightGray, for: .normal)
        mainCanopyCountJumpsButton.contentVerticalAlignment = textAligmentTop
        mainCanopyCountJumpsButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        mainCanopyCountJumpsButton.layer.cornerRadius = cornerRadius15
        mainCanopyCountJumpsTextField.placeholder = NSLocalizedString("The value of the purchase / new system cell", comment: "")
        mainCanopyCountJumpsTextField.backgroundColor = .colorTabBar
        mainCanopyCountJumpsTextField.font = FontManager.regular(size: 12).uiFont
        mainCanopyCountJumpsTextField.textColor = .colorWhite
        mainCanopyCountJumpsTextField.layer.cornerRadius = cornerRadius15
        mainCanopyCountJumpsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainCanopyCountJumpsTextField.textAlignment = textAligmentCenter
        mainCanopyCountJumpsTextField.tintColor = .colorWhite
        mainCanopyCountJumpsTextField.keyboardType = .numberPad
        mainCanopyCountJumpsTextField.layer.masksToBounds = true
        
        // MARK: LINE THREE:
        
        lineThreeView.backgroundColor = .colorDarkGray
        
        // MARK: RESERVE CANOPY NAME:
        
        reserveCanopyNameButton.setTitle(NSLocalizedString("Reserve canopy / new system cell", comment: "") + "*", for: .normal)
        reserveCanopyNameButton.backgroundColor = .colorCell
        reserveCanopyNameButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopyNameButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyNameButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        reserveCanopyNameButton.layer.cornerRadius = cornerRadius15
        reserveCanopyNameTextField.placeholder = NSLocalizedString("Name reserve canopy / new system cell", comment: "")
        reserveCanopyNameTextField.backgroundColor = .colorTabBar
        reserveCanopyNameTextField.font = FontManager.regular(size: 12).uiFont
        reserveCanopyNameTextField.textColor = .colorWhite
        reserveCanopyNameTextField.layer.cornerRadius = cornerRadius15
        reserveCanopyNameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyNameTextField.textAlignment = textAligmentCenter
        reserveCanopyNameTextField.tintColor = .colorWhite
        reserveCanopyNameTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY DOM:
        
        reserveCanopyDomButton.setTitle(NSLocalizedString("DOM / new system cell", comment: "") + "*", for: .normal)
        reserveCanopyDomButton.backgroundColor = .colorCell
        reserveCanopyDomButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopyDomButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyDomButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        reserveCanopyDomButton.layer.cornerRadius = cornerRadius15
        reserveCanopyDomTextField.placeholder = NSLocalizedString("Date mm.yyyy / new system cell", comment: "")
        reserveCanopyDomTextField.backgroundColor = .colorTabBar
        reserveCanopyDomTextField.font = FontManager.regular(size: 12).uiFont
        reserveCanopyDomTextField.textColor = .colorWhite
        reserveCanopyDomTextField.layer.cornerRadius = cornerRadius15
        reserveCanopyDomTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyDomTextField.textAlignment = textAligmentCenter
        reserveCanopyDomTextField.tintColor = .colorWhite
        reserveCanopyDomTextField.layer.masksToBounds = true
        reserveCanopyDomTextField.inputView = reserveCanopyDomDatePicker
        reserveCanopyDomDatePicker.datePickerMode = .date
        reserveCanopyDomDatePicker.preferredDatePickerStyle = .wheels
        reserveCanopyDomDatePicker.maximumDate = Date()
        reserveCanopyDomDatePicker.backgroundColor = .colorTabBar
        reserveCanopyDomDatePicker.addTarget(self, action: #selector(reserveCanopyDomPickerValueChanged), for: .valueChanged)
        
        // MARK: RESERVE CANOPY SERIAL NUMBER:
        
        reserveCanopySerialNumberButton.setTitle(NSLocalizedString("Serial number / new system cell", comment: "") + "*", for: .normal)
        reserveCanopySerialNumberButton.backgroundColor = .colorCell
        reserveCanopySerialNumberButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopySerialNumberButton.contentVerticalAlignment = textAligmentTop
        reserveCanopySerialNumberButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        reserveCanopySerialNumberButton.layer.cornerRadius = cornerRadius15
        reserveCanopySerialNumberTextField.placeholder = "№"
        reserveCanopySerialNumberTextField.backgroundColor = .colorTabBar
        reserveCanopySerialNumberTextField.font = FontManager.regular(size: 12).uiFont
        reserveCanopySerialNumberTextField.textColor = .colorWhite
        reserveCanopySerialNumberTextField.layer.cornerRadius = cornerRadius15
        reserveCanopySerialNumberTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopySerialNumberTextField.textAlignment = textAligmentCenter
        reserveCanopySerialNumberTextField.tintColor = .colorWhite
        reserveCanopySerialNumberTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY SERVICE LIFE YEARS:
        
        reserveCanopyServiceLifeYearsButton.setTitle(NSLocalizedString("Warranty resource / new system cell", comment: "") + "*", for: .normal)
        reserveCanopyServiceLifeYearsButton.backgroundColor = .colorCell
        reserveCanopyServiceLifeYearsButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopyServiceLifeYearsButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyServiceLifeYearsButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        reserveCanopyServiceLifeYearsButton.layer.cornerRadius = cornerRadius15
        reserveCanopyServiceLifeYearsTextField.placeholder = NSLocalizedString("Counts of years / new system cell", comment: "")
        reserveCanopyServiceLifeYearsTextField.backgroundColor = .colorTabBar
        reserveCanopyServiceLifeYearsTextField.font = FontManager.regular(size: 12).uiFont
        reserveCanopyServiceLifeYearsTextField.textColor = .colorWhite
        reserveCanopyServiceLifeYearsTextField.layer.cornerRadius = cornerRadius15
        reserveCanopyServiceLifeYearsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyServiceLifeYearsTextField.textAlignment = textAligmentCenter
        reserveCanopyServiceLifeYearsTextField.tintColor = .colorWhite
        reserveCanopyServiceLifeYearsTextField.keyboardType = .numberPad
        reserveCanopyServiceLifeYearsTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY COUNT REPACK:
        
        reserveCanopyCountRepackButton.setTitle(NSLocalizedString("Counts of repack reserve canopy / new system cell", comment: "") + "*", for: .normal)
        reserveCanopyCountRepackButton.backgroundColor = .colorCell
        reserveCanopyCountRepackButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopyCountRepackButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyCountRepackButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        reserveCanopyCountRepackButton.layer.cornerRadius = cornerRadius15
        reserveCanopyCountRepackTextField.placeholder = NSLocalizedString("Count / new system cell", comment: "")
        reserveCanopyCountRepackTextField.backgroundColor = .colorTabBar
        reserveCanopyCountRepackTextField.font = FontManager.regular(size: 12).uiFont
        reserveCanopyCountRepackTextField.textColor = .colorWhite
        reserveCanopyCountRepackTextField.layer.cornerRadius = cornerRadius15
        reserveCanopyCountRepackTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyCountRepackTextField.textAlignment = textAligmentCenter
        reserveCanopyCountRepackTextField.tintColor = .colorWhite
        reserveCanopyCountRepackTextField.keyboardType = .numberPad
        reserveCanopyCountRepackTextField.layer.masksToBounds = true
        
        // MARK: RESERVE CANOPY DATE PACK:

        reserveCanopyDatePackButton.setTitle(NSLocalizedString("Date of packing reserve canopy / new system cell", comment: ""), for: .normal)
        reserveCanopyDatePackButton.backgroundColor = .colorCell
        reserveCanopyDatePackButton.setTitleColor(.colorLightGray, for: .normal)
        reserveCanopyDatePackButton.contentVerticalAlignment = textAligmentTop
        reserveCanopyDatePackButton.titleLabel?.font = FontManager.medium(size: 10).uiFont
        reserveCanopyDatePackButton.layer.cornerRadius = cornerRadius15
        reserveCanopyDatePackTextField.placeholder = NSLocalizedString("Date dd.mm.yyyy / new system cell", comment: "")
        reserveCanopyDatePackTextField.backgroundColor = .colorTabBar
        reserveCanopyDatePackTextField.font = FontManager.regular(size: 12).uiFont
        reserveCanopyDatePackTextField.textColor = .colorWhite
        reserveCanopyDatePackTextField.layer.cornerRadius = cornerRadius15
        reserveCanopyDatePackTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        reserveCanopyDatePackTextField.textAlignment = textAligmentCenter
        reserveCanopyDatePackTextField.tintColor = .colorWhite
        reserveCanopyDatePackTextField.layer.masksToBounds = true
        reserveCanopyDatePackTextField.keyboardType = .numbersAndPunctuation
        
        // COMMENT SYSTEM:
        commentSystemButton.setTitle(NSLocalizedString("Comment / new system cell", comment: ""), for: .normal)
        commentSystemButton.backgroundColor = .colorCell
        commentSystemButton.setTitleColor(.colorLightGray, for: .normal)
        commentSystemButton.contentVerticalAlignment = textAligmentTop
        commentSystemButton.titleLabel?.font = FontManager.medium(size: 12).uiFont
        commentSystemButton.layer.cornerRadius = cornerRadius15
        commentSystemTextField.placeholder = NSLocalizedString("Optional / new system cell", comment: "")
        commentSystemTextField.backgroundColor = .colorTabBar
        commentSystemTextField.font = FontManager.regular(size: 12).uiFont
        commentSystemTextField.textColor = .colorWhite
        commentSystemTextField.layer.cornerRadius = cornerRadius15
        commentSystemTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        commentSystemTextField.textAlignment = textAligmentCenter
        commentSystemTextField.tintColor = .colorWhite
        commentSystemTextField.layer.masksToBounds = true
        
        // MARK: CLEAN BUTTON:

        cleanButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
        cleanButton.backgroundColor = .colorTabBar
        cleanButton.layer.cornerRadius = cornerRadius15
        cleanButton.setTitleColor(.colorWhite, for: .normal)
        cleanButton.setTitleColor(.systemBlue, for: .highlighted)
        cleanButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        
        // MARK: SAVE BUTTON:

        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.backgroundColor = .colorCell
        saveButton.layer.cornerRadius = cornerRadius15
        saveButton.setTitleColor(.colorWhite, for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .highlighted)
        saveButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
    }
    
    // MARK: - CONFIGURE GESTURES:
    
    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - LOAD SYSTEM FROM REALM:

    private func loadSystem() {
        arraySystemsRealm = realmManager.localRealm.objects(SystemClassRealm.self).map { $0 }
    }
    
    // MARK: - HELPERS:
    
    // MARK: ACTION BUTTON SAVE:

    @objc private func actionButtonSaveTap() {
        guard nameSystemTextField.text != "" else {
            showError(textField: nameSystemTextField)
            return
        }
        guard containerNameTextField.text != "" else {
            showError(textField: containerNameTextField)
            return
        }
        guard containerDomTextField.text != "" else {
            showError(textField: containerDomTextField)
            return
        }
        guard containerSerialNumberTextField.text != "" else {
            showError(textField: containerSerialNumberTextField)
            return
        }
        guard containerServiceLifeYearsTextField.text != "" else {
            showError(textField: containerServiceLifeYearsTextField)
            return
        }
        guard aadNameTextField.text != "" else {
            showError(textField: aadNameTextField)
            return
        }
        guard aadDomTextField.text != "" else {
            showError(textField: aadDomTextField)
            return
        }
        guard aadSerialNumberTextField.text != "" else {
            showError(textField: aadSerialNumberTextField)
            return
        }
        guard aadServiceLifeYearsTextField.text != "" else {
            showError(textField: aadServiceLifeYearsTextField)
            return
        }
        guard mainCanopyNameTextField.text != "" else {
            showError(textField: mainCanopyNameTextField)
            return
        }
        guard mainCanopyDomTextField.text != "" else {
            showError(textField: mainCanopyDomTextField)
            return
        }
        guard mainCanopySerialNumberTextField.text != "" else {
            showError(textField: mainCanopySerialNumberTextField)
            return
        }
        guard mainCanopyServiceLifeYearsTextField.text != "" else {
            showError(textField: mainCanopyServiceLifeYearsTextField)
            return
        }
        guard mainCanopyServiceLifeJumpsTextField.text != "" else {
            showError(textField: mainCanopyServiceLifeJumpsTextField)
            return
        }
        guard mainCanopyCountJumpsTextField.text != "" else {
            showError(textField: mainCanopyCountJumpsTextField)
            return
        }
        guard reserveCanopyNameTextField.text != "" else {
            showError(textField: reserveCanopyNameTextField)
            return
        }
        guard reserveCanopyDomTextField.text != "" else {
            showError(textField: reserveCanopyDomTextField)
            return
        }
        guard reserveCanopySerialNumberTextField.text != "" else {
            showError(textField: reserveCanopySerialNumberTextField)
            return
        }
        guard reserveCanopyServiceLifeYearsTextField.text != "" else {
            showError(textField: reserveCanopyServiceLifeYearsTextField)
            return
        }
        guard reserveCanopyCountRepackTextField.text != "" else {
            showError(textField: reserveCanopyCountRepackTextField)
            return
        }
        
        if arraySystemsRealm.count < 1 {
            saveNewSystem()
            DispatchQueue.main.async {
                self.actionButtonSaveGreenColor()
                self.playSoundSucces()
                self.resignFirstResponders()
                self.clearTextViews()
                self.alertKitSuccess()
                self.loadSystem()
            }
        } else {
            checkPaymentStatus()
        }
    }
    
    // MARK: CHECK PAYMENT STATUS:

    private func checkPaymentStatus() {
        Adapty.getProfile { [weak self] result in
            guard let self else { return }

            let isPremium = (try? result.get())?
                .accessLevels["premium"]?
                .isActive ?? false

            Task { @MainActor in
                if isPremium {
                    self.saveNewSystem()

                    self.actionButtonSaveGreenColor()
                    self.playSoundSucces()
                    self.resignFirstResponders()
                    self.clearTextViews()
                    self.alertKitSuccess()
                    self.loadSystem()

                    print("SAVE OK: I'm Premium!")
                } else {
                    self.actionButtonSaveRedColor()
                    self.clearTextViews()
                    self.resignFirstResponders()
                    self.alertKitError()
                    self.showPaymentAlert?()

                    print("NOT SAVE: I'm NOT Premium!")
                }
            }
        }
    }
    
    // MARK: SHOR ERROR FOR EMPTY FIELDS:
    
    private func showError(textField: UITextField) {
        textField.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            textField.backgroundColor = .colorTabBar
        }
        resignFirstResponders()
        actionButtonSaveRedColor()
        alertKitError()
    }
    
    // MARK: ACTION BUTTON CLEAN:

    @objc private func actionButtonCleanTap() {
        actionButtonCleanChangeColor()
        clearTextViews()
        resignFirstResponders()
        alertKitClear()
    }
    
    // MARK: SAVE AND ADD NEW SYSTEM IN ARRAY SYSTEM:

    private func saveNewSystem() {
        let newSystem = SystemClassRealm()
        
        newSystem.container = Container()
        newSystem.aad = Aad()
        newSystem.mainCanopy = MainCanopy()
        newSystem.reserveCanopy = ReserveCanopy()
        
        newSystem.name = nameSystemTextField.text ?? ""
        newSystem.container?.name = containerNameTextField.text ?? ""
        newSystem.container?.dom = containerDomTextField.text ?? ""
        newSystem.container?.serialNumber = containerSerialNumberTextField.text ?? ""
        newSystem.container?.serviceLifeYears = containerServiceLifeYearsTextField.text ?? ""
        
        newSystem.aad?.name = aadNameTextField.text ?? ""
        newSystem.aad?.dom = aadDomTextField.text ?? ""
        newSystem.aad?.serialNumber = aadSerialNumberTextField.text ?? ""
        newSystem.aad?.serviceLifeYears = aadServiceLifeYearsTextField.text ?? ""
        
        newSystem.mainCanopy?.name = mainCanopyNameTextField.text ?? ""
        newSystem.mainCanopy?.dom = mainCanopyDomTextField.text ?? ""
        newSystem.mainCanopy?.serialNumber = mainCanopySerialNumberTextField.text ?? ""
        newSystem.mainCanopy?.serviceLifeYears = mainCanopyServiceLifeYearsTextField.text ?? ""
        newSystem.mainCanopy?.serviceLifeJumps = mainCanopyServiceLifeJumpsTextField.text ?? ""
        newSystem.mainCanopy?.countJumps = mainCanopyCountJumpsTextField.text ?? ""
        
        newSystem.reserveCanopy?.name = reserveCanopyNameTextField.text ?? ""
        newSystem.reserveCanopy?.dom = reserveCanopyDomTextField.text ?? ""
        newSystem.reserveCanopy?.serialNumber = reserveCanopySerialNumberTextField.text ?? ""
        newSystem.reserveCanopy?.serviceLifeYears = reserveCanopyServiceLifeYearsTextField.text ?? ""
        newSystem.reserveCanopy?.countRepack = reserveCanopyCountRepackTextField.text ?? ""
        newSystem.reserveCanopy?.datePack = reserveCanopyDatePackTextField.text ?? ""
        
        newSystem.comment = commentSystemTextField.text ?? ""
        
        try? realmManager.localRealm.write {
            realmManager.localRealm.add(newSystem, update: .all)
        }
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
    
    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

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
    
    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

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
        contentView.endEditing(true)
    }
    
    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("System added / alert kit", comment: ""),
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
            haptic: .error
        )
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
    
    // MARK: DATE FORMATTERS:

    private func getDateFromPickerToContainer() {
        dateFormatter.dateFormat = "MM.yyyy"
        containerDomTextField.text = dateFormatter.string(from: containerDomDatePicker.date)
    }
    
    private func getDateFromPickerToAad() {
        dateFormatter.dateFormat = "MM.yyyy"
        aadDomTextField.text = dateFormatter.string(from: aadDomDatePicker.date)
    }
    
    private func getDateFromPickerToMainCanopy() {
        dateFormatter.dateFormat = "MM.yyyy"
        mainCanopyDomTextField.text = dateFormatter.string(from: mainCanopyDomDatePicker.date)
    }
    
    private func getDateFromPickerToReserveCanopy() {
        dateFormatter.dateFormat = "MM.yyyy"
        reserveCanopyDomTextField.text = dateFormatter.string(from: reserveCanopyDomDatePicker.date)
    }
}

// MARK: - EXTENSIONS FOR PICKER VIEW DELEGATE:

extension NewSystemCell: UIPickerViewDelegate {
    // MARK: ФУНКЦИЯ КОТОРАЯ ПРИСВАИВАЕТ ЗНАЧЕНИЕ ИЗ ПИКЕР ВЬЮ В ТЕКСТ ФИЛД:

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if arrayCanopiesRealm.count == 0 {
            return
        }
        
        if pickerView == mainCanopyPickerView {
            mainCanopyNameTextField.text = arrayCanopiesRealm[row].canopy
        }
    }
}

extension NewSystemCell: UIPickerViewDataSource {
    // MARK: - КОЛИЧЕСТВО КОЛОНОК В PICKER VIEW:
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // MARK: - КОЛИЧЕСТВО ТЕКСТОВЫХ ВАРИАНТОВ ДЛЯ ПИКЕРА ИЗ МАССИВА:

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == mainCanopyPickerView {
            return arrayCanopiesRealm.count
        }
        return 0
    }
    
    // MARK: - ВАРИАНТЫ ДЛЯ ЗАПОЛНЕНИЯ ПИКЕРА ТЕКСТОМ ИЗ ЗНАЧЕНИЙ В МАССИВЕ:

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == mainCanopyPickerView {
            return arrayCanopiesRealm[row].canopy
        }
        return ""
    }
}

extension NewSystemCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        VibrationManager.instance.vibrationStandart()
    }
}
