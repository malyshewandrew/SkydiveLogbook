import MapKit
import UIKit

protocol WeatherCellDelegate {
    func tapWindInfoButton()
    func tapWindOverlayButton()
    func taptemperatureOverlayButton()
    func tapCloudCoverOverlayButton()
    func tapHumidityOverlayButton()
    func tapDewPointOverlayButton()
    func tapPrecipitationOverlayButton()
    func tapPressureOverlayButton()
    func tapUvIndexOverlayButton()
    func tapVisibilityOverlayButton()
}

final class WeatherCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let iconImageView = UIImageView()

    private let windButton = UIButton()
    private let windSpeedLabel = UILabel()
    private let windGustLabel = UILabel()
    private let windDirectionLabel = UILabel()
    private let windOverlayButton = UIButton()

    private let temperatureButton = UIButton()
    private let descriptionLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
    private let feelTemperatureLabel = UILabel()
    private let temperatureOverlayButton = UIButton()

    private let cloudCoverButton = UIButton()
    private let cloudCoverLabel = UILabel()
    private let cloudCoverOverlayButton = UIButton()

    private let humidityButton = UIButton()
    private let humidityLabel = UILabel()
    private let humidityOverlayButton = UIButton()

    private let dewPointButton = UIButton()
    private let dewPointLabel = UILabel()
    private let dewPointOverlayButton = UIButton()

    private let precipitationButton = UIButton()
    private let precipitationLabel = UILabel()
    private let precipitationOverlayButton = UIButton()

    private let pressureButton = UIButton()
    private let pressureLabel = UILabel()
    private let pressureOverlayButton = UIButton()

    private let uvIndexButton = UIButton()
    private let uvIndexLabel = UILabel()
    private let uvIndexOverlayButton = UIButton()

    private let visibilityButton = UIButton()
    private let visibilityLabel = UILabel()
    private let visibilityOverlayButton = UIButton()

    private let vibrationOn = Vibration()
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let arrowImage = UIImageView()
    private let configurationArrow = UIImage.SymbolConfiguration(pointSize: 25)
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 40)
    private let currentLocationButton = UIButton()
    private let windInfoButton = UIButton()
    var delegate: WeatherCellDelegate?

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubvies()
        configureConstraints()
        configureUI()
        setStartLocation()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubvies() {
        contentView.addSubviews(windButton, temperatureButton, cloudCoverButton, humidityButton, dewPointButton, precipitationButton, visibilityButton, pressureButton, uvIndexButton, iconImageView, mapView)
        windButton.addSubviews(windSpeedLabel, windGustLabel, windDirectionLabel, windOverlayButton)
        temperatureButton.addSubviews(currentTemperatureLabel, descriptionLabel, feelTemperatureLabel, temperatureOverlayButton)
        cloudCoverButton.addSubviews(cloudCoverLabel, cloudCoverOverlayButton)
        humidityButton.addSubviews(humidityLabel, humidityOverlayButton)
        dewPointButton.addSubviews(dewPointLabel, dewPointOverlayButton)
        precipitationButton.addSubviews(precipitationLabel, precipitationOverlayButton)
        visibilityButton.addSubviews(visibilityLabel, visibilityOverlayButton)
        pressureButton.addSubviews(pressureLabel, pressureOverlayButton)
        uvIndexButton.addSubviews(uvIndexLabel, uvIndexOverlayButton)
        mapView.addSubviews(arrowImage, currentLocationButton, windInfoButton)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: ICON IMAGE VIEW:

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.bottomAnchor.constraint(equalTo: windButton.topAnchor, constant: -10).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        // MARK: - WIND BUTTON:

        windButton.translatesAutoresizingMaskIntoConstraints = false
        windButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 90).isActive = true
        windButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windButton.bottomAnchor.constraint(equalTo: windDirectionLabel.bottomAnchor, constant: 10).isActive = true
        windButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.55).isActive = true

        // WIND SPEED:

        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.centerXAnchor.constraint(equalTo: windButton.centerXAnchor).isActive = true
        windSpeedLabel.topAnchor.constraint(equalTo: windButton.topAnchor, constant: 15).isActive = true
        windSpeedLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 0.9).isActive = true

        // WIND GUST:

        windGustLabel.translatesAutoresizingMaskIntoConstraints = false
        windGustLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windGustLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 5).isActive = true
        windGustLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 0.9).isActive = true

        // WIND DIRECTION:

        windDirectionLabel.translatesAutoresizingMaskIntoConstraints = false
        windDirectionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windDirectionLabel.topAnchor.constraint(equalTo: windGustLabel.bottomAnchor, constant: 1).isActive = true
        windDirectionLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 0.9).isActive = true

        // WIND OVERLAY BUTTON:

        windOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        windOverlayButton.topAnchor.constraint(equalTo: windButton.topAnchor).isActive = true
        windOverlayButton.leadingAnchor.constraint(equalTo: windButton.leadingAnchor).isActive = true
        windOverlayButton.trailingAnchor.constraint(equalTo: windButton.trailingAnchor).isActive = true
        windOverlayButton.bottomAnchor.constraint(equalTo: windButton.bottomAnchor).isActive = true

        // MARK: - TEMPERATURE BUTTON:

        temperatureButton.translatesAutoresizingMaskIntoConstraints = false
        temperatureButton.topAnchor.constraint(equalTo: windButton.bottomAnchor, constant: 15).isActive = true
        temperatureButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        temperatureButton.bottomAnchor.constraint(equalTo: feelTemperatureLabel.bottomAnchor, constant: 10).isActive = true
        temperatureButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65).isActive = true

        // CURRENT TEMPERATURE:

        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.centerXAnchor.constraint(equalTo: temperatureButton.centerXAnchor).isActive = true
        currentTemperatureLabel.topAnchor.constraint(equalTo: temperatureButton.topAnchor, constant: 20).isActive = true
        currentTemperatureLabel.widthAnchor.constraint(equalTo: temperatureButton.widthAnchor, multiplier: 0.9).isActive = true

        // DESCRIPTION:

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: temperatureButton.widthAnchor, multiplier: 0.9).isActive = true

        // FEEL TEMPERATURE:

        feelTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        feelTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        feelTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1).isActive = true
        feelTemperatureLabel.widthAnchor.constraint(equalTo: temperatureButton.widthAnchor, multiplier: 0.9).isActive = true

        // TEMPEPATURE OVERLAY BUTTON:

        temperatureOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        temperatureOverlayButton.topAnchor.constraint(equalTo: temperatureButton.topAnchor).isActive = true
        temperatureOverlayButton.leadingAnchor.constraint(equalTo: temperatureButton.leadingAnchor).isActive = true
        temperatureOverlayButton.trailingAnchor.constraint(equalTo: temperatureButton.trailingAnchor).isActive = true
        temperatureOverlayButton.bottomAnchor.constraint(equalTo: temperatureButton.bottomAnchor).isActive = true

        // MARK: - HUMIDITY BUTTON:

        humidityButton.translatesAutoresizingMaskIntoConstraints = false
        humidityButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        humidityButton.trailingAnchor.constraint(equalTo: cloudCoverButton.leadingAnchor, constant: -10).isActive = true
        humidityButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        humidityButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.21).isActive = true

        // HUMIDITY:

        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.centerXAnchor.constraint(equalTo: humidityButton.centerXAnchor).isActive = true
        humidityLabel.topAnchor.constraint(equalTo: humidityButton.topAnchor, constant: 20).isActive = true
        humidityLabel.widthAnchor.constraint(equalTo: humidityButton.widthAnchor, multiplier: 0.9).isActive = true
        humidityLabel.bottomAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: -5).isActive = true

        // HUMIDITY OVERLAY BUTTON:

        humidityOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        humidityOverlayButton.topAnchor.constraint(equalTo: humidityButton.topAnchor).isActive = true
        humidityOverlayButton.leadingAnchor.constraint(equalTo: humidityButton.leadingAnchor).isActive = true
        humidityOverlayButton.trailingAnchor.constraint(equalTo: humidityButton.trailingAnchor).isActive = true
        humidityOverlayButton.bottomAnchor.constraint(equalTo: humidityButton.bottomAnchor).isActive = true

        // MARK: - CLOUD COVER BUTTON:

        cloudCoverButton.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        cloudCoverButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5).isActive = true
        cloudCoverButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        cloudCoverButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.21).isActive = true

        // CLOUD COVER:

        cloudCoverLabel.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverLabel.centerXAnchor.constraint(equalTo: cloudCoverButton.centerXAnchor).isActive = true
        cloudCoverLabel.topAnchor.constraint(equalTo: cloudCoverButton.topAnchor, constant: 20).isActive = true
        cloudCoverLabel.widthAnchor.constraint(equalTo: cloudCoverButton.widthAnchor, multiplier: 0.9).isActive = true
        cloudCoverLabel.bottomAnchor.constraint(equalTo: cloudCoverButton.bottomAnchor, constant: -5).isActive = true

        // CLOUD COVER OVERLAY BUTTON:

        cloudCoverOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverOverlayButton.topAnchor.constraint(equalTo: cloudCoverButton.topAnchor).isActive = true
        cloudCoverOverlayButton.leadingAnchor.constraint(equalTo: cloudCoverButton.leadingAnchor).isActive = true
        cloudCoverOverlayButton.trailingAnchor.constraint(equalTo: cloudCoverButton.trailingAnchor).isActive = true
        cloudCoverOverlayButton.bottomAnchor.constraint(equalTo: cloudCoverButton.bottomAnchor).isActive = true

        // MARK: - DEW POINT BUTTON:

        dewPointButton.translatesAutoresizingMaskIntoConstraints = false
        dewPointButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        dewPointButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5).isActive = true
        dewPointButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        dewPointButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.21).isActive = true

        // DEW POINT:

        dewPointLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointLabel.centerXAnchor.constraint(equalTo: dewPointButton.centerXAnchor).isActive = true
        dewPointLabel.topAnchor.constraint(equalTo: dewPointButton.topAnchor, constant: 20).isActive = true
        dewPointLabel.widthAnchor.constraint(equalTo: dewPointButton.widthAnchor, multiplier: 0.9).isActive = true
        dewPointLabel.bottomAnchor.constraint(equalTo: dewPointButton.bottomAnchor, constant: -5).isActive = true

        // DEW POINT OVERLAY BUTTON:

        dewPointOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        dewPointOverlayButton.topAnchor.constraint(equalTo: dewPointButton.topAnchor).isActive = true
        dewPointOverlayButton.leadingAnchor.constraint(equalTo: dewPointButton.leadingAnchor).isActive = true
        dewPointOverlayButton.trailingAnchor.constraint(equalTo: dewPointButton.trailingAnchor).isActive = true
        dewPointOverlayButton.bottomAnchor.constraint(equalTo: dewPointButton.bottomAnchor).isActive = true

        // MARK: - VISIBILITY BUTTON:

        visibilityButton.translatesAutoresizingMaskIntoConstraints = false
        visibilityButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        visibilityButton.leadingAnchor.constraint(equalTo: dewPointButton.trailingAnchor, constant: 10).isActive = true
        visibilityButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        visibilityButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.21).isActive = true

        // VISIBILITY:

        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.centerXAnchor.constraint(equalTo: visibilityButton.centerXAnchor).isActive = true
        visibilityLabel.topAnchor.constraint(equalTo: visibilityButton.topAnchor, constant: 20).isActive = true
        visibilityLabel.widthAnchor.constraint(equalTo: visibilityButton.widthAnchor, multiplier: 0.9).isActive = true
        visibilityLabel.bottomAnchor.constraint(equalTo: visibilityButton.bottomAnchor, constant: -5).isActive = true

        // VISIBILITY OVERLAY BUTTON:

        visibilityOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        visibilityOverlayButton.topAnchor.constraint(equalTo: visibilityButton.topAnchor).isActive = true
        visibilityOverlayButton.leadingAnchor.constraint(equalTo: visibilityButton.leadingAnchor).isActive = true
        visibilityOverlayButton.trailingAnchor.constraint(equalTo: visibilityButton.trailingAnchor).isActive = true
        visibilityOverlayButton.bottomAnchor.constraint(equalTo: visibilityButton.bottomAnchor).isActive = true

        // MARK: - PRECIPITATION BUTTON:

        precipitationButton.translatesAutoresizingMaskIntoConstraints = false
        precipitationButton.topAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: 15).isActive = true
        precipitationButton.trailingAnchor.constraint(equalTo: pressureButton.leadingAnchor, constant: -10).isActive = true
        precipitationButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        precipitationButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.29).isActive = true

        // PRECIPITATION:

        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationLabel.centerXAnchor.constraint(equalTo: precipitationButton.centerXAnchor).isActive = true
        precipitationLabel.topAnchor.constraint(equalTo: precipitationButton.topAnchor, constant: 20).isActive = true
        precipitationLabel.widthAnchor.constraint(equalTo: precipitationButton.widthAnchor, multiplier: 0.9).isActive = true
        precipitationLabel.bottomAnchor.constraint(equalTo: precipitationButton.bottomAnchor, constant: -5).isActive = true

        // PRECIPITATION OVERLAY BUTTON:

        precipitationOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        precipitationOverlayButton.topAnchor.constraint(equalTo: precipitationButton.topAnchor).isActive = true
        precipitationOverlayButton.leadingAnchor.constraint(equalTo: precipitationButton.leadingAnchor).isActive = true
        precipitationOverlayButton.trailingAnchor.constraint(equalTo: precipitationButton.trailingAnchor).isActive = true
        precipitationOverlayButton.bottomAnchor.constraint(equalTo: precipitationButton.bottomAnchor).isActive = true

        // MARK: - PRESSURE BUTTON:

        pressureButton.translatesAutoresizingMaskIntoConstraints = false
        pressureButton.topAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: 15).isActive = true
        pressureButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pressureButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        pressureButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.29).isActive = true

        // PRESSURE:

        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.centerXAnchor.constraint(equalTo: pressureButton.centerXAnchor).isActive = true
        pressureLabel.topAnchor.constraint(equalTo: pressureButton.topAnchor, constant: 20).isActive = true
        pressureLabel.widthAnchor.constraint(equalTo: pressureButton.widthAnchor, multiplier: 0.9).isActive = true
        pressureLabel.bottomAnchor.constraint(equalTo: pressureButton.bottomAnchor, constant: -5).isActive = true

        // PRECIPITATION OVERLAY BUTTON:

        pressureOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        pressureOverlayButton.topAnchor.constraint(equalTo: pressureButton.topAnchor).isActive = true
        pressureOverlayButton.leadingAnchor.constraint(equalTo: pressureButton.leadingAnchor).isActive = true
        pressureOverlayButton.trailingAnchor.constraint(equalTo: pressureButton.trailingAnchor).isActive = true
        pressureOverlayButton.bottomAnchor.constraint(equalTo: pressureButton.bottomAnchor).isActive = true

        // MARK: - UVINDEX BUTTON:

        uvIndexButton.translatesAutoresizingMaskIntoConstraints = false
        uvIndexButton.topAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: 15).isActive = true
        uvIndexButton.leadingAnchor.constraint(equalTo: pressureButton.trailingAnchor, constant: 10).isActive = true
        uvIndexButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        uvIndexButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.29).isActive = true

        // UVINDEX:

        uvIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        uvIndexLabel.centerXAnchor.constraint(equalTo: uvIndexButton.centerXAnchor).isActive = true
        uvIndexLabel.topAnchor.constraint(equalTo: uvIndexButton.topAnchor, constant: 20).isActive = true
        uvIndexLabel.widthAnchor.constraint(equalTo: uvIndexButton.widthAnchor, multiplier: 0.9).isActive = true
        uvIndexLabel.bottomAnchor.constraint(equalTo: uvIndexButton.bottomAnchor, constant: -5).isActive = true

        // UVINDEX OVERLAY BUTTON:

        uvIndexOverlayButton.translatesAutoresizingMaskIntoConstraints = false
        uvIndexOverlayButton.topAnchor.constraint(equalTo: uvIndexButton.topAnchor).isActive = true
        uvIndexOverlayButton.leadingAnchor.constraint(equalTo: uvIndexButton.leadingAnchor).isActive = true
        uvIndexOverlayButton.trailingAnchor.constraint(equalTo: uvIndexButton.trailingAnchor).isActive = true
        uvIndexOverlayButton.bottomAnchor.constraint(equalTo: uvIndexButton.bottomAnchor).isActive = true

        // MARK: - MAP VIEW:

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: pressureButton.bottomAnchor, constant: 15).isActive = true
        mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        mapView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        // MARK: - CURRENT LOCATION BUTTON:

        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -10).isActive = true
        currentLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true

        // MARK: INFO BUTTON:

        windInfoButton.translatesAutoresizingMaskIntoConstraints = false
        windInfoButton.bottomAnchor.constraint(equalTo: currentLocationButton.topAnchor, constant: -20).isActive = true
        windInfoButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true

        // MARK: - ARROW IMAGE:

        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: 10).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        selectionStyle = .none

        // MARK: CONTENT VIEW:

        contentView.backgroundColor = .clear

        // MARK: ICON IMAGE VIEW:

        iconImageView.tintColor = .white

        // MARK: - WIND BUTTON:

        let blurWind = UIBlurEffect(style: .systemThinMaterialDark)
        let blurWindEffectView = UIVisualEffectView(effect: blurWind)
        blurWindEffectView.frame = windButton.bounds
        blurWindEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        windButton.addSubviews(blurWindEffectView, windSpeedLabel, windGustLabel, windDirectionLabel, windOverlayButton)
        windButton.setTitle(NSLocalizedString("Wind speed / weather", comment: ""), for: .normal)
        windButton.setTitleColor(.white, for: .normal)
        windButton.contentVerticalAlignment = textAligmentTop
        windButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        windButton.layer.masksToBounds = true
        windButton.layer.cornerRadius = cornerRadius15
        windOverlayButton.addTarget(self, action: #selector(windOverlayButtonTapped), for: .touchUpInside)

        // WIND SPEED:

        windSpeedLabel.textColor = .white
        windSpeedLabel.font = .systemFont(ofSize: 55, weight: .regular, width: .standard)
        windSpeedLabel.numberOfLines = 0
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.adjustsFontSizeToFitWidth = true

        // WIND GUST:

        windGustLabel.textColor = .white
        windGustLabel.font = fontMediumStandard14
        windGustLabel.numberOfLines = 0
        windGustLabel.textAlignment = .center
        windGustLabel.adjustsFontSizeToFitWidth = true

        // WIND DIRECTION:

        windDirectionLabel.textColor = .white
        windDirectionLabel.font = fontMediumStandard14
        windDirectionLabel.numberOfLines = 0
        windDirectionLabel.textAlignment = .center
        windDirectionLabel.adjustsFontSizeToFitWidth = true

        // MARK: - TEMPERATURE BUTTON:

        let blurTemperature = UIBlurEffect(style: .systemThinMaterialDark)
        let blurTemperatureEffectView = UIVisualEffectView(effect: blurTemperature)
        blurTemperatureEffectView.frame = temperatureButton.bounds
        blurTemperatureEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        temperatureButton.addSubviews(blurTemperatureEffectView, currentTemperatureLabel, descriptionLabel, feelTemperatureLabel, temperatureOverlayButton)
        temperatureButton.setTitle(NSLocalizedString("Temperature / weather", comment: ""), for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureButton.contentVerticalAlignment = textAligmentTop
        temperatureButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        temperatureButton.layer.masksToBounds = true
        temperatureButton.layer.cornerRadius = cornerRadius15
        temperatureOverlayButton.addTarget(self, action: #selector(temperatureOverlayButtonTapped), for: .touchUpInside)

        // CURRENT TEMPERATURE:

        currentTemperatureLabel.textColor = .white
        currentTemperatureLabel.font = .systemFont(ofSize: 35, weight: .regular, width: .standard)
        currentTemperatureLabel.numberOfLines = 0
        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.adjustsFontSizeToFitWidth = true

        // DESCRIPTION LABEL:

        descriptionLabel.textColor = .white
        descriptionLabel.font = fontMediumStandard14
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.adjustsFontSizeToFitWidth = true

        // FEEL TEMPERATURE:

        feelTemperatureLabel.textColor = .white
        feelTemperatureLabel.font = fontMediumStandard14
        feelTemperatureLabel.numberOfLines = 0
        feelTemperatureLabel.textAlignment = .center
        feelTemperatureLabel.adjustsFontSizeToFitWidth = true

        // MARK: - HUMIDITY BUTTON:

        let blurHumidity = UIBlurEffect(style: .systemThinMaterialDark)
        let blurHumidityEffectView = UIVisualEffectView(effect: blurHumidity)
        blurHumidityEffectView.frame = humidityButton.bounds
        blurHumidityEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        humidityButton.addSubviews(blurHumidityEffectView, humidityLabel, humidityOverlayButton)
        humidityButton.setTitle(NSLocalizedString("Humidity / weather", comment: ""), for: .normal)
        humidityButton.setTitleColor(.white, for: .normal)
        humidityButton.contentVerticalAlignment = textAligmentTop
        humidityButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        humidityButton.layer.masksToBounds = true
        humidityButton.layer.cornerRadius = cornerRadius15
        humidityOverlayButton.addTarget(self, action: #selector(humidityOverlayButtonTapped), for: .touchUpInside)

        // HUMIDITY:

        humidityLabel.textColor = .white
        humidityLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        humidityLabel.numberOfLines = 0
        humidityLabel.textAlignment = .center
        humidityLabel.adjustsFontSizeToFitWidth = true

        // MARK: - CLOUD COVER BUTTON:

        let blurCloudCover = UIBlurEffect(style: .systemThinMaterialDark)
        let blurCloudCoverEffectView = UIVisualEffectView(effect: blurCloudCover)
        blurCloudCoverEffectView.frame = cloudCoverButton.bounds
        blurCloudCoverEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cloudCoverButton.addSubviews(blurCloudCoverEffectView, cloudCoverLabel, cloudCoverOverlayButton)
        cloudCoverButton.setTitle(NSLocalizedString("Cloud cover / weather", comment: ""), for: .normal)
        cloudCoverButton.setTitleColor(.white, for: .normal)
        cloudCoverButton.contentVerticalAlignment = textAligmentTop
        cloudCoverButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        cloudCoverButton.layer.masksToBounds = true
        cloudCoverButton.layer.cornerRadius = 15
        cloudCoverOverlayButton.addTarget(self, action: #selector(cloudCoverOverlayButtonTapped), for: .touchUpInside)

        // CLOUD COVER:

        cloudCoverLabel.textColor = .white
        cloudCoverLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        cloudCoverLabel.numberOfLines = 0
        cloudCoverLabel.textAlignment = .center
        cloudCoverLabel.adjustsFontSizeToFitWidth = true

        // MARK: - DEW POINT BUTTON:

        let blurDewPoint = UIBlurEffect(style: .systemThinMaterialDark)
        let blurDewPointEffectView = UIVisualEffectView(effect: blurDewPoint)
        blurDewPointEffectView.frame = dewPointButton.bounds
        blurDewPointEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dewPointButton.addSubviews(blurDewPointEffectView, dewPointLabel, dewPointOverlayButton)
        dewPointButton.setTitle(NSLocalizedString("Dew point / weather", comment: ""), for: .normal)
        dewPointButton.setTitleColor(.white, for: .normal)
        dewPointButton.contentVerticalAlignment = textAligmentTop
        dewPointButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dewPointButton.layer.masksToBounds = true
        dewPointButton.layer.cornerRadius = cornerRadius15
        dewPointOverlayButton.addTarget(self, action: #selector(dewPointOverlayButtonTapped), for: .touchUpInside)

        // DEW POINT

        dewPointLabel.textColor = .white
        dewPointLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        dewPointLabel.numberOfLines = 0
        dewPointLabel.textAlignment = .center
        dewPointLabel.adjustsFontSizeToFitWidth = true

        // MARK: - VISIBILITY BUTTON:

        let blurVisibilityIntensity = UIBlurEffect(style: .systemThinMaterialDark)
        let blurVisibilityEffectView = UIVisualEffectView(effect: blurVisibilityIntensity)
        blurVisibilityEffectView.frame = precipitationButton.bounds
        blurVisibilityEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visibilityButton.addSubviews(blurVisibilityEffectView, visibilityLabel, visibilityOverlayButton)
        visibilityButton.setTitle(NSLocalizedString("Visibility / weather", comment: ""), for: .normal)
        visibilityButton.setTitleColor(.white, for: .normal)
        visibilityButton.contentVerticalAlignment = textAligmentTop
        visibilityButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        visibilityButton.layer.masksToBounds = true
        visibilityButton.layer.cornerRadius = cornerRadius15
        visibilityOverlayButton.addTarget(self, action: #selector(visibilityOverlayButtonTapped), for: .touchUpInside)

        // VISIBILITY:

        visibilityLabel.textColor = .white
        visibilityLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        visibilityLabel.numberOfLines = 0
        visibilityLabel.textAlignment = .center
        visibilityLabel.adjustsFontSizeToFitWidth = true

        // MARK: PRESSURE BUTTON:

        let blurPressure = UIBlurEffect(style: .systemThinMaterialDark)
        let blurPressureEffectView = UIVisualEffectView(effect: blurPressure)
        blurPressureEffectView.frame = precipitationButton.bounds
        blurPressureEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pressureButton.addSubviews(blurPressureEffectView, pressureLabel, pressureOverlayButton)
        pressureButton.setTitle(NSLocalizedString("Pressure / weather", comment: ""), for: .normal)
        pressureButton.setTitleColor(.white, for: .normal)
        pressureButton.contentVerticalAlignment = textAligmentTop
        pressureButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        pressureButton.layer.masksToBounds = true
        pressureButton.layer.cornerRadius = cornerRadius15
        pressureOverlayButton.addTarget(self, action: #selector(pressureOverlayButtonTapped), for: .touchUpInside)

        // PRESSURE:

        pressureLabel.textColor = .white
        pressureLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        pressureLabel.numberOfLines = 0
        pressureLabel.textAlignment = .center
        pressureLabel.adjustsFontSizeToFitWidth = true

        // MARK: - UVINDEX BUTTON:

        let blurUvIndex = UIBlurEffect(style: .systemThinMaterialDark)
        let blurUvIndexEffectView = UIVisualEffectView(effect: blurUvIndex)
        blurUvIndexEffectView.frame = uvIndexButton.bounds
        blurUvIndexEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        uvIndexButton.addSubviews(blurUvIndexEffectView, uvIndexLabel, uvIndexOverlayButton)
        uvIndexButton.setTitle(NSLocalizedString("UvIndex / weather", comment: ""), for: .normal)
        uvIndexButton.setTitleColor(.white, for: .normal)
        uvIndexButton.contentVerticalAlignment = textAligmentTop
        uvIndexButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        uvIndexButton.layer.masksToBounds = true
        uvIndexButton.layer.cornerRadius = cornerRadius15
        uvIndexOverlayButton.addTarget(self, action: #selector(uvIndexOverlayButtonTapped), for: .touchUpInside)

        // UVINDEX:

        uvIndexLabel.textColor = .white
        uvIndexLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        uvIndexLabel.numberOfLines = 0
        uvIndexLabel.textAlignment = .center
        uvIndexLabel.adjustsFontSizeToFitWidth = true

        // MARK: - PRECIPITATION BUTTON:

        let blurPrecipitation = UIBlurEffect(style: .systemThinMaterialDark)
        let blurPrecipitationEffectView = UIVisualEffectView(effect: blurPrecipitation)
        blurPrecipitationEffectView.frame = precipitationButton.bounds
        blurPrecipitationEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        precipitationButton.addSubviews(blurPrecipitationEffectView, precipitationLabel, precipitationOverlayButton)
        precipitationButton.setTitle(NSLocalizedString("Precipitation / weather", comment: ""), for: .normal)
        precipitationButton.setTitleColor(.white, for: .normal)
        precipitationButton.contentVerticalAlignment = textAligmentTop
        precipitationButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        precipitationButton.layer.masksToBounds = true
        precipitationButton.layer.cornerRadius = cornerRadius15
        precipitationOverlayButton.addTarget(self, action: #selector(precipitationOverlayButtonTapped), for: .touchUpInside)

        // PRECIPITATION:

        precipitationLabel.textColor = .white
        precipitationLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        precipitationLabel.numberOfLines = 0
        precipitationLabel.textAlignment = .center
        precipitationLabel.adjustsFontSizeToFitWidth = true

        // MARK: - MAP VIEW:

        mapView.showsUserLocation = true
        mapView.layer.cornerRadius = cornerRadius15
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.isRotateEnabled = false
        let mapConfigurator = MKHybridMapConfiguration(elevationStyle: .realistic)
        mapView.preferredConfiguration = mapConfigurator

        // MARK: - ARROW IMAGE:

        arrowImage.image = UIImage(systemName: "arrowshape.down.fill", withConfiguration: configurationArrow)
        arrowImage.tintColor = .colorBlue

        // MARK: - INFO BUTTON:

        let infoImage = UIImage(systemName: "wind.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        windInfoButton.setImage(infoImage, for: .normal)
        windInfoButton.addTarget(self, action: #selector(windInfoButtonTapped), for: .touchUpInside)

        // MARK: - CURRENT LOCATION BUTTON:

        let locationImage = UIImage(systemName: "location.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        currentLocationButton.setImage(locationImage, for: .normal)
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }

    // MARK: - HELPERS:

    // MARK: SET START LOCATION:

    private func setStartLocation() {
        guard let cordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: cordinate,
                                                  latitudinalMeters: 250,
                                                  longitudinalMeters: 250)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: BUTTON CURRENT LOCATION:

    @objc private func currentLocationButtonTapped() {
        vibrationOn.vibrationStandart()
        guard let cordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: cordinate,
                                                  latitudinalMeters: 250,
                                                  longitudinalMeters: 250)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: INFO BUTTON:

    @objc private func windInfoButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapWindInfoButton()
    }

    // MARK: WIND BUTTON TAPPED:

    @objc private func windOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapWindOverlayButton()
    }

    // MARK: TEMPERATURE BUTTON TAPPED:

    @objc private func temperatureOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.taptemperatureOverlayButton()
    }

    // MARK: HUMIDITY BUTTON TAPPED:

    @objc private func humidityOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapHumidityOverlayButton()
    }

    // MARK: CLOUD COVER BUTTON TAPPED:

    @objc private func cloudCoverOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapCloudCoverOverlayButton()
    }

    // MARK: DEW POINT BUTTON TAPPED:

    @objc private func dewPointOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapDewPointOverlayButton()
    }

    // MARK: VISIBILITY BUTTON TAPPED:

    @objc private func visibilityOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapVisibilityOverlayButton()
    }

    // MARK: PRESSURE BUTTON TAPPED:

    @objc private func pressureOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapPressureOverlayButton()
    }

    // MARK: UV INDEX BUTTON TAPPED:

    @objc private func uvIndexOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapUvIndexOverlayButton()
    }

    // MARK: PRECIPITATION BUTTON TAPPED:

    @objc private func precipitationOverlayButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapPrecipitationOverlayButton()
    }

    // MARK: - CONFIGURE MODEL:

    func configure(iconImage: UIImage, description: String, currentTemperature: String, feelTemperature: String, cloudCover: String, humidity: String, dewPoint: String, precipitation: String, pressure: String, uvIndex: String, windSpeed: String, windGust: String, windDirection: String, visibility: String, rotationAngle: Int) {
        iconImageView.image = iconImage
        windSpeedLabel.text = windSpeed
        windGustLabel.text = windGust
        windDirectionLabel.text = windDirection
        currentTemperatureLabel.text = currentTemperature
        descriptionLabel.text = description
        feelTemperatureLabel.text = NSLocalizedString("It feels like / weather", comment: "") + " " + feelTemperature
        cloudCoverLabel.text = cloudCover
        humidityLabel.text = humidity
        dewPointLabel.text = dewPoint
        precipitationLabel.text = precipitation
        pressureLabel.text = pressure
        uvIndexLabel.text = uvIndex
        visibilityLabel.text = visibility
        arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle) * .pi / 180.0)
    }
}
