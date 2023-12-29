import UIKit

class EditCanopiesCell: UITableViewCell {
    // MARK: - PRIVATE PROPERTIES:

    private let view = UIView()
    private let canopyLabel = UILabel()
    
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
        view.addSubview(canopyLabel)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: - VIEW:

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true

        // MARK: - LOCATION LABEL:

        canopyLabel.translatesAutoresizingMaskIntoConstraints = false
        canopyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        canopyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        canopyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        canopyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: - CONTENT VIEW:

        contentView.backgroundColor = colorBackground

        // MARK: - VIEW:

        view.backgroundColor = colorTabBar
        view.layer.cornerRadius = cornerRadius10

        // MARK: - LOCATION LABEL:

        canopyLabel.textColor = colorWhite
        canopyLabel.numberOfLines = numberOfLines1
        canopyLabel.font = fontMediumStandart16
        canopyLabel.textAlignment = textAligmentLeft
    }

    // MARK: - CONFIGURE FUNC:

    func configure(text: String) {
        canopyLabel.text = text
    }
}
