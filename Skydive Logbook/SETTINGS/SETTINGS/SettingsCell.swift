import RealmSwift
import UIKit
import Adapty

// MARK: - PROTOCOL:

protocol SettingsCellDelegate: AnyObject {
    func tapEditDataButton()
    func tapBackupButton()
    func tapPrintButton()
    func tapInfoButton()
    func tapPremiumButton()
    func tapNotificationsButton()
    func tapGameButton()
    func tapInstagramButton()
}

final class SettingsCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let editDataButton = UIButton(type: .system)
    private let backupButton = UIButton(type: .system)
    private let printButton = UIButton(type: .system)
    private let infoButton = UIButton(type: .system)
    private let premiumButton = UIButton(type: .system)
    private let notificationsButton = UIButton()
    private let gameButton = UIButton(type: .system)
    private let starImage = UIImageView()
    private let instagramImageView = UIImageView()
    private let instagramButton = UIButton(type: .system)
    private let infoLabel = UILabel()
    weak var delegate: SettingsCellDelegate?

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUI()
        startBouncingAnimation()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(editDataButton, backupButton, printButton, infoButton, premiumButton, notificationsButton, gameButton, instagramImageView, infoLabel, instagramButton)
        premiumButton.addSubview(starImage)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: EDIT ACCOUNT:

        editDataButton.translatesAutoresizingMaskIntoConstraints = false
        editDataButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 75).isActive = true
        editDataButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        editDataButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        editDataButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: BACKUP BUTTON:

        backupButton.translatesAutoresizingMaskIntoConstraints = false
        backupButton.topAnchor.constraint(equalTo: editDataButton.bottomAnchor, constant: 35).isActive = true
        backupButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backupButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        backupButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: PRINT BUTTON:
        
        printButton.translatesAutoresizingMaskIntoConstraints = false
        printButton.topAnchor.constraint(equalTo: backupButton.bottomAnchor, constant: 15).isActive = true
        printButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        printButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        printButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: PREMIUM BUTTON:
        
        premiumButton.translatesAutoresizingMaskIntoConstraints = false
        premiumButton.topAnchor.constraint(equalTo: printButton.bottomAnchor, constant: 35).isActive = true
        premiumButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        premiumButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        premiumButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: STAR:

        starImage.translatesAutoresizingMaskIntoConstraints = false
        starImage.centerXAnchor.constraint(equalTo: premiumButton.trailingAnchor).isActive = true
        starImage.centerYAnchor.constraint(equalTo: premiumButton.topAnchor, constant: 5).isActive = true
        
        // MARK: NOTIFICATIONS BUTTON:
        
        notificationsButton.translatesAutoresizingMaskIntoConstraints = false
        notificationsButton.topAnchor.constraint(equalTo: premiumButton.bottomAnchor, constant: 15).isActive = true
        notificationsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        notificationsButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        notificationsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: GAME BUTTON:
        
        gameButton.translatesAutoresizingMaskIntoConstraints = false
        gameButton.topAnchor.constraint(equalTo: premiumButton.bottomAnchor, constant: 15).isActive = true
        gameButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gameButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        gameButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: ABOUT:

        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.topAnchor.constraint(equalTo: premiumButton.bottomAnchor, constant: 15).isActive = true
        infoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        infoButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true
        
        // MARK: INSTAGRAM IMAGE VIEW:

        instagramImageView.translatesAutoresizingMaskIntoConstraints = false
        instagramImageView.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 20).isActive = true
        instagramImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        instagramImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        instagramImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true

        // MARK: INFO LABEL:

        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: instagramImageView.bottomAnchor).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        // MARK: INSTAGRAM BUTTON:

        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        instagramButton.topAnchor.constraint(equalTo: instagramImageView.topAnchor, constant: -2).isActive = true
        instagramButton.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor, constant: -2).isActive = true
        instagramButton.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor, constant: 2).isActive = true
        instagramButton.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 2).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = .clear
        selectionStyle = .none

        // MARK: EDIT ACCOUNT:

        editDataButton.setTitle(NSLocalizedString("Edit data / settings", comment: ""), for: .normal)
        editDataButton.layer.cornerRadius = cornerRadius15
        editDataButton.backgroundColor = .colorCell
        editDataButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        editDataButton.setTitleColor(.colorWhite, for: .normal)
        editDataButton.setTitleColor(.systemBlue, for: .highlighted)
        editDataButton.addTarget(self, action: #selector(editAccountButtonTapped), for: .touchUpInside)

        // MARK: BACKUP BUTTON:

        backupButton.setTitle(NSLocalizedString("Backup copy", comment: ""), for: .normal)
        backupButton.layer.cornerRadius = cornerRadius15
        backupButton.backgroundColor = .colorCell
        backupButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        backupButton.setTitleColor(.colorWhite, for: .normal)
        backupButton.setTitleColor(.systemBlue, for: .highlighted)
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        
        // MARK: PRINT BUTTON:
        
        printButton.setTitle(NSLocalizedString("Print / settings", comment: ""), for: .normal)
        printButton.layer.cornerRadius = cornerRadius15
        printButton.backgroundColor = .colorCell
        printButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        printButton.setTitleColor(.colorWhite, for: .normal)
        printButton.setTitleColor(.systemBlue, for: .highlighted)
        printButton.addTarget(self, action: #selector(printButtonTapped), for: .touchUpInside)
        
        // MARK: PREMIUM BUTTON:

        premiumButton.setTitle(NSLocalizedString("Premium version", comment: ""), for: .normal)
        premiumButton.layer.cornerRadius = cornerRadius15
        premiumButton.backgroundColor = .colorCell
        premiumButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        premiumButton.setTitleColor(.colorWhite, for: .normal)
        premiumButton.setTitleColor(.systemBlue, for: .highlighted)
        premiumButton.addTarget(self, action: #selector(premiumButtonTapped), for: .touchUpInside)

        // MARK: STAR:
    
        starImage.image = UIImage(systemName: "star.fill")
        starImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        starImage.tintColor = .systemYellow
        starImage.isHidden = true
        
        Adapty.getProfile { [weak self] result in
            guard let self = self else { return }
            if let profile = try? result.get(),
               profile.accessLevels["premium"]?.isActive ?? false
            {
                starImage.isHidden = true
            } else {
                starImage.isHidden = false
            }
        }
        
        // MARK: NOTIFICATIONS BUTTON:

        notificationsButton.setTitle(NSLocalizedString("Notifications / notifications", comment: ""), for: .normal)
        notificationsButton.layer.cornerRadius = cornerRadius15
        notificationsButton.backgroundColor = .colorCell
        notificationsButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        notificationsButton.setTitleColor(.colorWhite, for: .normal)
        notificationsButton.setTitleColor(.systemBlue, for: .highlighted)
        notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
        notificationsButton.isHidden = true
        
        // MARK: GAME BUTTON:
        
        gameButton.setTitle(NSLocalizedString("Game", comment: ""), for: .normal)
        gameButton.layer.cornerRadius = cornerRadius15
        gameButton.backgroundColor = .colorCell
        gameButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        gameButton.setTitleColor(.colorWhite, for: .normal)
        gameButton.setTitleColor(.systemBlue, for: .highlighted)
        gameButton.addTarget(self, action: #selector(gameButtonTapped), for: .touchUpInside)
        gameButton.isHidden = true
        
        // MARK: ABOUT BUTTON:

        infoButton.setTitle(NSLocalizedString("Information", comment: ""), for: .normal)
        infoButton.layer.cornerRadius = cornerRadius15
        infoButton.backgroundColor = .colorCell
        infoButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        infoButton.setTitleColor(.colorWhite, for: .normal)
        infoButton.setTitleColor(.systemBlue, for: .highlighted)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)

        // MARK: INSTAGRAM IMAGE VIEW:

        let originalImage = UIImage(named: "InstagramLogo")
        let coloredImage = colorizeImage(image: originalImage ?? UIImage(), color: UIColor.white)
        instagramImageView.image = coloredImage
        instagramImageView.contentMode = .scaleAspectFit

        // MARK: INSTAGRAM BUTTON:

        instagramButton.addTarget(self, action: #selector(instagramButtonTapped), for: .touchUpInside)

        // MARK: INFO LABEL:
        
        let currentYear = Calendar.current.component(.year, from: Date())
        infoLabel.text = "2023-\(currentYear), Skydive Book iOS Application"
        infoLabel.textColor = .white
        infoLabel.font = FontManager.regular(size: 8).uiFont
        infoLabel.textAlignment = .center
    }

    // MARK: - HELPERS:

    // MARK: EDIT ACCOUNT:

    @objc private func editAccountButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapEditDataButton()
    }

    // MARK: BACKUP:

    @objc private func backupButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapBackupButton()
    }
    
    // MARK: PRINT:

    @objc private func printButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapPrintButton()
    }
    
    // MARK: PREMIUM BUTTON:

    @objc private func premiumButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapPremiumButton()
    }

    // MARK: NOTIFICATIONS BUTTON:

    @objc private func notificationsButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapNotificationsButton()
    }
    
    // MARK: GAME BUTTON:

    @objc private func gameButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapGameButton()
    }
    
    // MARK: INFO BUTTON:

    @objc private func infoButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapInfoButton()
    }

    // MARK: INSTAGRAM BUTTON:

    @objc private func instagramButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        delegate?.tapInstagramButton()
    }

    // MARK: COLORIZE IMAGE:

    private func colorizeImage(image: UIImage, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        guard let context = context else { return UIImage() }
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: rect, mask: image.cgImage!)
        context.fill(rect)
        guard let coloredImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return coloredImage
    }
    
    // MARK: ROTATION STAR:
    
    private func startBouncingAnimation() {
        UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            self.starImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}
