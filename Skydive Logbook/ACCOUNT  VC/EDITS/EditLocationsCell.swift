import UIKit

class EditLocationsCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let view = UIView()
    private let locationLabel = UILabel()
    
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
        view.addSubview(locationLabel)
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

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = colorBackground

        // MARK: VIEW:

        view.backgroundColor = colorTabBar
        view.layer.cornerRadius = cornerRadius10

        // MARK: LOCATION LABEL:

        locationLabel.textColor = colorWhite
        locationLabel.numberOfLines = numberOfLines1
        locationLabel.font = fontMediumStandart16
        locationLabel.textAlignment = textAligmentLeft
    }

    // MARK: CONFIGURE MODEL:

    func configure(text: String) {
        locationLabel.text = text
    }
}
