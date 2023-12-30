import UIKit

// MARK: - PROTOCOL:

protocol AccountCellDelegate {
    func tapEditLocationsButton()
    func tapEditAircraftsButton()
    func tapEditCanopiesButton()
    func tapEditAccountButton()
    func tapBackupButton()
    func tapCalculatorButton()
    func tapInfoButton()
    func tapPremiumButton()
}

final class AccountCell: UITableViewCell {
    
    // MARK: - PRIVATE PROPERTIES:
    
    private let editAccountButton = UIButton()
    private let editLocationsButton = UIButton()
    private let editAircraftsButton = UIButton()
    private let editCanopiesButton = UIButton()
    private let backupButton = UIButton()
    private let calculatorButton = UIButton()
    private let weatherButton = UIButton()
    private let infoButton = UIButton()
    private let premiumButton = UIButton()
    private let starImage = UIImageView()
    private let restoreButton = UIButton()
    var delegate: AccountCellDelegate?

    // MARK: - LIFECYCLE:
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - ADD SUBVIEWS:
    private func addSubviews() {
        contentView.addSubviews(editAccountButton, editLocationsButton, editAircraftsButton, editCanopiesButton, backupButton, calculatorButton, weatherButton, infoButton, premiumButton, restoreButton)
        premiumButton.addSubview(starImage)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: EDIT ACCOUNT:

        editAccountButton.translatesAutoresizingMaskIntoConstraints = false
        editAccountButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45).isActive = true
        editAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        editAccountButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        editAccountButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: EDIT LOCATIONS:

        editLocationsButton.translatesAutoresizingMaskIntoConstraints = false
        editLocationsButton.topAnchor.constraint(equalTo: editAccountButton.bottomAnchor, constant: 15).isActive = true
        editLocationsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        editLocationsButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        editLocationsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: EDIT AIRCRAFTS:

        editAircraftsButton.translatesAutoresizingMaskIntoConstraints = false
        editAircraftsButton.topAnchor.constraint(equalTo: editLocationsButton.bottomAnchor, constant: 15).isActive = true
        editAircraftsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        editAircraftsButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        editAircraftsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: EDIT CANOPIES:

        editCanopiesButton.translatesAutoresizingMaskIntoConstraints = false
        editCanopiesButton.topAnchor.constraint(equalTo: editAircraftsButton.bottomAnchor, constant: 15).isActive = true
        editCanopiesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        editCanopiesButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        editCanopiesButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: BACKUP BUTTON:

        backupButton.translatesAutoresizingMaskIntoConstraints = false
        backupButton.topAnchor.constraint(equalTo: editCanopiesButton.bottomAnchor, constant: 45).isActive = true
        backupButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backupButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        backupButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: CALCULATOR:

        calculatorButton.translatesAutoresizingMaskIntoConstraints = false
        calculatorButton.topAnchor.constraint(equalTo: backupButton.bottomAnchor, constant: 15).isActive = true
        calculatorButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        calculatorButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        calculatorButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: ABOUT:

        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.topAnchor.constraint(equalTo: calculatorButton.bottomAnchor, constant: 45).isActive = true
        infoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        infoButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: PREMIUM BUTTON:

        premiumButton.translatesAutoresizingMaskIntoConstraints = false
        premiumButton.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 15).isActive = true
        premiumButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        premiumButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        premiumButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        premiumButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        // MARK: STAR:

        starImage.translatesAutoresizingMaskIntoConstraints = false
        starImage.centerXAnchor.constraint(equalTo: premiumButton.trailingAnchor).isActive = true
        starImage.centerYAnchor.constraint(equalTo: premiumButton.topAnchor, constant: 5).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        
        // MARK: CONTENT VIEW:
        contentView.backgroundColor = colorBackground
        selectionStyle = .none
        
        // MARK: EDIT ACCOUNT:

        editAccountButton.setTitle("Редактировать аккаунт", for: .normal)
        editAccountButton.layer.cornerRadius = cornerRadius10
        editAccountButton.backgroundColor = colorCell
        editAccountButton.titleLabel?.font = fontMediumStandart14
        editAccountButton.setTitleColor(.white, for: .normal)
        editAccountButton.addTarget(self, action: #selector(tapOnEditAccountButton), for: .touchUpInside)
        
        // MARK: EDIT LOCATIONS:

        editLocationsButton.setTitle(NSLocalizedString("Edit locations", comment: ""), for: .normal)
        editLocationsButton.layer.cornerRadius = cornerRadius10
        editLocationsButton.backgroundColor = colorCell
        editLocationsButton.titleLabel?.font = fontMediumStandart14
        editLocationsButton.setTitleColor(.white, for: .normal)
        editLocationsButton.addTarget(self, action: #selector(tapOnEditLocationsButton), for: .touchUpInside)

        // MARK: EDIT AIRCRAFTS:

        editAircraftsButton.setTitle(NSLocalizedString("Edit aircrafts", comment: ""), for: .normal)
        editAircraftsButton.layer.cornerRadius = cornerRadius10
        editAircraftsButton.backgroundColor = colorCell
        editAircraftsButton.titleLabel?.font = fontMediumStandart14
        editAircraftsButton.setTitleColor(.white, for: .normal)
        editAircraftsButton.addTarget(self, action: #selector(tapOnEditAircraftsButton), for: .touchUpInside)

        // MARK: EDIT CANOPIES:

        editCanopiesButton.setTitle(NSLocalizedString("Edit canopies", comment: ""), for: .normal)
        editCanopiesButton.layer.cornerRadius = cornerRadius10
        editCanopiesButton.backgroundColor = colorCell
        editCanopiesButton.titleLabel?.font = fontMediumStandart14
        editCanopiesButton.setTitleColor(.white, for: .normal)
        editCanopiesButton.addTarget(self, action: #selector(tapOnEditCanopiesButton), for: .touchUpInside)

        // MARK: BACKUP BUTTON:

        backupButton.setTitle(NSLocalizedString("Backup copy", comment: ""), for: .normal)
        backupButton.layer.cornerRadius = cornerRadius10
        backupButton.backgroundColor = colorCell
        backupButton.titleLabel?.font = fontMediumStandart14
        backupButton.setTitleColor(.white, for: .normal)
        backupButton.addTarget(self, action: #selector(tapOnBackupButton), for: .touchUpInside)

        // MARK: CALCULATOR:

        calculatorButton.setTitle(NSLocalizedString("Calculator loading", comment: ""), for: .normal)
        calculatorButton.layer.cornerRadius = cornerRadius10
        calculatorButton.backgroundColor = colorCell
        calculatorButton.titleLabel?.font = fontMediumStandart14
        calculatorButton.setTitleColor(.white, for: .normal)
        calculatorButton.addTarget(self, action: #selector(tapOnCalculatorButton), for: .touchUpInside)

        // MARK: ABOUT BUTTON:

        infoButton.setTitle(NSLocalizedString("Information", comment: ""), for: .normal)
        infoButton.layer.cornerRadius = cornerRadius10
        infoButton.backgroundColor = colorCell
        infoButton.titleLabel?.font = fontMediumStandart14
        infoButton.setTitleColor(.white, for: .normal)
        infoButton.addTarget(self, action: #selector(tapOnInfoButton), for: .touchUpInside)

        // MARK: PREMIUM BUTTON:

        premiumButton.setTitle(NSLocalizedString("Premium version", comment: ""), for: .normal)
        premiumButton.layer.cornerRadius = cornerRadius10
        premiumButton.backgroundColor = colorCell
        premiumButton.titleLabel?.font = fontMediumStandart14
        premiumButton.setTitleColor(.white, for: .normal)
        premiumButton.addTarget(self, action: #selector(tapOnPremiumButton), for: .touchUpInside)

        // MARK: STAR:

        starImage.image = UIImage(systemName: "star.fill")
        starImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        starImage.tintColor = .systemYellow
    }
    
    // MARK: - HELPERS:
    
    // MARK: FUNC FOR EDIT ACCOUNT:

    @objc func tapOnEditAccountButton() {
        delegate?.tapEditAccountButton()
    }
    
    // MARK: FUNC FOR EDIT LOCATIONS:

    @objc func tapOnEditLocationsButton() {
        delegate?.tapEditLocationsButton()
    }

    // MARK: FUNC FOR EDIT AIRCRAFTS:

    @objc func tapOnEditAircraftsButton() {
        delegate?.tapEditAircraftsButton()
    }

    // MARK: FUNC FOR EDIT CANOPIES:

    @objc func tapOnEditCanopiesButton() {
        delegate?.tapEditCanopiesButton()
    }

    // MARK: FUNC FOR BACKUP:

    @objc func tapOnBackupButton() {
        delegate?.tapBackupButton()
    }

    // MARK: FUNC FOR CALCULATOR:

    @objc func tapOnCalculatorButton() {
        delegate?.tapCalculatorButton()
    }

    // MARK: FUNC FOR INFO BUTTON:

    @objc func tapOnInfoButton() {
        delegate?.tapInfoButton()
    }

    // MARK: FUNC FOR PREMIUM BUTTON:

    @objc func tapOnPremiumButton() {
        delegate?.tapPremiumButton()
    }
}
