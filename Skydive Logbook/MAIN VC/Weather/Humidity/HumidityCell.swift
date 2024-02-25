import UIKit
final class HumidityCell: UITableViewCell {
    // MARK: - PROPERTIES:
    
    private let containerView = UIView()
    private let imageImageView = UIImageView()
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 18)
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        contentView.addSubviews(containerView)
        containerView.addSubviews(imageImageView, nameLabel, valueLabel)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: CONTAINER VIEW:
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        // MARK: IMAGE:
        
        imageImageView.translatesAutoresizingMaskIntoConstraints = false
        imageImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        imageImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        // MARK: NAME:
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        
        // MARK: VALUE:
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    }

    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: CONTENT VIEW:
        
        contentView.backgroundColor = .clear
        
        // MARK: IMAGE:
        
        imageImageView.tintColor = .white
        
        // MARK: NAME:
        
        nameLabel.textColor = .white
        nameLabel.font = fontMediumStandard14
        nameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: VALUE
        
        valueLabel.textColor = .white
        valueLabel.font = fontMediumStandard14
        valueLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE:
    
    func configure(image: UIImage, imageColor: UIColor, name: String, value: String) {
        imageImageView.image = image.withConfiguration(configurationImage)
        imageImageView.tintColor = imageColor
        nameLabel.text = name
        valueLabel.text = value
    }
}
    
