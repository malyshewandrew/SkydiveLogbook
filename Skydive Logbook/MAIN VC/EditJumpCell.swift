import AlertKit
import AudioToolbox
import AVFoundation
import Lottie
import UIKit

// MARK: - PROTOCOL:

protocol EditJumpCellDelegate {
    func saveJump(_ jump: JumpClassRealm)
}

final class EditJumpCell: UITableViewCell {
    // MARK: - PROPERTIES:
    
    private let dateButton = UIButton()
    private let dateTextField = UITextField()
    private let datePickerView = UIDatePicker()
    
    private let locationButton = UIButton()
    private let locationTextField = UITextField()
    private let locationPickerView = UIPickerView()
    
    private let aircraftButton = UIButton()
    private let aircraftTextField = UITextField()
    private let aircraftPickerView = UIPickerView()
    
    private let canopyButton = UIButton()
    private let canopyTextField = UITextField()
    private let canopyPickerView = UIPickerView()
    
    private let missionButton = UIButton()
    private let missionTextField = UITextField()
    private let missionPickerView = UIPickerView()
    private var missionPickerViewValues: [Mission] = []
    private var missionStrings: [String] = []
    
    private let heightButton = UIButton()
    private let heightTextField = UITextField()
    
    private let timeButton = UIButton()
    private let timeTextField = UITextField()
    
    private let cutawayButton = UIButton()
    private let cutawayTextField = UITextField()
    private let cutawayPickerView = UIPickerView()
    private var cutawayPickerViewValues: [Cutaway] = []
    private var cutawayStrings: [String] = []
    
    private let commentButton = UIButton()
    private let commentTextField = UITextField()
    
    private let saveButton = UIButton()
    
    private var player = AVAudioPlayer()
    
    let dateFormatter = DateFormatter()
    var delegate: EditJumpCellDelegate?
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        missionPickerViewValues = [.Accuracy, .Acrobatics, .AFF, .Base, .BaseWingsuit, .CanopyFormation, .Freefly, .Freestyle, .Fun, .Group, .Instructor, .Military, .ParaSki, .Proximity, .Skysurfing, .StaticLine, .Piloting, .Tandem, .Vertical, .Video, .Wingsuit, .Formation]
        missionStrings = missionPickerViewValues.map { $0.localizedValue }
        
        cutawayPickerViewValues = [.Yes, .No]
        cutawayStrings = cutawayPickerViewValues.map { $0.localizedValue }
        
        addSubviews()
        configureConstrains()
        configureUI()
        configureGestures()
        
        canopyPickerView.delegate = self
        missionPickerView.delegate = self
        locationPickerView.delegate = self
        aircraftPickerView.delegate = self
        cutawayPickerView.delegate = self
        
        dateTextField.delegate = self
        heightTextField.delegate = self
        timeTextField.delegate = self
        
        canopyPickerView.dataSource = self
        missionPickerView.dataSource = self
        locationPickerView.dataSource = self
        aircraftPickerView.dataSource = self
        cutawayPickerView.dataSource = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(dateButton, dateTextField, locationButton, locationTextField, aircraftButton, aircraftTextField, canopyButton, canopyTextField, missionButton, missionTextField, heightButton, heightTextField, timeButton, timeTextField, cutawayButton, cutawayTextField, commentButton, commentTextField, saveButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: DATE:
        
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        dateButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        dateButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true

        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.centerXAnchor.constraint(equalTo: dateButton.centerXAnchor).isActive = true
        dateTextField.bottomAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 0).isActive = true
        dateTextField.heightAnchor.constraint(equalTo: dateButton.heightAnchor, multiplier: 0.6).isActive = true
        dateTextField.widthAnchor.constraint(equalTo: dateButton.widthAnchor, multiplier: 1).isActive = true
        
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: LOCATION:

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 15).isActive = true
        locationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        locationButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        locationButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true
        
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.centerXAnchor.constraint(equalTo: locationButton.centerXAnchor).isActive = true
        locationTextField.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 0).isActive = true
        locationTextField.heightAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 0.6).isActive = true
        locationTextField.widthAnchor.constraint(equalTo: locationButton.widthAnchor, multiplier: 1).isActive = true
        
        locationPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: AIRCRAFT:
        
        aircraftButton.translatesAutoresizingMaskIntoConstraints = false
        aircraftButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 15).isActive = true
        aircraftButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        aircraftButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        aircraftButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true
        
        aircraftTextField.translatesAutoresizingMaskIntoConstraints = false
        aircraftTextField.centerXAnchor.constraint(equalTo: aircraftButton.centerXAnchor).isActive = true
        aircraftTextField.bottomAnchor.constraint(equalTo: aircraftButton.bottomAnchor, constant: 0).isActive = true
        aircraftTextField.heightAnchor.constraint(equalTo: aircraftButton.heightAnchor, multiplier: 0.6).isActive = true
        aircraftTextField.widthAnchor.constraint(equalTo: aircraftButton.widthAnchor, multiplier: 1).isActive = true
        
        aircraftPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: CANOPY:
        
        canopyButton.translatesAutoresizingMaskIntoConstraints = false
        canopyButton.topAnchor.constraint(equalTo: aircraftButton.bottomAnchor, constant: 15).isActive = true
        canopyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        canopyButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        canopyButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true
        
        canopyTextField.translatesAutoresizingMaskIntoConstraints = false
        canopyTextField.centerXAnchor.constraint(equalTo: canopyButton.centerXAnchor).isActive = true
        canopyTextField.bottomAnchor.constraint(equalTo: canopyButton.bottomAnchor, constant: 0).isActive = true
        canopyTextField.heightAnchor.constraint(equalTo: canopyButton.heightAnchor, multiplier: 0.6).isActive = true
        canopyTextField.widthAnchor.constraint(equalTo: canopyButton.widthAnchor, multiplier: 1).isActive = true
        
        canopyPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: MISSION:

        missionButton.translatesAutoresizingMaskIntoConstraints = false
        missionButton.topAnchor.constraint(equalTo: canopyButton.bottomAnchor, constant: 15).isActive = true
        missionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        missionButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        missionButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true
        
        missionTextField.translatesAutoresizingMaskIntoConstraints = false
        missionTextField.centerXAnchor.constraint(equalTo: missionButton.centerXAnchor).isActive = true
        missionTextField.bottomAnchor.constraint(equalTo: missionButton.bottomAnchor, constant: 0).isActive = true
        missionTextField.heightAnchor.constraint(equalTo: missionButton.heightAnchor, multiplier: 0.6).isActive = true
        missionTextField.widthAnchor.constraint(equalTo: missionButton.widthAnchor, multiplier: 1).isActive = true
        
        missionPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: HEIGHT:
        
        heightButton.translatesAutoresizingMaskIntoConstraints = false
        heightButton.topAnchor.constraint(equalTo: missionButton.bottomAnchor, constant: 15).isActive = true
        heightButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8).isActive = true
        heightButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33).isActive = true
        heightButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true
        
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.centerXAnchor.constraint(equalTo: heightButton.centerXAnchor).isActive = true
        heightTextField.bottomAnchor.constraint(equalTo: heightButton.bottomAnchor, constant: 0).isActive = true
        heightTextField.heightAnchor.constraint(equalTo: heightButton.heightAnchor, multiplier: 0.6).isActive = true
        heightTextField.widthAnchor.constraint(equalTo: heightButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: TIME:
        
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.topAnchor.constraint(equalTo: missionButton.bottomAnchor, constant: 15).isActive = true
        timeButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 8).isActive = true
        timeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33).isActive = true
        timeButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true

        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        timeTextField.centerXAnchor.constraint(equalTo: timeButton.centerXAnchor).isActive = true
        timeTextField.bottomAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 0).isActive = true
        timeTextField.heightAnchor.constraint(equalTo: timeButton.heightAnchor, multiplier: 0.6).isActive = true
        timeTextField.widthAnchor.constraint(equalTo: timeButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: CUTAWAY:
        
        cutawayButton.translatesAutoresizingMaskIntoConstraints = false
        cutawayButton.topAnchor.constraint(equalTo: heightButton.bottomAnchor, constant: 15).isActive = true
        cutawayButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cutawayButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        cutawayButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true

        cutawayTextField.translatesAutoresizingMaskIntoConstraints = false
        cutawayTextField.centerXAnchor.constraint(equalTo: cutawayButton.centerXAnchor).isActive = true
        cutawayTextField.bottomAnchor.constraint(equalTo: cutawayButton.bottomAnchor, constant: 0).isActive = true
        cutawayTextField.heightAnchor.constraint(equalTo: cutawayButton.heightAnchor, multiplier: 0.6).isActive = true
        cutawayTextField.widthAnchor.constraint(equalTo: cutawayButton.widthAnchor, multiplier: 1).isActive = true
        
        cutawayPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: COMMENT:
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.topAnchor.constraint(equalTo: cutawayButton.bottomAnchor, constant: 15).isActive = true
        commentButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        commentButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        commentButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1.6).isActive = true
        
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        commentTextField.bottomAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 0).isActive = true
        commentTextField.heightAnchor.constraint(equalTo: commentButton.heightAnchor, multiplier: 0.6).isActive = true
        commentTextField.widthAnchor.constraint(equalTo: commentButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: SAVE BUTTON:

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = .colorBackground
        selectionStyle = .none
        
        // MARK: DATE:

        dateButton.backgroundColor = .colorCell
        dateButton.setTitle("\(NSLocalizedString("Date", comment: ""))*", for: .normal)
        dateButton.setTitleColor(.colorLightGray, for: .normal)
        dateButton.contentVerticalAlignment = textAligmentTop
        dateButton.titleLabel?.font = fontMediumStandard12
        dateButton.layer.cornerRadius = cornerRadius15
        dateTextField.placeholder = NSLocalizedString("Date placeholder", comment: "")
        dateTextField.backgroundColor = .colorTabBar
        dateTextField.inputView = datePickerView
        dateTextField.font = fontMediumStandard18
        dateTextField.textColor = .colorWhite
        dateTextField.layer.cornerRadius = cornerRadius15
        dateTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        dateTextField.textAlignment = textAligmentCenter
        dateTextField.tintColor = .colorWhite
        dateTextField.layer.masksToBounds = true
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.maximumDate = Date()
        datePickerView.backgroundColor = .colorTabBar
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        // MARK: LOCATION:

        locationButton.backgroundColor = .colorCell
        locationButton.setTitle("\(NSLocalizedString("Location", comment: ""))*", for: .normal)
        locationButton.setTitleColor(.colorLightGray, for: .normal)
        locationButton.contentVerticalAlignment = textAligmentTop
        locationButton.titleLabel?.font = fontMediumStandard12
        locationButton.layer.cornerRadius = cornerRadius15
        locationTextField.placeholder = NSLocalizedString("Location placeholder", comment: "")
        locationTextField.backgroundColor = .colorTabBar
        locationTextField.inputView = locationPickerView
        locationTextField.font = fontMediumStandard18
        locationTextField.textColor = .colorWhite
        locationTextField.layer.cornerRadius = cornerRadius15
        locationTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        locationTextField.textAlignment = textAligmentCenter
        locationTextField.tintColor = .colorWhite
        locationTextField.layer.masksToBounds = true
        locationPickerView.backgroundColor = .colorTabBar
        
        // MARK: AIRCRAFT:

        aircraftButton.backgroundColor = .colorCell
        aircraftButton.setTitle("\(NSLocalizedString("Aircraft", comment: ""))*", for: .normal)
        aircraftButton.setTitleColor(.colorLightGray, for: .normal)
        aircraftButton.contentVerticalAlignment = textAligmentTop
        aircraftButton.titleLabel?.font = fontMediumStandard12
        aircraftButton.layer.cornerRadius = cornerRadius15
        aircraftTextField.placeholder = NSLocalizedString("Aircraft placeholder", comment: "")
        aircraftTextField.backgroundColor = .colorTabBar
        aircraftTextField.inputView = aircraftPickerView
        aircraftTextField.font = fontMediumStandard18
        aircraftTextField.textColor = .colorWhite
        aircraftTextField.layer.cornerRadius = cornerRadius15
        aircraftTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aircraftTextField.textAlignment = textAligmentCenter
        aircraftTextField.tintColor = .colorWhite
        aircraftTextField.layer.masksToBounds = true
        aircraftPickerView.backgroundColor = .colorTabBar
        
        // MARK: CANOPY:

        canopyButton.backgroundColor = .colorCell
        canopyButton.setTitle("\(NSLocalizedString("Canopy", comment: ""))*", for: .normal)
        canopyButton.setTitleColor(.colorLightGray, for: .normal)
        canopyButton.contentVerticalAlignment = textAligmentTop
        canopyButton.titleLabel?.font = fontMediumStandard12
        canopyButton.layer.cornerRadius = cornerRadius15
        canopyTextField.placeholder = NSLocalizedString("Canopy placeholder", comment: "")
        canopyTextField.backgroundColor = .colorTabBar
        canopyTextField.inputView = canopyPickerView
        canopyTextField.font = fontMediumStandard18
        canopyTextField.textColor = .colorWhite
        canopyTextField.layer.cornerRadius = cornerRadius15
        canopyTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        canopyTextField.textAlignment = textAligmentCenter
        canopyTextField.tintColor = .colorWhite
        canopyTextField.layer.masksToBounds = true
        canopyPickerView.backgroundColor = .colorTabBar
        
        // MARK: MISSION:

        missionButton.backgroundColor = .colorCell
        missionButton.setTitle("\(NSLocalizedString("Mission", comment: ""))*", for: .normal)
        missionButton.setTitleColor(.colorLightGray, for: .normal)
        missionButton.contentVerticalAlignment = textAligmentTop
        missionButton.titleLabel?.font = fontMediumStandard12
        missionButton.layer.cornerRadius = cornerRadius15
        missionTextField.placeholder = NSLocalizedString("Mission placeholder", comment: "")
        missionTextField.backgroundColor = .colorTabBar
        missionTextField.inputView = missionPickerView
        missionTextField.font = fontMediumStandard18
        missionTextField.textColor = .colorWhite
        missionTextField.layer.cornerRadius = cornerRadius15
        missionTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        missionTextField.textAlignment = textAligmentCenter
        missionTextField.tintColor = .colorWhite
        missionTextField.layer.masksToBounds = true
        missionPickerView.backgroundColor = .colorTabBar
        
        // MARK: HEIGHT:

        heightButton.backgroundColor = .colorCell
        heightButton.setTitle("\(NSLocalizedString("Height", comment: ""))*", for: .normal)
        heightButton.setTitleColor(.colorLightGray, for: .normal)
        heightButton.contentVerticalAlignment = textAligmentTop
        heightButton.titleLabel?.font = fontMediumStandard12
        heightButton.layer.cornerRadius = cornerRadius15
        heightTextField.placeholder = NSLocalizedString("Height placeholder", comment: "")
        heightTextField.backgroundColor = .colorTabBar
        heightTextField.font = fontMediumStandard18
        heightTextField.textColor = .colorWhite
        heightTextField.layer.cornerRadius = cornerRadius15
        heightTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        heightTextField.textAlignment = textAligmentCenter
        heightTextField.tintColor = .colorWhite
        heightTextField.layer.masksToBounds = true
        heightTextField.keyboardType = .numberPad
        heightTextField.returnKeyType = .done
        
        // MARK: TIME:

        timeButton.backgroundColor = .colorCell
        timeButton.setTitle("\(NSLocalizedString("Time", comment: ""))*", for: .normal)
        timeButton.setTitleColor(.colorLightGray, for: .normal)
        timeButton.contentVerticalAlignment = textAligmentTop
        timeButton.titleLabel?.font = fontMediumStandard12
        timeButton.layer.cornerRadius = cornerRadius15
        timeTextField.placeholder = NSLocalizedString("Time placeholder", comment: "")
        timeTextField.backgroundColor = .colorTabBar
        timeTextField.font = fontMediumStandard18
        timeTextField.textColor = .colorWhite
        timeTextField.layer.cornerRadius = cornerRadius15
        timeTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        timeTextField.textAlignment = textAligmentCenter
        timeTextField.tintColor = .colorWhite
        timeTextField.layer.masksToBounds = true
        timeTextField.keyboardType = .numberPad
        timeTextField.returnKeyType = .done
        
        // MARK: CUTAWAY:

        cutawayButton.backgroundColor = .colorCell
        cutawayButton.setTitle("\(NSLocalizedString("Cutaway", comment: ""))*", for: .normal)
        cutawayButton.setTitleColor(.colorLightGray, for: .normal)
        cutawayButton.contentVerticalAlignment = textAligmentTop
        cutawayButton.titleLabel?.font = fontMediumStandard12
        cutawayButton.layer.cornerRadius = cornerRadius15
        cutawayTextField.placeholder = NSLocalizedString("Cutaway placeholder", comment: "")
        cutawayTextField.backgroundColor = .colorTabBar
        cutawayTextField.inputView = cutawayPickerView
        cutawayTextField.font = fontMediumStandard18
        cutawayTextField.textColor = .colorWhite
        cutawayTextField.layer.cornerRadius = cornerRadius15
        cutawayTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cutawayTextField.textAlignment = textAligmentCenter
        cutawayTextField.tintColor = .colorWhite
        cutawayTextField.layer.masksToBounds = true
        cutawayPickerView.backgroundColor = .colorTabBar
        
        // MARK: COMMENT:

        commentButton.backgroundColor = .colorCell
        commentButton.setTitle("\(NSLocalizedString("Comment", comment: ""))", for: .normal)
        commentButton.setTitleColor(.colorLightGray, for: .normal)
        commentButton.contentVerticalAlignment = textAligmentTop
        commentButton.titleLabel?.font = fontMediumStandard12
        commentButton.layer.cornerRadius = cornerRadius15
        commentTextField.placeholder = NSLocalizedString("Comment placeholder", comment: "")
        commentTextField.backgroundColor = .colorTabBar
        commentTextField.font = fontBoldStandard16
        commentTextField.textColor = .colorWhite
        commentTextField.textAlignment = textAligmentCenter
        commentTextField.layer.cornerRadius = cornerRadius15
        commentTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        commentTextField.tintColor = .colorWhite
        commentTextField.layer.masksToBounds = true
        commentTextField.keyboardType = .default
        
        // MARK: SAVE BUTTON:

        saveButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        saveButton.backgroundColor = .colorCell
        saveButton.layer.cornerRadius = cornerRadius15
        saveButton.setTitleColor(.colorWhite, for: .normal)
        saveButton.titleLabel?.font = fontMediumStandard14
        saveButton.addTarget(self, action: #selector(actionButtonSaveTap), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE MODEL:

    func configure(_ jump: JumpClassRealm) {
        dateTextField.text = jump.date
        locationTextField.text = jump.location
        aircraftTextField.text = jump.aircraft
        canopyTextField.text = jump.canopy
        missionTextField.text = jump.mission?.localizedValue ?? ""
        heightTextField.text = jump.height
        timeTextField.text = jump.time
        cutawayTextField.text = jump.cutaway?.localizedValue ?? ""
        commentTextField.text = jump.comment
    }

    
    // MARK: ACTION BUTTON SAVE:

    @objc func actionButtonSaveTap() {
        guard dateTextField.text != "" else {
            showError(textField: dateTextField)
            return
        }
        guard locationTextField.text != "" else {
            showError(textField: locationTextField)
            return
        }
        guard aircraftTextField.text != "" else {
            showError(textField: aircraftTextField)
            return
        }
        guard canopyTextField.text != "" else {
            showError(textField: canopyTextField)
            return
        }
        guard missionTextField.text != "" else {
            showError(textField: missionTextField)
            return
        }
        guard heightTextField.text != "" else {
            showError(textField: heightTextField)
            return
        }
        guard timeTextField.text != "" else {
            showError(textField: timeTextField)
            return
        }
        guard cutawayTextField.text != "" else {
            showError(textField: cutawayTextField)
            return
        }
        saveNewJump()
        actionButtonSaveGreenColor()
        playSoundSucces()
        resignFirstResponders()
        clearTextViews()
        alertKitSuccess()
    }
    
    // MARK: SAVE AND ADD NEW JUMP IN ARRAYJUMP:

    private func saveNewJump() {
        let newJump = JumpClassRealm()
        
        newJump.date = dateTextField.text ?? ""
        newJump.location = locationTextField.text ?? ""
        newJump.aircraft = aircraftTextField.text ?? ""
        newJump.canopy = canopyTextField.text ?? ""

        if let missionString = missionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let mission = Mission(rawValue: missionString) ?? Mission.allCases.first(where: { $0.localizedValue == missionString }) 
        {
            newJump.mission = mission
        } else {
            print("Failed to convert missionString to Mission: \(missionTextField.text ?? "")")
            return
        }

        newJump.height = heightTextField.text ?? ""
        newJump.time = timeTextField.text ?? ""
        
        if let cutawayString = cutawayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let cutaway = Cutaway(rawValue: cutawayString) ?? Cutaway.allCases.first(where: { $0.localizedValue == cutawayString }) 
        {
            newJump.cutaway = cutaway
        } else {
            print("Failed to convert missionString to Mission: \(cutawayTextField.text ?? "")")
            return
        }
        
        newJump.comment = commentTextField.text ?? ""
        
        delegate?.saveJump(newJump)
        resetSelectPickerView()
    }
    
    // MARK: SHOR ERROR FOR EMPTY FIELD:
    
    private func showError(textField: UITextField) {
        textField.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            textField.backgroundColor = .colorTabBar
        }
        resignFirstResponders()
        actionButtonSaveRedColor()
        alertKitError()
    }
    
    // MARK: CLEAR ALL TEXT FIELDS:
    
    private func clearTextViews() {
        dateTextField.text = ""
        canopyTextField.text = ""
        missionTextField.text = ""
        heightTextField.text = ""
        timeTextField.text = ""
        locationTextField.text = ""
        aircraftTextField.text = ""
        cutawayTextField.text = ""
        commentTextField.text = ""
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        dateTextField.resignFirstResponder()
        canopyTextField.resignFirstResponder()
        missionTextField.resignFirstResponder()
        heightTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        aircraftTextField.resignFirstResponder()
        cutawayTextField.resignFirstResponder()
        commentTextField.resignFirstResponder()
    }
    
    private func resetSelectPickerView() {
        locationPickerView.selectRow(0, inComponent: 0, animated: true)
        aircraftPickerView.selectRow(0, inComponent: 0, animated: true)
        canopyPickerView.selectRow(0, inComponent: 0, animated: true)
        missionPickerView.selectRow(0, inComponent: 0, animated: true)
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
    
    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    // MARK: DATE PICKER:

    @objc private func datePickerValueChanged() {
        getDateFromPicker()
    }
    
    // MARK: DATE FORMATTER:

    func getDateFromPicker() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
    }
    
    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc private func tapGestureDone() {
        contentView.endEditing(true)
    }
    
    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / cell new jump", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / cell new jump", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
}

// MARK: - EXTENSIONS FOR PICKER VIEW DELEGATE:

extension EditJumpCell: UIPickerViewDelegate {
    // MARK: ФУНКЦИЯ КОТОРАЯ ПРИСВАИВАЕТ ЗНАЧЕНИЕ ИЗ ПИКЕР ВЬЮ В ТЕКСТ ФИЛД:

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if arrayCanopiesRealm.isEmpty || missionPickerViewValues.isEmpty || arrayLocationsRealm.isEmpty || arrayAircraftsRealm.isEmpty || cutawayPickerViewValues.isEmpty {
                return
            }
        if pickerView == canopyPickerView {
            canopyTextField.text = arrayCanopiesRealm[row].canopy
        } else if pickerView == missionPickerView {
            let selectedMission = missionPickerViewValues.sorted()[row]
            missionTextField.text = selectedMission.localizedValue
        } else if pickerView == locationPickerView {
            locationTextField.text = arrayLocationsRealm[row].location
        } else if pickerView == aircraftPickerView {
            aircraftTextField.text = arrayAircraftsRealm[row].aircraft
        } else if pickerView == cutawayPickerView {
            let selectedCutaway = cutawayPickerViewValues.sorted()[row]
            cutawayTextField.text = selectedCutaway.localizedValue
        }
    }
}

// MARK: - EXTENSIONS FOR PICKER VIEW DATA SOURSE:

extension EditJumpCell: UIPickerViewDataSource {
    // MARK: КОЛИЧЕСТВО КОЛОНОК В PICKER VIEW:

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // MARK: КОЛИЧЕСТВО ТЕКСТОВЫХ ВАРИАНТОВ ДЛЯ ПИКЕРА ИЗ МАССИВА:

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == canopyPickerView {
            return arrayCanopiesRealm.count
        } else if pickerView == missionPickerView {
            return missionPickerViewValues.count
        } else if pickerView == locationPickerView {
            return arrayLocationsRealm.count
        } else if pickerView == aircraftPickerView {
            return arrayAircraftsRealm.count
        } else if pickerView == cutawayPickerView {
            return cutawayPickerViewValues.count
        }
        return 0
    }
    
    // MARK: ВАРИАНТЫ ДЛЯ ЗАПОЛНЕНИЯ ПИКЕРА ТЕКСТОМ ИЗ ЗНАЧЕНИЙ В МАССИВЕ:

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var title = ""
        if pickerView == canopyPickerView {
            title = arrayCanopiesRealm[row].canopy
        } else if pickerView == missionPickerView {
            title = missionPickerViewValues.sorted()[row].localizedValue
        } else if pickerView == locationPickerView {
            title = arrayLocationsRealm[row].location
        } else if pickerView == aircraftPickerView {
            title = arrayAircraftsRealm[row].aircraft
        } else if pickerView == cutawayPickerView {
            title = cutawayPickerViewValues.sorted()[row].localizedValue
        }
        let attributedString = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.colorWhite])
        return attributedString
    }
}

// MARK: - EXTENSION FOR TEXT FIELD:

extension EditJumpCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "1234567890")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
