import UIKit
import RealmSwift

final class NotesCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let containerView = UIView()
    private let noteLabel = UILabel()

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

    func addSubviews() {
        contentView.addSubviews(containerView)
        containerView.addSubview(noteLabel)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: VIEW:

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true

        // MARK: NOTE LABEL:

        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = .colorTabBar
        
        // MARK: SELECTON STYLE:
        
        selectionStyle = .none

        // MARK: VIEW:

        containerView.addBlurEffect(.systemUltraThinMaterial)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .colorBackground
        containerView.layer.cornerRadius = 10
        containerView.addSubview(noteLabel)
        
        // MARK: NOTE LABEL:

        noteLabel.textColor = .colorWhite
        noteLabel.numberOfLines = 0
        noteLabel.font = FontManager.bold(size: 16).uiFont
        noteLabel.textAlignment = .left
        noteLabel.lineBreakMode = .byWordWrapping
    }

    // MARK: - CONFIGURE MODEL:

    func configure(text: String, background: UIColor) {
        noteLabel.text = text
        contentView.backgroundColor = background
    }
}
