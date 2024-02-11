
import UIKit

class WeatherCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let iconImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
    private let feelTemperatureLabel = UILabel()

    private let cloudCoverLabel = UILabel()
    private let humidityLabel = UILabel()
    private let dewPointLabel = UILabel()
    private let precipitationIntensityLabel = UILabel()
    private let pressureLabel = UILabel()

    private let windSpeedLabel = UILabel()
    private let windDirectionLabel = UILabel()

    private let visibilityLabel = UILabel()

    private let windButton = UIButton()

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubvies()
        configureConstraints()
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubvies() {
        contentView.addSubviews(windButton, iconImageView, descriptionLabel, currentTemperatureLabel, feelTemperatureLabel, cloudCoverLabel, humidityLabel, dewPointLabel, precipitationIntensityLabel, pressureLabel, visibilityLabel)
        windButton.addSubviews(windSpeedLabel, windDirectionLabel)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: CURRENT TEMPERATURE:

        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        currentTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        currentTemperatureLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: DESCRIPTION LABEL:

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: ICON IMAGE VIEW:

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        // MARK: WIND:

        windButton.translatesAutoresizingMaskIntoConstraints = false
        windButton.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 30).isActive = true
        windButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        windButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true

        // MARK: WIND SPEED:

        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.centerXAnchor.constraint(equalTo: windButton.centerXAnchor).isActive = true
        windSpeedLabel.topAnchor.constraint(equalTo: windButton.topAnchor, constant: 20).isActive = true
        windSpeedLabel.heightAnchor.constraint(equalTo: windButton.heightAnchor, multiplier: 0.6).isActive = true
        windSpeedLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: WIND DIRECTION:

        windDirectionLabel.translatesAutoresizingMaskIntoConstraints = false
        windDirectionLabel.bottomAnchor.constraint(equalTo: windButton.bottomAnchor, constant: -5).isActive = true
        windDirectionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windDirectionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        windDirectionLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 1).isActive = true

//        // MARK: FEEL TEMPERATURE:
//
//        feelTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
//        feelTemperatureLabel.topAnchor.constraint(equalTo: windButton.bottomAnchor, constant: 5).isActive = true
//        feelTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        feelTemperatureLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        feelTemperatureLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: CLOUD COVER:

        cloudCoverLabel.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverLabel.topAnchor.constraint(equalTo: windButton.bottomAnchor, constant: 5).isActive = true
        cloudCoverLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cloudCoverLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cloudCoverLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: HUMIDITY:

        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.topAnchor.constraint(equalTo: cloudCoverLabel.bottomAnchor, constant: 5).isActive = true
        humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        humidityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        humidityLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: DEW POINT:

        dewPointLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 5).isActive = true
        dewPointLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dewPointLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dewPointLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: PRECIPITATION INTENSITY:

        precipitationIntensityLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationIntensityLabel.topAnchor.constraint(equalTo: dewPointLabel.bottomAnchor, constant: 5).isActive = true
        precipitationIntensityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        precipitationIntensityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        precipitationIntensityLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: PRESSURE:

        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.topAnchor.constraint(equalTo: precipitationIntensityLabel.bottomAnchor, constant: 5).isActive = true
        pressureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pressureLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pressureLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        // MARK: VISIBILITY:

        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 5).isActive = true
        visibilityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        visibilityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        visibilityLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        visibilityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        selectionStyle = .none

        // MARK: CONTENT VIEW:

        contentView.backgroundColor = .clear

        // MARK: CURRENT TEMPERATURE:

        currentTemperatureLabel.textColor = .colorWhite
        currentTemperatureLabel.font = .systemFont(ofSize: 75, weight: .regular, width: .standard)
        currentTemperatureLabel.numberOfLines = 0
        currentTemperatureLabel.textAlignment = .center

        // MARK: DESCRIPTION LABEL:

        descriptionLabel.textColor = .colorWhite
        descriptionLabel.font = fontMediumStandard14
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center

        // MARK: ICON IMAGE VIEW:

        iconImageView.tintColor = .colorWhite
        
        // MARK: WIND:
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = windButton.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        windButton.addSubview(blurEffectView)
        windButton.setTitle("Скорость ветра", for: .normal)
        windButton.setTitleColor(.white, for: .normal)
        windButton.contentVerticalAlignment = textAligmentTop
        windButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        windButton.layer.masksToBounds = true
        windButton.layer.cornerRadius = 15
        windButton.addSubviews(windSpeedLabel, windDirectionLabel)
        
        // MARK: WIND SPEED:

        windSpeedLabel.textColor = .white
        windSpeedLabel.font = .systemFont(ofSize: 55, weight: .regular, width: .standard)
        windSpeedLabel.numberOfLines = 0
        windSpeedLabel.textAlignment = .center

        // MARK: WIND DIRECTION:

        windDirectionLabel.textColor = .white
        windDirectionLabel.font = fontMediumStandard14
        windDirectionLabel.numberOfLines = 0
        windDirectionLabel.textAlignment = .center

        // MARK: FEEL TEMPERATURE:

        feelTemperatureLabel.textColor = .colorWhite
        feelTemperatureLabel.font = fontRegularStandard10
        feelTemperatureLabel.numberOfLines = 0
        feelTemperatureLabel.textAlignment = .center

        // MARK: CLOUD COVER:

        cloudCoverLabel.textColor = .colorWhite
        cloudCoverLabel.font = fontRegularStandard10
        cloudCoverLabel.numberOfLines = 0
        cloudCoverLabel.textAlignment = .center

        // MARK: HUMIDITY:

        humidityLabel.textColor = .colorWhite
        humidityLabel.font = fontRegularStandard10
        humidityLabel.numberOfLines = 0
        humidityLabel.textAlignment = .center

        // MARK: DEW POINT:

        dewPointLabel.textColor = .colorWhite
        dewPointLabel.font = fontRegularStandard10
        dewPointLabel.numberOfLines = 0
        dewPointLabel.textAlignment = .center

        // MARK: PRECIPITATION INTENSITY:

        precipitationIntensityLabel.textColor = .colorWhite
        precipitationIntensityLabel.font = fontRegularStandard10
        precipitationIntensityLabel.numberOfLines = 0
        precipitationIntensityLabel.textAlignment = .center

        // MARK: PRESSURE:

        pressureLabel.textColor = .colorWhite
        pressureLabel.font = fontRegularStandard10
        pressureLabel.numberOfLines = 0
        pressureLabel.textAlignment = .center

        // MARK: VISIBILITY:

        visibilityLabel.textColor = .colorWhite
        visibilityLabel.font = fontRegularStandard10
        visibilityLabel.numberOfLines = 0
        visibilityLabel.textAlignment = .center
    }

    // MARK: - HELPERS:

    func configure(iconImage: UIImage, description: String, currentTemperature: String, feelTemperature: String, cloudCover: String, humidity: String, dewPoint: String, precipitationIntensity: String, pressure: String, windSpeed: String, windDirection: String, visibility: String) {
        iconImageView.image = iconImage
        descriptionLabel.text = description
        currentTemperatureLabel.text = currentTemperature
        feelTemperatureLabel.text = feelTemperature
        cloudCoverLabel.text = cloudCover
        humidityLabel.text = humidity
        dewPointLabel.text = dewPoint
        precipitationIntensityLabel.text = precipitationIntensity
        pressureLabel.text = pressure
        windSpeedLabel.text = windSpeed
        windDirectionLabel.text = windDirection
        visibilityLabel.text = visibility
    }
}
