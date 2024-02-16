
import MapKit
import UIKit

protocol WeatherCellDelegate {
    func tapInfoButton()
}

class WeatherCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let iconImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
    private let feelTemperatureLabel = UILabel()

    private let cloudCoverLabel = UILabel()
    private let humidityLabel = UILabel()
    private let dewPointLabel = UILabel()
    private let precipitationLabel = UILabel()
    private let pressureLabel = UILabel()

    private let windSpeedLabel = UILabel()
    private let windGustLabel = UILabel()
    private let windDirectionLabel = UILabel()

    private let visibilityLabel = UILabel()

    private let windButton = UIButton()
    private let temperatureButton = UIButton()
    private let cloudCoverButton = UIButton()
    private let humidityButton = UIButton()
    private let dewPointButton = UIButton()
    private let visibilityButton = UIButton()
    private let precipitationButton = UIButton()
    private let pressureButton = UIButton()

    private let vibrationOn = Vibration()
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let arrowImage = UIImageView()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 40)
    private let currentLocationButton = UIButton()
    private let infoButton = UIButton()
    var delegate: WeatherCellDelegate?

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubvies()
        configureConstraints()
        configureUI()
        currentLocationButtonTapped()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubvies() {
        contentView.addSubviews(windButton, temperatureButton, cloudCoverButton, humidityButton, dewPointButton, precipitationButton, visibilityButton, pressureButton, iconImageView, mapView)
        windButton.addSubviews(windSpeedLabel, windGustLabel, windDirectionLabel)
        temperatureButton.addSubviews(currentTemperatureLabel, descriptionLabel, feelTemperatureLabel)
        cloudCoverButton.addSubviews(cloudCoverLabel)
        humidityButton.addSubviews(humidityLabel)
        dewPointButton.addSubviews(dewPointLabel)
        precipitationButton.addSubviews(precipitationLabel)
        visibilityButton.addSubviews(visibilityLabel)
        pressureButton.addSubviews(pressureLabel)
        mapView.addSubviews(arrowImage, currentLocationButton, infoButton)
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
        windSpeedLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 1).isActive = true

        // WIND GUST:

        windGustLabel.translatesAutoresizingMaskIntoConstraints = false
        windGustLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windGustLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 5).isActive = true
        windGustLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 1).isActive = true

        // WIND DIRECTION:

        windDirectionLabel.translatesAutoresizingMaskIntoConstraints = false
        windDirectionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        windDirectionLabel.topAnchor.constraint(equalTo: windGustLabel.bottomAnchor, constant: 1).isActive = true
        windDirectionLabel.widthAnchor.constraint(equalTo: windButton.widthAnchor, multiplier: 1).isActive = true

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
        currentTemperatureLabel.widthAnchor.constraint(equalTo: temperatureButton.widthAnchor, multiplier: 1).isActive = true

        // DESCRIPTION:

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: temperatureButton.widthAnchor, multiplier: 1).isActive = true

        // FEEL TEMPERATURE:

        feelTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        feelTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        feelTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 1).isActive = true
        feelTemperatureLabel.widthAnchor.constraint(equalTo: temperatureButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: - HUMIDITY BUTTON:

        humidityButton.translatesAutoresizingMaskIntoConstraints = false
        humidityButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        humidityButton.trailingAnchor.constraint(equalTo: cloudCoverButton.leadingAnchor, constant: -10).isActive = true
        humidityButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        humidityButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.20).isActive = true

        // HUMIDITY:

        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.centerXAnchor.constraint(equalTo: humidityButton.centerXAnchor).isActive = true
        humidityLabel.topAnchor.constraint(equalTo: humidityButton.topAnchor, constant: 20).isActive = true
        humidityLabel.bottomAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: -5).isActive = true

        // MARK: - CLOUD COVER BUTTON:

        cloudCoverButton.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        cloudCoverButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5).isActive = true
        cloudCoverButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        cloudCoverButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.20).isActive = true

        // CLOUD COVER:

        cloudCoverLabel.translatesAutoresizingMaskIntoConstraints = false
        cloudCoverLabel.centerXAnchor.constraint(equalTo: cloudCoverButton.centerXAnchor).isActive = true
        cloudCoverLabel.topAnchor.constraint(equalTo: cloudCoverButton.topAnchor, constant: 20).isActive = true
        cloudCoverLabel.bottomAnchor.constraint(equalTo: cloudCoverButton.bottomAnchor, constant: -5).isActive = true

        // MARK: - DEW POINT BUTTON:

        dewPointButton.translatesAutoresizingMaskIntoConstraints = false
        dewPointButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        dewPointButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5).isActive = true
        dewPointButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        dewPointButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.20).isActive = true

        // DEW POINT:

        dewPointLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointLabel.centerXAnchor.constraint(equalTo: dewPointButton.centerXAnchor).isActive = true
        dewPointLabel.topAnchor.constraint(equalTo: dewPointButton.topAnchor, constant: 20).isActive = true
        dewPointLabel.bottomAnchor.constraint(equalTo: dewPointButton.bottomAnchor, constant: -5).isActive = true

        // MARK: - VISIBILITY BUTTON:

        visibilityButton.translatesAutoresizingMaskIntoConstraints = false
        visibilityButton.topAnchor.constraint(equalTo: temperatureButton.bottomAnchor, constant: 15).isActive = true
        visibilityButton.leadingAnchor.constraint(equalTo: dewPointButton.trailingAnchor, constant: 10).isActive = true
        visibilityButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        visibilityButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.20).isActive = true

        // VISIBILITY:

        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.centerXAnchor.constraint(equalTo: visibilityButton.centerXAnchor).isActive = true
        visibilityLabel.topAnchor.constraint(equalTo: visibilityButton.topAnchor, constant: 20).isActive = true
        visibilityLabel.bottomAnchor.constraint(equalTo: visibilityButton.bottomAnchor, constant: -5).isActive = true

        // MARK: - PRESSURE BUTTON:

        pressureButton.translatesAutoresizingMaskIntoConstraints = false
        pressureButton.topAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: 15).isActive = true
        pressureButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5).isActive = true
        pressureButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        pressureButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.43).isActive = true

        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.centerXAnchor.constraint(equalTo: pressureButton.centerXAnchor).isActive = true
        pressureLabel.topAnchor.constraint(equalTo: pressureButton.topAnchor, constant: 20).isActive = true
        pressureLabel.bottomAnchor.constraint(equalTo: pressureButton.bottomAnchor, constant: -5).isActive = true

        // MARK: - PRECIPITATION BUTTON:

        precipitationButton.translatesAutoresizingMaskIntoConstraints = false
        precipitationButton.topAnchor.constraint(equalTo: humidityButton.bottomAnchor, constant: 15).isActive = true
        precipitationButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5).isActive = true
        precipitationButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12).isActive = true
        precipitationButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.43).isActive = true

        // PRECIPITATION:

        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationLabel.centerXAnchor.constraint(equalTo: precipitationButton.centerXAnchor).isActive = true
        precipitationLabel.topAnchor.constraint(equalTo: precipitationButton.topAnchor, constant: 20).isActive = true
        precipitationLabel.bottomAnchor.constraint(equalTo: precipitationButton.bottomAnchor, constant: -5).isActive = true

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

        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.bottomAnchor.constraint(equalTo: currentLocationButton.topAnchor, constant: -20).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true

        // MARK: - ARROW IMAGE:

        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
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
        windButton.addSubview(blurWindEffectView)
        windButton.setTitle(NSLocalizedString("Wind speed / weather", comment: ""), for: .normal)
        windButton.setTitleColor(.white, for: .normal)
        windButton.contentVerticalAlignment = textAligmentTop
        windButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        windButton.layer.masksToBounds = true
        windButton.layer.cornerRadius = 15
        windButton.addSubviews(windSpeedLabel, windGustLabel, windDirectionLabel)

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
        temperatureButton.addSubview(blurTemperatureEffectView)
        temperatureButton.setTitle(NSLocalizedString("Temperature / weather", comment: ""), for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureButton.contentVerticalAlignment = textAligmentTop
        temperatureButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        temperatureButton.layer.masksToBounds = true
        temperatureButton.layer.cornerRadius = 15
        temperatureButton.addSubviews(currentTemperatureLabel, descriptionLabel, feelTemperatureLabel)

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
        humidityButton.addSubview(blurHumidityEffectView)
        humidityButton.setTitle(NSLocalizedString("Humidity / weather", comment: ""), for: .normal)
        humidityButton.setTitleColor(.white, for: .normal)
        humidityButton.contentVerticalAlignment = textAligmentTop
        humidityButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        humidityButton.layer.masksToBounds = true
        humidityButton.layer.cornerRadius = 15
        humidityButton.addSubviews(humidityLabel)

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
        cloudCoverButton.addSubview(blurCloudCoverEffectView)
        cloudCoverButton.setTitle(NSLocalizedString("Cloud cover / weather", comment: ""), for: .normal)
        cloudCoverButton.setTitleColor(.white, for: .normal)
        cloudCoverButton.contentVerticalAlignment = textAligmentTop
        cloudCoverButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        cloudCoverButton.layer.masksToBounds = true
        cloudCoverButton.layer.cornerRadius = 15
        cloudCoverButton.addSubviews(cloudCoverLabel)

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
        dewPointButton.addSubview(blurDewPointEffectView)
        dewPointButton.setTitle(NSLocalizedString("Dew point / weather", comment: ""), for: .normal)
        dewPointButton.setTitleColor(.white, for: .normal)
        dewPointButton.contentVerticalAlignment = textAligmentTop
        dewPointButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dewPointButton.layer.masksToBounds = true
        dewPointButton.layer.cornerRadius = 15
        dewPointButton.addSubviews(dewPointLabel)

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
        visibilityButton.addSubview(blurVisibilityEffectView)
        visibilityButton.setTitle(NSLocalizedString("Visibility / weather", comment: ""), for: .normal)
        visibilityButton.setTitleColor(.white, for: .normal)
        visibilityButton.contentVerticalAlignment = textAligmentTop
        visibilityButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        visibilityButton.layer.masksToBounds = true
        visibilityButton.layer.cornerRadius = 15
        visibilityButton.addSubviews(visibilityLabel)

        // VISIBILITY:

        visibilityLabel.textColor = .white
        visibilityLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        visibilityLabel.numberOfLines = 0
        visibilityLabel.textAlignment = .center
        visibilityLabel.adjustsFontSizeToFitWidth = true

        // MARK: - PRECIPITATION BUTTON:

        let blurPrecipitation = UIBlurEffect(style: .systemThinMaterialDark)
        let blurPrecipitationEffectView = UIVisualEffectView(effect: blurPrecipitation)
        blurPrecipitationEffectView.frame = precipitationButton.bounds
        blurPrecipitationEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        precipitationButton.addSubview(blurPrecipitationEffectView)
        precipitationButton.setTitle(NSLocalizedString("Precipitation / weather", comment: ""), for: .normal)
        precipitationButton.setTitleColor(.white, for: .normal)
        precipitationButton.contentVerticalAlignment = textAligmentTop
        precipitationButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        precipitationButton.layer.masksToBounds = true
        precipitationButton.layer.cornerRadius = 15
        precipitationButton.addSubviews(precipitationLabel)

        // PRECIPITATION:

        precipitationLabel.textColor = .white
        precipitationLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        precipitationLabel.numberOfLines = 0
        precipitationLabel.textAlignment = .center
        precipitationLabel.adjustsFontSizeToFitWidth = true

        // MARK: PRESSURE BUTTON:

        let blurPressure = UIBlurEffect(style: .systemThinMaterialDark)
        let blurPressureEffectView = UIVisualEffectView(effect: blurPressure)
        blurPressureEffectView.frame = precipitationButton.bounds
        blurPressureEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pressureButton.addSubview(blurPressureEffectView)
        pressureButton.setTitle(NSLocalizedString("Pressure / weather", comment: ""), for: .normal)
        pressureButton.setTitleColor(.white, for: .normal)
        pressureButton.contentVerticalAlignment = textAligmentTop
        pressureButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        pressureButton.layer.masksToBounds = true
        pressureButton.layer.cornerRadius = 15
        pressureButton.addSubviews(pressureLabel)

        // PRESSURE:

        pressureLabel.textColor = .white
        pressureLabel.font = .systemFont(ofSize: 30, weight: .regular, width: .standard)
        pressureLabel.numberOfLines = 0
        pressureLabel.textAlignment = .center
        pressureLabel.adjustsFontSizeToFitWidth = true

        // MARK: - MAP VIEW:

        mapView.showsUserLocation = true
        mapView.layer.cornerRadius = cornerRadius15
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.isRotateEnabled = false
        let mapConfigurator = MKHybridMapConfiguration(elevationStyle: .realistic)
        mapView.preferredConfiguration = mapConfigurator

        // MARK: - CURRENT LOCATION BUTTON:

        let locationImage = UIImage(systemName: "location.square.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        currentLocationButton.setImage(locationImage, for: .normal)
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)

        // MARK: - INFO BUTTON:

        let infoImage = UIImage(systemName: "info.square.fill", withConfiguration: configurationImage)?.withTintColor(.colorTabBar, renderingMode: .alwaysOriginal)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)

        // MARK: - ARROW IMAGE:

        arrowImage.image = UIImage(systemName: "arrowshape.down.fill", withConfiguration: configurationImage)
        arrowImage.tintColor = .colorLightBlue
    }

    // MARK: - HELPERS:

    // MARK: FUNC FOR CURRENT LOCATION:

    @objc private func currentLocationButtonTapped() {
        guard let cordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: cordinate,
                                                  latitudinalMeters: 250,
                                                  longitudinalMeters: 250)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: INFO BUTTON:

    @objc private func infoButtonTapped() {
        vibrationOn.vibrationStandart()
        delegate?.tapInfoButton()
    }

    // MARK: CONFIGURE MODEL:

    func configure(iconImage: UIImage, description: String, currentTemperature: String, feelTemperature: String, cloudCover: String, humidity: String, dewPoint: String, precipitation: String, pressure: String, windSpeed: String, windGust: String, windDirection: String, visibility: String, rotationAngle: Int) {
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
        visibilityLabel.text = visibility
        arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle) * .pi / 180.0)
    }
}
