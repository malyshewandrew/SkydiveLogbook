import AudioToolbox
import AVFoundation
import Lottie
import RealmSwift
import UIKit

final class JumpCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let confettiLottie = LottieAnimationView(name: "MainConfetti")
    private let circleGreenLottie = LottieAnimationView(name: "CircleGreen")
    private let circleRedLottie = LottieAnimationView(name: "CircleRed")
    private let jubileeLottie = LottieAnimationView(name: "Anniversary")
    private let circleButton = UIButton()
    private let dateLabel = UILabel()
    private let locationButton = UIButton()
    private let locationLabel = UILabel()
    private let aircraftButton = UIButton()
    private let aircraftLabel = UILabel()
    private let canopyButton = UIButton()
    private let canopyLabel = UILabel()
    private let missionButton = UIButton()
    private let missionLabel = UILabel()
    private let heightButton = UIButton()
    private let heightLabel = UILabel()
    private let timeButton = UIButton()
    private let timeLabel = UILabel()
    private let commentButton = UIButton()
    private let commentLabel = UILabel()
    private let vibrationOn = Vibration()
    private var jubileeJumps = Set((100 ..< 10000).filter { $0 % 100 == 0 })
    private var isCutaway: Bool?
    private var isVibrating = false
    private var vibrationTimer: Timer?
    private var isAnimating = false

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

    private func addSubviews() {
        contentView.addSubviews(confettiLottie, circleGreenLottie, circleRedLottie, circleButton, dateLabel, locationButton, aircraftButton, canopyButton, missionButton, heightButton, timeButton, commentButton, jubileeLottie)
        locationButton.addSubview(locationLabel)
        aircraftButton.addSubview(aircraftLabel)
        canopyButton.addSubview(canopyLabel)
        missionButton.addSubview(missionLabel)
        heightButton.addSubviews(heightLabel)
        timeButton.addSubview(timeLabel)
        commentButton.addSubview(commentLabel)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: CONFETTI LOTTIE:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: circleButton.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: circleButton.centerYAnchor).isActive = true
        confettiLottie.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true

        // MARK: CIRCLE GREEN:

        circleGreenLottie.translatesAutoresizingMaskIntoConstraints = false
        circleGreenLottie.centerXAnchor.constraint(equalTo: circleButton.centerXAnchor, constant: -1).isActive = true
        circleGreenLottie.centerYAnchor.constraint(equalTo: circleButton.centerYAnchor, constant: 3).isActive = true
        circleGreenLottie.heightAnchor.constraint(equalToConstant: 400).isActive = true
        circleGreenLottie.widthAnchor.constraint(equalToConstant: 400).isActive = true

        // MARK: CIRCLE RED:

        circleRedLottie.translatesAutoresizingMaskIntoConstraints = false
        circleRedLottie.centerXAnchor.constraint(equalTo: circleButton.centerXAnchor, constant: 9).isActive = true
        circleRedLottie.centerYAnchor.constraint(equalTo: circleButton.centerYAnchor, constant: 5).isActive = true
        circleRedLottie.heightAnchor.constraint(equalToConstant: 550).isActive = true
        circleRedLottie.widthAnchor.constraint(equalToConstant: 550).isActive = true

        // MARK: CIRCLE BUTTON:

        circleButton.translatesAutoresizingMaskIntoConstraints = false
        circleButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
        circleButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        circleButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        circleButton.widthAnchor.constraint(equalToConstant: 150).isActive = true

        // MARK: DATE:

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: circleButton.bottomAnchor, constant: -15).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height40).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: circleButton.widthAnchor, multiplier: 0.7).isActive = true

        // MARK: ANNIEVERSARY LOTTIE:

        jubileeLottie.translatesAutoresizingMaskIntoConstraints = false
        jubileeLottie.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: 13).isActive = true
        jubileeLottie.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        jubileeLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        jubileeLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true

        // MARK: LOCATION:

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 55).isActive = true
        locationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        locationButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.centerXAnchor.constraint(equalTo: locationButton.centerXAnchor).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 0).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 0.6).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: locationButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: AIRCRAFT:

        aircraftButton.translatesAutoresizingMaskIntoConstraints = false
        aircraftButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 15).isActive = true
        aircraftButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        aircraftButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        aircraftButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        aircraftLabel.translatesAutoresizingMaskIntoConstraints = false
        aircraftLabel.centerXAnchor.constraint(equalTo: aircraftButton.centerXAnchor).isActive = true
        aircraftLabel.bottomAnchor.constraint(equalTo: aircraftButton.bottomAnchor, constant: 0).isActive = true
        aircraftLabel.heightAnchor.constraint(equalTo: aircraftButton.heightAnchor, multiplier: 0.6).isActive = true
        aircraftLabel.widthAnchor.constraint(equalTo: aircraftButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: CANOPY:

        canopyButton.translatesAutoresizingMaskIntoConstraints = false
        canopyButton.topAnchor.constraint(equalTo: aircraftButton.bottomAnchor, constant: 15).isActive = true
        canopyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        canopyButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        canopyButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        canopyLabel.translatesAutoresizingMaskIntoConstraints = false
        canopyLabel.centerXAnchor.constraint(equalTo: canopyButton.centerXAnchor).isActive = true
        canopyLabel.bottomAnchor.constraint(equalTo: canopyButton.bottomAnchor, constant: 0).isActive = true
        canopyLabel.heightAnchor.constraint(equalTo: canopyButton.heightAnchor, multiplier: 0.6).isActive = true
        canopyLabel.widthAnchor.constraint(equalTo: canopyButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: MISSION:

        missionButton.translatesAutoresizingMaskIntoConstraints = false
        missionButton.topAnchor.constraint(equalTo: canopyButton.bottomAnchor, constant: 15).isActive = true
        missionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        missionButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        missionButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        missionLabel.translatesAutoresizingMaskIntoConstraints = false
        missionLabel.centerXAnchor.constraint(equalTo: missionButton.centerXAnchor).isActive = true
        missionLabel.bottomAnchor.constraint(equalTo: missionButton.bottomAnchor, constant: 0).isActive = true
        missionLabel.heightAnchor.constraint(equalTo: missionButton.heightAnchor, multiplier: 0.6).isActive = true
        missionLabel.widthAnchor.constraint(equalTo: missionButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: HEIGHT:

        heightButton.translatesAutoresizingMaskIntoConstraints = false
        heightButton.topAnchor.constraint(equalTo: missionButton.bottomAnchor, constant: 15).isActive = true
        heightButton.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8).isActive = true
        heightButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        heightButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33).isActive = true

        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.leadingAnchor.constraint(equalTo: heightButton.leadingAnchor).isActive = true
        heightLabel.bottomAnchor.constraint(equalTo: heightButton.bottomAnchor, constant: 0).isActive = true
        heightLabel.heightAnchor.constraint(equalTo: heightButton.heightAnchor, multiplier: 0.6).isActive = true
        heightLabel.widthAnchor.constraint(equalTo: heightButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: TIME:

        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.topAnchor.constraint(equalTo: missionButton.bottomAnchor, constant: 15).isActive = true
        timeButton.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 8).isActive = true
        timeButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        timeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33).isActive = true

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: timeButton.leadingAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 0).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: timeButton.heightAnchor, multiplier: 0.6).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: timeButton.widthAnchor, multiplier: 1).isActive = true

        // MARK: COMMENT:

        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.topAnchor.constraint(equalTo: heightButton.bottomAnchor, constant: 15).isActive = true
        commentButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: height65).isActive = true
        commentButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7).isActive = true

        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.centerXAnchor.constraint(equalTo: commentButton.centerXAnchor).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: commentButton.bottomAnchor, constant: 0).isActive = true
        commentLabel.heightAnchor.constraint(equalTo: commentButton.heightAnchor, multiplier: 0.6).isActive = true
        commentLabel.widthAnchor.constraint(equalTo: commentButton.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        contentView.backgroundColor = .colorBackground
        selectionStyle = .none

        // MARK: ANIMATIONS:

        circleGreenLottie.isHidden = true
        circleGreenLottie.alpha = 0.0

        circleRedLottie.isHidden = true
        circleRedLottie.alpha = 0.0

        // MARK: NUMBER AND DATE:

        circleButton.layer.cornerRadius = 75
        circleButton.setTitleColor(.colorWhite, for: .normal)
        circleButton.backgroundColor = .colorCell
        circleButton.titleLabel?.font = .systemFont(ofSize: 60, weight: .bold, width: .standard)
        circleButton.titleLabel?.adjustsFontSizeToFitWidth = true

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(circleButtonLongPressed(_:)))
        circleButton.addGestureRecognizer(longPressGesture)

        if let titleLabel = circleButton.titleLabel {
            titleLabel.adjustsFontSizeToFitWidth = true
        }

        dateLabel.backgroundColor = .colorTabBar
        dateLabel.font = fontMediumStandard12
        dateLabel.textColor = .colorWhite
        dateLabel.layer.cornerRadius = 20
        dateLabel.textAlignment = textAligmentCenter
        dateLabel.layer.masksToBounds = true
        dateLabel.adjustsFontSizeToFitWidth = true

        // MARK: JUBILEE LOTTIE:

        jubileeLottie.isHidden = true

        // MARK: LOCATION:

        locationButton.backgroundColor = .colorCell
        locationButton.layer.cornerRadius = cornerRadius15
        locationButton.setTitle(NSLocalizedString("Location", comment: "") + ":", for: .normal)
        locationButton.titleLabel?.font = fontMediumStandard12
        locationButton.setTitleColor(.colorLightGray, for: .normal)
        locationButton.contentVerticalAlignment = textAligmentTop

        locationLabel.backgroundColor = .colorTabBar
        locationLabel.font = fontMediumStandard18
        locationLabel.textColor = .colorWhite
        locationLabel.textAlignment = textAligmentCenter
        locationLabel.layer.masksToBounds = true
        locationLabel.layer.cornerRadius = cornerRadius15 - 1
        locationLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        locationLabel.adjustsFontSizeToFitWidth = true

        // MARK: AIRCRAFT:

        aircraftButton.backgroundColor = .colorCell
        aircraftButton.layer.cornerRadius = cornerRadius15
        aircraftButton.setTitle(NSLocalizedString("Aircraft", comment: "") + ":", for: .normal)
        aircraftButton.titleLabel?.font = fontMediumStandard12
        aircraftButton.setTitleColor(.colorLightGray, for: .normal)
        aircraftButton.contentVerticalAlignment = textAligmentTop

        aircraftLabel.backgroundColor = .colorTabBar
        aircraftLabel.font = fontMediumStandard18
        aircraftLabel.textColor = .colorWhite
        aircraftLabel.textAlignment = textAligmentCenter
        aircraftLabel.layer.masksToBounds = true
        aircraftLabel.layer.cornerRadius = cornerRadius15 - 1
        aircraftLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aircraftLabel.adjustsFontSizeToFitWidth = true

        // MARK: CANOPY:

        canopyButton.backgroundColor = .colorCell
        canopyButton.layer.cornerRadius = cornerRadius15
        canopyButton.setTitle(NSLocalizedString("Canopy", comment: "") + ":", for: .normal)
        canopyButton.titleLabel?.font = fontMediumStandard12
        canopyButton.setTitleColor(.colorLightGray, for: .normal)
        canopyButton.contentVerticalAlignment = textAligmentTop

        canopyLabel.backgroundColor = .colorTabBar
        canopyLabel.font = fontMediumStandard18
        canopyLabel.textColor = .colorWhite
        canopyLabel.textAlignment = textAligmentCenter
        canopyLabel.layer.masksToBounds = true
        canopyLabel.layer.cornerRadius = cornerRadius15 - 1
        canopyLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        canopyLabel.adjustsFontSizeToFitWidth = true

        // MARK: MISSION:

        missionButton.backgroundColor = .colorCell
        missionButton.layer.cornerRadius = cornerRadius15
        missionButton.setTitle(NSLocalizedString("Mission", comment: "") + ":", for: .normal)
        missionButton.titleLabel?.font = fontMediumStandard12
        missionButton.setTitleColor(.colorLightGray, for: .normal)
        missionButton.contentVerticalAlignment = textAligmentTop

        missionLabel.backgroundColor = .colorTabBar
        missionLabel.font = fontMediumStandard18
        missionLabel.textColor = .colorWhite
        missionLabel.textAlignment = textAligmentCenter
        missionLabel.layer.masksToBounds = true
        missionLabel.layer.cornerRadius = cornerRadius15 - 1
        missionLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        missionLabel.adjustsFontSizeToFitWidth = true

        // MARK: HEIGHT:

        heightButton.backgroundColor = .colorCell
        heightButton.layer.cornerRadius = cornerRadius15
        heightButton.setTitle(NSLocalizedString("Height", comment: "") + ":", for: .normal)
        heightButton.titleLabel?.font = fontMediumStandard12
        heightButton.setTitleColor(.colorLightGray, for: .normal)
        heightButton.contentVerticalAlignment = textAligmentTop

        heightLabel.backgroundColor = .colorTabBar
        heightLabel.font = fontMediumStandard18
        heightLabel.textColor = .colorWhite
        heightLabel.textAlignment = textAligmentCenter
        heightLabel.layer.masksToBounds = true
        heightLabel.layer.cornerRadius = cornerRadius15 - 1
        heightLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        heightLabel.adjustsFontSizeToFitWidth = true

        // MARK: TIME:

        timeButton.backgroundColor = .colorCell
        timeButton.layer.cornerRadius = cornerRadius15
        timeButton.setTitle(NSLocalizedString("Time", comment: "") + ":", for: .normal)
        timeButton.titleLabel?.font = fontMediumStandard12
        timeButton.setTitleColor(.colorLightGray, for: .normal)
        timeButton.contentVerticalAlignment = textAligmentTop

        timeLabel.backgroundColor = .colorTabBar
        timeLabel.font = fontMediumStandard18
        timeLabel.textColor = .colorWhite
        timeLabel.textAlignment = textAligmentCenter
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = cornerRadius15 - 1
        timeLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        timeLabel.adjustsFontSizeToFitWidth = true

        // MARK: COMMENT:

        commentButton.backgroundColor = .colorCell
        commentButton.layer.cornerRadius = cornerRadius15
        commentButton.setTitle(NSLocalizedString("Comment", comment: "") + ":", for: .normal)
        commentButton.titleLabel?.font = fontMediumStandard12
        commentButton.setTitleColor(.colorLightGray, for: .normal)
        commentButton.contentVerticalAlignment = textAligmentTop

        commentLabel.backgroundColor = .colorTabBar
        commentLabel.font = fontMediumStandard18
        commentLabel.textColor = .colorWhite
        commentLabel.textAlignment = textAligmentCenter
        commentLabel.layer.masksToBounds = true
        commentLabel.layer.cornerRadius = cornerRadius15 - 1
        commentLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        commentLabel.adjustsFontSizeToFitWidth = true
    }

    // MARK: - HELPERS:

    // MARK: CONFIGURE MODEL:

    func configure(number: String, date: String, location: String, aircraft: String, canopy: String, mission: String, height: String, time: String, cutaway: String, comment: String) {
        circleButton.setTitle(number, for: .normal)
        dateLabel.text = date
        locationLabel.text = location
        aircraftLabel.text = aircraft
        canopyLabel.text = canopy
        missionLabel.text = mission
        heightLabel.text = height
        timeLabel.text = time
        commentLabel.text = comment
        if commentLabel.text == "" {
            commentButton.isHidden = true
            heightButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        } else {
            commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        }

        // MARK: COLOR FOR CIRCLE (GREEN / RED):

        if cutaway == NSLocalizedString("Yes", comment: "") {
            circleButton.layer.shadowRadius = 25
            circleButton.layer.shadowColor = UIColor.colorDarkRed.cgColor
            circleButton.layer.shadowOpacity = 0.5
            circleButton.layer.add(setShadowAnimation(), forKey: "shadowOffsetAnimation")
            isCutaway = true
        } else {
            circleButton.layer.shadowRadius = 25
            circleButton.layer.shadowColor = UIColor.colorGreen.cgColor
            circleButton.layer.shadowOpacity = 0.7
            circleButton.layer.add(setShadowAnimation(), forKey: "shadowOffsetAnimation")
            isCutaway = false
        }
    }

    // MARK: JUBILEE JUMPS LOTTIE:

    func jubileeShow(number: Int) {
        jubileeJumps.insert(10000)
        if jubileeJumps.contains(number) {
            jubileeLottie.isHidden = false
            jubileeLottie.play()
            jubileeLottie.loopMode = .loop
            confettiLottie.layer.shadowRadius = 10
            confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
            confettiLottie.layer.shadowOpacity = 1
            circleButton.setTitleColor(.colorCell, for: .normal)
            circleButton.backgroundColor = .colorJubilee
            locationButton.backgroundColor = .colorJubilee
            aircraftButton.backgroundColor = .colorJubilee
            canopyButton.backgroundColor = .colorJubilee
            missionButton.backgroundColor = .colorJubilee
            heightButton.backgroundColor = .colorJubilee
            timeButton.backgroundColor = .colorJubilee
            commentButton.backgroundColor = .colorJubilee
        }
    }

    // MARK: FUNC FOR TAP ON CIRCLE BUTTON:

    @objc private func circleButtonLongPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            startVibrationAndAnimation()
        } else if gesture.state == .ended {
            stopVibrationAndAnimation()
        }
    }

    private func startVibrationAndAnimation() {
        startVibration()
        startAnimation()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            if self.isVibrating && self.isAnimating {
                self.circleAnimationButtonTapped()
            } else {
                self.stopVibration()
                self.stopAnimation()
            }
        }
    }

    private func stopVibrationAndAnimation() {
        stopVibration()
        stopAnimation()
    }

    @objc private func circleAnimationButtonTapped() {
        if isCutaway == true {
            confettiLottie.play()
            confettiLottie.layer.shadowRadius = 10
            confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
            confettiLottie.layer.shadowOpacity = 1
            circleRedLottie.isHidden = false
            circleRedLottie.play()
            circleRedLottie.loopMode = .playOnce
            circleRedLottie.animationSpeed = 0.7
            vibrationOn.vibrationSucces()
            UIView.animate(withDuration: 2.0, animations: {
                self.circleRedLottie.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 2.0) {
                    self.circleRedLottie.alpha = 0.0
                }
            }
        } else {
            confettiLottie.play()
            confettiLottie.layer.shadowRadius = 10
            confettiLottie.layer.shadowColor = UIColor.colorLightBlue.cgColor
            confettiLottie.layer.shadowOpacity = 1
            circleGreenLottie.isHidden = false
            circleGreenLottie.play()
            circleGreenLottie.loopMode = .playOnce
            circleGreenLottie.animationSpeed = 0.5
            vibrationOn.vibrationSucces()
            UIView.animate(withDuration: 2.0, animations: {
                self.circleGreenLottie.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 2.0) {
                    self.circleGreenLottie.alpha = 0.0
                }
            }
        }
    }

    private func startVibration() {
        isVibrating = true
        vibrationTimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(vibrationSpeed), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopVibration()
        }
    }

    @objc private func stopVibration() {
        isVibrating = false
        vibrationTimer?.invalidate()
        vibrationTimer = nil
    }

    private func startAnimation() {
        isAnimating = true
        UIView.animate(withDuration: 0.04, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.circleButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.circleButton.alpha = 0.5
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopAnimation()
        }
    }

    private func stopAnimation() {
        isAnimating = false
        circleButton.layer.removeAllAnimations()
        circleButton.alpha = 1.0
        circleButton.transform = CGAffineTransform(scaleX: 1, y: 1)
    }

    @objc private func vibrationSpeed() {
        vibrationOn.vibrationImpactFeedbackGenerator.impactOccurred()
    }

    // MARK: - SET ANIMATION FOR SHADOW:

    private func setShadowAnimation() -> CAAnimationGroup {
        let horizontalAnimation = CAKeyframeAnimation(keyPath: "shadowOffset.width")
        horizontalAnimation.values = [0, CGFloat.random(in: -15...15), CGFloat.random(in: -15...15), 0]
        horizontalAnimation.keyTimes = [0, 0.25, 0.75, 1]
        horizontalAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        let verticalAnimation = CAKeyframeAnimation(keyPath: "shadowOffset.height")
        verticalAnimation.values = [0, CGFloat.random(in: -15...15), CGFloat.random(in: -15...15), 0]
        verticalAnimation.keyTimes = [0, 0.25, 0.75, 1]
        verticalAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)]
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [horizontalAnimation, verticalAnimation]
        groupAnimation.duration = 10
        groupAnimation.autoreverses = true
        groupAnimation.repeatCount = .infinity
        return groupAnimation
    }
}
