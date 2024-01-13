import AudioToolbox
import AVFoundation
import Lottie
import UIKit

// MARK: - PROTOCOL:

protocol EditJumpCellDelegate {
    func saveJump(_ jump: JumpStructure)
}

class EditJumpCell: UITableViewCell {
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
    private let missionPickerViewValues = [NSLocalizedString("Accuracy", comment: ""),
                                           NSLocalizedString("Acrobatics", comment: ""),
                                           NSLocalizedString("AFF", comment: ""),
                                           NSLocalizedString("Base", comment: ""),
                                           NSLocalizedString("Base/Wingsuit", comment: ""),
                                           NSLocalizedString("Canopy formation", comment: ""),
                                           NSLocalizedString("Freefly", comment: ""),
                                           NSLocalizedString("Freestyle", comment: ""),
                                           NSLocalizedString("Fun", comment: ""),
                                           NSLocalizedString("Group", comment: ""),
                                           NSLocalizedString("Instructor", comment: ""),
                                           NSLocalizedString("Military", comment: ""),
                                           NSLocalizedString("Para-ski", comment: ""),
                                           NSLocalizedString("Proximity", comment: ""),
                                           NSLocalizedString("Skysurfing", comment: ""),
                                           NSLocalizedString("Static-line", comment: ""),
                                           NSLocalizedString("Piloting", comment: ""),
                                           NSLocalizedString("Tandem", comment: ""),
                                           NSLocalizedString("Vertical", comment: ""),
                                           NSLocalizedString("Video", comment: ""),
                                           NSLocalizedString("Wingsuit", comment: ""),
                                           NSLocalizedString("Formation", comment: "")]
    
    private let heightButton = UIButton()
    private let heightTextField = UITextField()
    
    private let timeButton = UIButton()
    private let timeTextField = UITextField()
    
    private let cutawayButton = UIButton()
    private let cutawayTextField = UITextField()
    private let cutawayPickerView = UIPickerView()
    private let cutawayPickerViewValues = [NSLocalizedString("Yes", comment: ""), NSLocalizedString("No", comment: "")]
    
    private let commentButton = UIButton()
    private let commentTextField = UITextField()
    
    private let saveButton = UIButton()
    
    private let vibrationOn = Vibration()
    private var player = AVAudioPlayer()
    private let saveLottie = LottieAnimationView(name: "Save")
    
    let dateFormatter = DateFormatter()
    var delegate: EditJumpCellDelegate?
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.addSubviews(dateButton, dateTextField, locationButton, locationTextField, aircraftButton, aircraftTextField, canopyButton, canopyTextField, missionButton, missionTextField, heightButton, heightTextField, timeButton, timeTextField, cutawayButton, cutawayTextField, commentButton, commentTextField, saveButton, saveLottie)
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
        
        // MARK: SAVE LOTTIE:

        saveLottie.translatesAutoresizingMaskIntoConstraints = false
        saveLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        saveLottie.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        saveLottie.heightAnchor.constraint(equalToConstant: 200).isActive = true
        saveLottie.widthAnchor.constraint(equalToConstant: 200).isActive = true
        saveLottie.isHidden = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = colorBackground
        selectionStyle = .none
        
        // MARK: DATE:
        
        dateButton.backgroundColor = colorCell
        dateButton.setTitle("\(NSLocalizedString("Date", comment: ""))*", for: .normal)
        dateButton.setTitleColor(colorLightGray, for: .normal)
        dateButton.contentVerticalAlignment = textAligmentTop
        dateButton.titleLabel?.font = fontMediumStandart12
        dateButton.layer.cornerRadius = cornerRadius10
        dateTextField.placeholder = NSLocalizedString("Date placeholder", comment: "")
        dateTextField.backgroundColor = colorTabBar
        dateTextField.inputView = datePickerView
        dateTextField.font = fontMediumStandart18
        dateTextField.textColor = colorWhite
        dateTextField.layer.cornerRadius = cornerRadius10
        dateTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        dateTextField.textAlignment = textAligmentCenter
        dateTextField.tintColor = colorWhite
        dateTextField.layer.masksToBounds = true
        datePickerView.setValue(colorWhite, forKeyPath: "textColor")
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.maximumDate = Date()
        datePickerView.backgroundColor = colorTabBar
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        // MARK: LOCATION:

        locationButton.backgroundColor = colorCell
        locationButton.setTitle("\(NSLocalizedString("Location", comment: ""))*", for: .normal)
        locationButton.setTitleColor(colorLightGray, for: .normal)
        locationButton.contentVerticalAlignment = textAligmentTop
        locationButton.titleLabel?.font = fontMediumStandart12
        locationButton.layer.cornerRadius = cornerRadius10
        locationTextField.placeholder = NSLocalizedString("Location placeholder", comment: "")
        locationTextField.backgroundColor = colorTabBar
        locationTextField.inputView = locationPickerView
        locationTextField.font = fontMediumStandart18
        locationTextField.textColor = colorWhite
        locationTextField.layer.cornerRadius = cornerRadius10
        locationTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        locationTextField.textAlignment = textAligmentCenter
        locationTextField.tintColor = colorWhite
        locationTextField.layer.masksToBounds = true
        locationPickerView.backgroundColor = colorTabBar
        
        // MARK: AIRCRAFT:

        aircraftButton.backgroundColor = colorCell
        aircraftButton.setTitle("\(NSLocalizedString("Aircraft", comment: ""))*", for: .normal)
        aircraftButton.setTitleColor(colorLightGray, for: .normal)
        aircraftButton.contentVerticalAlignment = textAligmentTop
        aircraftButton.titleLabel?.font = fontMediumStandart12
        aircraftButton.layer.cornerRadius = cornerRadius10
        aircraftTextField.placeholder = NSLocalizedString("Aircraft placeholder", comment: "")
        aircraftTextField.backgroundColor = colorTabBar
        aircraftTextField.inputView = aircraftPickerView
        aircraftTextField.font = fontMediumStandart18
        aircraftTextField.textColor = colorWhite
        aircraftTextField.layer.cornerRadius = cornerRadius10
        aircraftTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aircraftTextField.textAlignment = textAligmentCenter
        aircraftTextField.tintColor = colorWhite
        aircraftTextField.layer.masksToBounds = true
        aircraftPickerView.backgroundColor = colorTabBar
        
        // MARK: CANOPY:

        canopyButton.backgroundColor = colorCell
        canopyButton.setTitle("\(NSLocalizedString("Canopy", comment: ""))*", for: .normal)
        canopyButton.setTitleColor(colorLightGray, for: .normal)
        canopyButton.contentVerticalAlignment = textAligmentTop
        canopyButton.titleLabel?.font = fontMediumStandart12
        canopyButton.layer.cornerRadius = cornerRadius10
        canopyTextField.placeholder = NSLocalizedString("Canopy placeholder", comment: "")
        canopyTextField.backgroundColor = colorTabBar
        canopyTextField.inputView = canopyPickerView
        canopyTextField.font = fontMediumStandart18
        canopyTextField.textColor = colorWhite
        canopyTextField.layer.cornerRadius = cornerRadius10
        canopyTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        canopyTextField.textAlignment = textAligmentCenter
        canopyTextField.tintColor = colorWhite
        canopyTextField.layer.masksToBounds = true
        canopyPickerView.backgroundColor = colorTabBar
        
        // MARK: MISSION:

        missionButton.backgroundColor = colorCell
        missionButton.setTitle("\(NSLocalizedString("Mission", comment: ""))*", for: .normal)
        missionButton.setTitleColor(colorLightGray, for: .normal)
        missionButton.contentVerticalAlignment = textAligmentTop
        missionButton.titleLabel?.font = fontMediumStandart12
        missionButton.layer.cornerRadius = cornerRadius10
        missionTextField.placeholder = NSLocalizedString("Mission placeholder", comment: "")
        missionTextField.backgroundColor = colorTabBar
        missionTextField.inputView = missionPickerView
        missionTextField.font = fontMediumStandart18
        missionTextField.textColor = colorWhite
        missionTextField.layer.cornerRadius = cornerRadius10
        missionTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        missionTextField.textAlignment = textAligmentCenter
        missionTextField.tintColor = colorWhite
        missionTextField.layer.masksToBounds = true
        missionPickerView.backgroundColor = colorTabBar
        
        // MARK: HEIGHT:

        heightButton.backgroundColor = colorCell
        heightButton.setTitle("\(NSLocalizedString("Height", comment: ""))*", for: .normal)
        heightButton.setTitleColor(colorLightGray, for: .normal)
        heightButton.contentVerticalAlignment = textAligmentTop
        heightButton.titleLabel?.font = fontMediumStandart12
        heightButton.layer.cornerRadius = cornerRadius10
        heightTextField.placeholder = NSLocalizedString("Height placeholder", comment: "")
        heightTextField.backgroundColor = colorTabBar
        heightTextField.font = fontMediumStandart18
        heightTextField.textColor = colorWhite
        heightTextField.layer.cornerRadius = cornerRadius10
        heightTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        heightTextField.textAlignment = textAligmentCenter
        heightTextField.tintColor = colorWhite
        heightTextField.layer.masksToBounds = true
        heightTextField.setValue(UIColor.white, forKeyPath: "textColor")
        heightTextField.keyboardType = .numberPad
        heightTextField.returnKeyType = .done
        
        // MARK: TIME:

        timeButton.backgroundColor = colorCell
        timeButton.setTitle("\(NSLocalizedString("Time", comment: ""))*", for: .normal)
        timeButton.setTitleColor(colorLightGray, for: .normal)
        timeButton.contentVerticalAlignment = textAligmentTop
        timeButton.titleLabel?.font = fontMediumStandart12
        timeButton.layer.cornerRadius = cornerRadius10
        timeTextField.placeholder = NSLocalizedString("Time placeholder", comment: "")
        timeTextField.backgroundColor = colorTabBar
        timeTextField.font = fontMediumStandart18
        timeTextField.textColor = colorWhite
        timeTextField.layer.cornerRadius = cornerRadius10
        timeTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        timeTextField.textAlignment = textAligmentCenter
        timeTextField.tintColor = colorWhite
        timeTextField.layer.masksToBounds = true
        timeTextField.setValue(UIColor.white, forKeyPath: "textColor")
        timeTextField.keyboardType = .numberPad
        timeTextField.returnKeyType = .done
        
        // MARK: CUTAWAY:

        cutawayButton.backgroundColor = colorCell
        cutawayButton.setTitle("\(NSLocalizedString("Cutaway", comment: ""))", for: .normal)
        cutawayButton.setTitleColor(colorLightGray, for: .normal)
        cutawayButton.contentVerticalAlignment = textAligmentTop
        cutawayButton.titleLabel?.font = fontMediumStandart12
        cutawayButton.layer.cornerRadius = cornerRadius10
        cutawayTextField.placeholder = NSLocalizedString("Cutaway placeholder", comment: "")
        cutawayTextField.backgroundColor = colorTabBar
        cutawayTextField.inputView = cutawayPickerView
        cutawayTextField.font = fontMediumStandart18
        cutawayTextField.textColor = colorWhite
        cutawayTextField.layer.cornerRadius = cornerRadius10
        cutawayTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cutawayTextField.textAlignment = textAligmentCenter
        cutawayTextField.tintColor = colorWhite
        cutawayTextField.layer.masksToBounds = true
        cutawayPickerView.backgroundColor = colorTabBar
        
        // MARK: COMMENT:

        commentButton.backgroundColor = colorCell
        commentButton.setTitle("\(NSLocalizedString("Comment", comment: ""))", for: .normal)
        commentButton.setTitleColor(colorLightGray, for: .normal)
        commentButton.contentVerticalAlignment = textAligmentTop
        commentButton.titleLabel?.font = fontMediumStandart12
        commentButton.layer.cornerRadius = cornerRadius10
        commentTextField.placeholder = NSLocalizedString("Comment placeholder", comment: "")
        commentTextField.backgroundColor = colorTabBar
        commentTextField.font = fontMediumStandart16
        commentTextField.textColor = colorWhite
        commentTextField.textAlignment = textAligmentCenter
        commentTextField.layer.cornerRadius = cornerRadius10
        commentTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        commentTextField.tintColor = colorWhite
        commentTextField.layer.masksToBounds = true
        commentTextField.keyboardType = .default
        
        // MARK: SAVE BUTTON:

        saveButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        saveButton.backgroundColor = colorCell
        saveButton.layer.cornerRadius = cornerRadius10
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = fontMediumStandart14
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

    func configure(_ jump: JumpStructure) {
        dateTextField.text = jump.date
        locationTextField.text = jump.location
        aircraftTextField.text = jump.aircraft
        canopyTextField.text = jump.canopy
        missionTextField.text = jump.mission
        heightTextField.text = jump.height
        timeTextField.text = jump.time
        cutawayTextField.text = jump.cutaway
        commentTextField.text = jump.comment
    }
    
    // MARK: ACTION BUTTON SAVE:

    @objc func actionButtonSaveTap() {
        guard dateTextField.text != "",
              locationTextField.text != "",
              aircraftTextField.text != "",
              canopyTextField.text != "",
              missionTextField.text != "",
              heightTextField.text != "",
              timeTextField.text != ""
        else {
            resignFirstResponders()
            actionButtonSaveRedColor()
            vibrationOn.vibrationError()
            return
        }
        saveNewJump()
        actionButtonSaveGreenColor()
        vibrationOn.vibrationSucces()
        playSoundSucces()
        resignFirstResponders()
        clearTextViews()
        saveLottie.isHidden = false
        saveLottie.play()
        perform(#selector(hideAnimation), with: nil, afterDelay: 2)
    }
    
    // MARK: SAVE AND ADD NEW JUMP IN ARRAYJUMP:

    private func saveNewJump() {
        let newJump = JumpStructure(date: dateTextField.text ?? "", location: locationTextField.text ?? "", aircraft: aircraftTextField.text ?? "", canopy: canopyTextField.text ?? "", mission: missionTextField.text ?? "", height: heightTextField.text ?? "", time: timeTextField.text ?? "", cutaway: cutawayTextField.text ?? "", comment: commentTextField.text ?? "")
        
        delegate?.saveJump(newJump)
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
    
    // MARK: HIDE SAVE ANIMATION:

    @objc private func hideAnimation() {
        saveLottie.isHidden = true
    }

    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

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
    
    // MARK: DATE PICKER:

    @objc func datePickerValueChanged() {
        getDateFromPicker()
    }
    
    // MARK: DATE FORMATTER:

    func getDateFromPicker() {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
    }
    
    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc func tapGestureDone() {
        contentView.endEditing(true)
    }
}

// MARK: - EXTENSIONS FOR PICKER VIEW DELEGATE:

extension EditJumpCell: UIPickerViewDelegate {
    // MARK: ФУНКЦИЯ КОТОРАЯ ПРИСВАИВАЕТ ЗНАЧЕНИЕ ИЗ ПИКЕР ВЬЮ В ТЕКСТ ФИЛД:

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if arrayCanopiesPickerViewValues.count == 0 {
            return
        }
        
        if missionPickerViewValues.count == 0 {
            return
        }
        
        if arrayLocationPickerViewValues.count == 0 {
            return
        }
        
        if arrayAircraftPickerViewValues.count == 0 {
            return
        }
        
        if cutawayPickerViewValues.count == 0 {
            return
        }
        
        if pickerView == canopyPickerView {
            canopyTextField.text = arrayCanopiesPickerViewValues.sorted()[row]
        } else if pickerView == missionPickerView {
            missionTextField.text = missionPickerViewValues.sorted()[row]
        } else if pickerView == locationPickerView {
            locationTextField.text = arrayLocationPickerViewValues.sorted()[row]
        } else if pickerView == aircraftPickerView {
            aircraftTextField.text = arrayAircraftPickerViewValues.sorted()[row]
        } else if pickerView == cutawayPickerView {
            cutawayTextField.text = cutawayPickerViewValues.sorted()[row]
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
            return arrayCanopiesPickerViewValues.count
        } else if pickerView == missionPickerView {
            return missionPickerViewValues.count
        } else if pickerView == locationPickerView {
            return arrayLocationPickerViewValues.count
        } else if pickerView == aircraftPickerView {
            return arrayAircraftPickerViewValues.count
        } else if pickerView == cutawayPickerView {
            return cutawayPickerViewValues.count
        }
        return 0
    }
    
    // MARK: ВАРИАНТЫ ДЛЯ ЗАПОЛНЕНИЯ ПИКЕРА ТЕКСТОМ ИЗ ЗНАЧЕНИЙ В МАССИВЕ:

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == canopyPickerView {
            return arrayCanopiesPickerViewValues.sorted()[row]
        } else if pickerView == missionPickerView {
            return missionPickerViewValues.sorted()[row]
        } else if pickerView == locationPickerView {
            return arrayLocationPickerViewValues.sorted()[row]
        } else if pickerView == aircraftPickerView {
            return arrayAircraftPickerViewValues.sorted()[row]
        } else if pickerView == cutawayPickerView {
            return cutawayPickerViewValues.sorted()[row]
        }
        return ""
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
