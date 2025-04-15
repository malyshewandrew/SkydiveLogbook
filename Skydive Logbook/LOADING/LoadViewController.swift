import Lottie
import UIKit
import ShimmerSwift

final class LoadViewController: UIViewController {
    // MARK: - PROPERTIES:

    private let loadingView = UIView()
    private let loadingBackgroundLottie = LottieAnimationView(name: "LoadingBackgroundLottie")
    private let loadingInfoLabel = UILabel()
    private let loadingLottie = LottieAnimationView(name: "Loading")
    private let helloLottie = LottieAnimationView(name: "Hello")
    private var vibrationTimer: Timer?
    private let shimmerView = ShimmeringView()

    // MARK: - LIFYCYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        startVibrationTimer()
        addSubviews()
        configureConstraints()
        configureUI()
        perform(#selector(hideAnimation), with: nil, afterDelay: 2.5)
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(loadingView)
        loadingView.addSubviews(loadingBackgroundLottie, shimmerView, loadingInfoLabel, helloLottie, loadingLottie)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: LOADING VIEW:

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // MARK: LOADING BACKGROUND LOTTIE:

        loadingBackgroundLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingBackgroundLottie.topAnchor.constraint(equalTo: loadingView.topAnchor).isActive = true
        loadingBackgroundLottie.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor).isActive = true
        loadingBackgroundLottie.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor).isActive = true
        loadingBackgroundLottie.trailingAnchor.constraint(equalTo: loadingView.leadingAnchor).isActive = true

        // MARK: LOADING INFO LABEL:

        loadingInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingInfoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        loadingInfoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true

        // MARK: LOADING LOTTIE:

        loadingLottie.translatesAutoresizingMaskIntoConstraints = false
        loadingLottie.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loadingLottie.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: -50).isActive = true
        loadingLottie.widthAnchor.constraint(equalTo: loadingView.widthAnchor, multiplier: 0.4).isActive = true
        loadingLottie.heightAnchor.constraint(equalTo: loadingLottie.widthAnchor, multiplier: 1).isActive = true

        // MARK: HELLO LOTTIE:

        helloLottie.translatesAutoresizingMaskIntoConstraints = false
        helloLottie.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        helloLottie.topAnchor.constraint(equalTo: loadingLottie.centerYAnchor, constant: 50).isActive = true
        helloLottie.widthAnchor.constraint(equalTo: loadingView.widthAnchor, multiplier: 0.6).isActive = true
        helloLottie.heightAnchor.constraint(equalTo: helloLottie.widthAnchor, multiplier: 0.5).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: LOADING VIEW:

        loadingView.backgroundColor = .colorBackground

        // MARK: LOADING BACKGROUND LOTTIE:

        loadingBackgroundLottie.loopMode = .loop
        loadingBackgroundLottie.contentMode = .scaleAspectFill
        loadingBackgroundLottie.play()

        // MARK: INFO LABEL:

        let currentYear = Calendar.current.component(.year, from: Date())
        print(currentYear)
        loadingInfoLabel.numberOfLines = 0
        loadingInfoLabel.text = "Skydive Book iOS Application \n 2023-\(currentYear)"
        loadingInfoLabel.textColor = .colorWhite
        loadingInfoLabel.font = FontManager.regular(size: 8).uiFont
        loadingInfoLabel.textAlignment = .center
        ShimmerManager.instance.addShimmerEffect(shimmerView: shimmerView, toView: loadingInfoLabel, speed: 100)

        // MARK: LOADING LOTTIE:

        loadingLottie.play()
        loadingLottie.loopMode = .loop
        loadingLottie.contentMode = .scaleAspectFill

        // MARK: HELLO LOTTIE:

        helloLottie.play()
        helloLottie.loopMode = .playOnce
        helloLottie.contentMode = .scaleAspectFit
    }

    // MARK: - HELPERS:

    // HIDE ANIMATION:
    @objc private func hideAnimation() {
        UIView.animate(withDuration: 0, animations: { [weak self] in
            guard let self = self else { return }
            let tabBarController = TabBarController()
            tabBarController.modalTransitionStyle = .crossDissolve
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true)
            stopVibrationTimer()
        })
    }

    // MARK: START VIBRATION TIMER:

    func startVibrationTimer() {
        if vibrationTimer == nil {
            vibrationTimer = Timer.scheduledTimer(withTimeInterval: 0.35, repeats: true) { _ in
                VibrationManager.instance.vibrationLight()
            }
        }
    }

    // MARK: STOP VIBRATION TIMER:

    func stopVibrationTimer() {
        if let timer = vibrationTimer {
            timer.invalidate()
            vibrationTimer = nil
        }
    }
}
