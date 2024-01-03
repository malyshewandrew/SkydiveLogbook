import UIKit

final class NotesCell: UITableViewCell {
    // MARK: - PRIVATE PROPERTIES:

    private let view = UIView()
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
        contentView.addSubviews(view)
        view.addSubview(noteLabel)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: - VIEW:

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true

        // MARK: - NOTE LABEL:

        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = colorBackground

        // MARK: VIEW:

        view.backgroundColor = colorTabBar
        view.layer.cornerRadius = cornerRadius10

        // MARK: NOTE LABEL:

        noteLabel.textColor = colorWhite
        noteLabel.numberOfLines = numberOfLines0
        noteLabel.font = fontMediumStandart16
        noteLabel.textAlignment = textAligmentLeft
        noteLabel.lineBreakMode = .byWordWrapping
    }

    // MARK: - CONFIGURE MODEL:

    func configure(text: String) {
        noteLabel.text = text
    }
}
