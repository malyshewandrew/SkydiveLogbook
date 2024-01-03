import UIKit

class EditAircraftsCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let view = UIView()
    private let aircraftLabel = UILabel()
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    func addSubviews() {
        contentView.addSubviews(view)
        view.addSubview(aircraftLabel)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: VIEW:

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true

        // MARK: LOCATION LABEL:

        aircraftLabel.translatesAutoresizingMaskIntoConstraints = false
        aircraftLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        aircraftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        aircraftLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        aircraftLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = colorBackground

        // MARK: VIEW:

        view.backgroundColor = colorTabBar
        view.layer.cornerRadius = cornerRadius10

        // MARK: LOCATION LABEL:

        aircraftLabel.textColor = colorWhite
        aircraftLabel.numberOfLines = numberOfLines1
        aircraftLabel.font = fontMediumStandart16
        aircraftLabel.textAlignment = textAligmentLeft
    }

    // MARK: - CONFIGURE MODEL:

    func configure(text: String) {
        aircraftLabel.text = text
    }
}
