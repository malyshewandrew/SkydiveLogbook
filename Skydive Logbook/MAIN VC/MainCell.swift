import UIKit

final class MainCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let containerView = UIView()
    private let numberLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let aircraftLabel = UILabel()
    private let canopyLabel = UILabel()
    private let missionLabel = UILabel()
    private let heightLabel = UILabel()
    private let timeLabel = UILabel()
    private let cutawayLabel = UILabel()
    private let commentLabel = UILabel()
    private let cellButton = UIButton()
    var tapOnCell: (() -> ())?

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUserInterface()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(containerView, numberLabel, dateLabel, locationLabel, aircraftLabel, canopyLabel, missionLabel, heightLabel, timeLabel, cutawayLabel, commentLabel, cellButton)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: CELL VIEW:

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        // MARK: NUMBER LABEL:

        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // MARK: CANOPY LABEL:

        canopyLabel.translatesAutoresizingMaskIntoConstraints = false
        canopyLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        canopyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        canopyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        canopyLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.46).isActive = true

        // MARK: MISSION LABEL:

        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        missionLabel.topAnchor.constraint(equalTo: canopyLabel.bottomAnchor, constant: 5).isActive = true
        missionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        missionLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.46).isActive = true

        // MARK: DATE LABEL:

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true

        // MARK: LOCATION LABEL:

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true

        // MARK: AIRCRAFT LABEL:

        aircraftLabel.translatesAutoresizingMaskIntoConstraints = false
        aircraftLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 2).isActive = true
        aircraftLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        aircraftLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        aircraftLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true

        // MARK: HEIGHT LABEL:

        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.topAnchor.constraint(equalTo: aircraftLabel.bottomAnchor, constant: 2).isActive = true
        heightLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        heightLabel.heightAnchor.constraint(equalToConstant: 11).isActive = true
        heightLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true
        heightLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUserInterface() {
        // MARK: VIEW:

        selectionStyle = .none
        contentView.backgroundColor = colorBackground

        // MARK: CELL VIEW:

        containerView.backgroundColor = colorCell
        containerView.layer.cornerRadius = cornerRadius10

        // MARK: NUMBER LABEL:

        numberLabel.textColor = colorDarkGray
        numberLabel.font = fontMainNumber
        numberLabel.numberOfLines = numberOfLines1
        numberLabel.textAlignment = .left
        numberLabel.adjustsFontSizeToFitWidth = true

        // MARK: CANOPY LABEL:

        canopyLabel.textColor = colorWhite
        canopyLabel.font = fontMainCanopy
        canopyLabel.numberOfLines = numberOfLines1
        canopyLabel.textAlignment = .center
        canopyLabel.adjustsFontSizeToFitWidth = true

        // MARK: MISSION LABEL:

        missionLabel.textColor = colorDarkGray
        missionLabel.font = fontMainMission
        missionLabel.numberOfLines = numberOfLines1
        missionLabel.textAlignment = .center
        missionLabel.adjustsFontSizeToFitWidth = true

        // MARK: DATE LABEL:

        dateLabel.textColor = colorWhite
        dateLabel.font = fontMainDateLocationAircraftHeight
        dateLabel.numberOfLines = numberOfLines1
        dateLabel.textAlignment = .right
        dateLabel.adjustsFontSizeToFitWidth = true

        // MARK: LOCATION LABEL:

        locationLabel.textColor = colorWhite
        locationLabel.font = fontMainDateLocationAircraftHeight
        locationLabel.numberOfLines = numberOfLines1
        locationLabel.textAlignment = .right
        locationLabel.adjustsFontSizeToFitWidth = true

        // MARK: AIRCRAFT LABEL:

        aircraftLabel.textColor = colorWhite
        aircraftLabel.font = fontMainDateLocationAircraftHeight
        aircraftLabel.numberOfLines = numberOfLines1
        aircraftLabel.textAlignment = .right
        aircraftLabel.adjustsFontSizeToFitWidth = true

        // MARK: HEIGHT LABEL:

        heightLabel.textColor = colorWhite
        heightLabel.font = fontMainDateLocationAircraftHeight
        heightLabel.numberOfLines = numberOfLines1
        heightLabel.textAlignment = .right
        heightLabel.adjustsFontSizeToFitWidth = true
    }

    // MARK: - CONFIGURE:

    func configure(number: String, date: String, location: String, aircraft: String, canopy: String, mission: String, height: String, time: String, cutaway: String, comment: String) {
        numberLabel.text = number
        dateLabel.text = date
        locationLabel.text = location
        aircraftLabel.text = aircraft
        canopyLabel.text = canopy
        missionLabel.text = mission
        heightLabel.text = height
        timeLabel.text = time
        cutawayLabel.text = cutaway
        commentLabel.text = comment
    }
    
    // MARK: - ACTION FOR CLOSURE:

    @objc private func transitionVC() {
        tapOnCell?()
    }
}
