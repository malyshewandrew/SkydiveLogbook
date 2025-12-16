import UIKit

final class ApplicationTableViewCell: UITableViewCell {
    
    // MARK: - PROPERTIES:
    
    static let id = String(describing: ApplicationTableViewCell.self)
    private let containerView = UIView()
    private let photoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    let installButton = UIButton(type: .system)
    
    // MARK: - LIFYCYCLE:
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        contentView.addSubviews(containerView)
        containerView.addSubviews(photoImageView, titleLabel, descriptionLabel, installButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // CONTAINER VIEW:
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        // PHOTO IMAGE VIEW:
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 1).isActive = true
        
        // TITLE LABEL:
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // DESCRIPTION LABEL:
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 5).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: installButton.leadingAnchor, constant: 05).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        // INSTALL BUTTON:
        installButton.translatesAutoresizingMaskIntoConstraints = false
        installButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        installButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        installButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true
        installButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        
        // CONTENT VIEW:
        contentView.backgroundColor = .colorBackground
        selectionStyle = .none
        
        // CONTAINER VIEW:
        containerView.backgroundColor = .colorCell
        containerView.layer.cornerRadius = 16
        
        // PHOTO IMAGE VIEW:
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 16
        
        // TITLE LABEL:
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .white
        titleLabel.font = FontManager.bold(size: 20).uiFont
        titleLabel.textAlignment = .left
        
        // DESCRIPTION LABEL:
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = FontManager.regular(size: 12).uiFont
        
        // INSTALL BUTTON:
        installButton.setTitle(NSLocalizedString("App Store", comment: ""), for: .normal)
        installButton.setTitleColor(.white, for: .normal)
        installButton.backgroundColor = .systemGreen
        installButton.layer.cornerRadius = 16
    }
    
    // MARK: - HELPERS:
    
    // CONFIGURE:
    func configure(application: ApplicationModel) {
        titleLabel.text = application.title
        descriptionLabel.text = application.description
        photoImageView.image = application.photo
        installButton.addTarget(self, action: #selector(installButtonTapped), for: .touchUpInside)
    }
    
    // INSTALL BUTTON TAPPED:
    @objc func installButtonTapped() {
        
    }
}
