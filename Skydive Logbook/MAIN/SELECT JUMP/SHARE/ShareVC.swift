import AlertKit
import Lottie
import Photos
import PhotosUI
import ShimmerSwift
import UIKit

final class ShareVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let backgroundImageView = UIImageView()
    private let photoLottie = LottieAnimationView(name: "PhotoLottie")
    private let photoLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let titleShimmer = ShimmeringView()
    private let imageView = UIImageView()
    private let columnWell = UIColorWell()
    private let fontSizeSlider = UISlider()
    private let logoWell = UIColorWell()
    private let selectButton = UIButton(type: .system)
    private var selectedImage: [UIImage] = []
    private let selectNewButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private var columnColor: UIColor?
    private var logoColor: UIColor?
    
    private let leftHeightSlider = UISlider()
    private let rightHeightSlider = UISlider()
    private var leftHeightValue: CGFloat = 5
    private var rightHeightValue: CGFloat = 5
    private var fontSizeValue: CGFloat = 8
    
    
    var number: String?
    var date: String?
    var location: String?
    var aircraft: String?
    var canopy: String?
    var mission: String?
    var height: String?
    var time: String?
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(backgroundImageView, photoLottie, photoLabel, titleLabel, descriptionLabel, titleShimmer, imageView, columnWell, fontSizeSlider, logoWell, selectButton, selectNewButton, saveButton, leftHeightSlider, rightHeightSlider)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: BACKGROUND IMAGE VIEW:
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // MARK: PHOTO LOTTIE:
        
        photoLottie.translatesAutoresizingMaskIntoConstraints = false
        photoLottie.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor, constant: -1.2).isActive = true
        photoLottie.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        photoLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        photoLottie.heightAnchor.constraint(equalTo: photoLottie.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: PHOTO LABEL:
        
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        photoLabel.centerXAnchor.constraint(equalTo: photoLottie.centerXAnchor).isActive = true
        photoLabel.centerYAnchor.constraint(equalTo: photoLottie.centerYAnchor).isActive = true
        photoLabel.widthAnchor.constraint(equalTo: photoLottie.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: TITLE LABEL:
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        
        // MARK: DESCRIPTION LABEL:
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: IMAGE VIEW:
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -125).isActive = true
        
        // MARK: COLOR WELL:
        
        columnWell.translatesAutoresizingMaskIntoConstraints = false
        columnWell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        columnWell.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        
        // MARK: FONT SIZE SLIDER:
        
        fontSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        fontSizeSlider.centerYAnchor.constraint(equalTo: columnWell.centerYAnchor).isActive = true
        fontSizeSlider.leadingAnchor.constraint(equalTo: columnWell.trailingAnchor, constant: 25).isActive = true
        fontSizeSlider.trailingAnchor.constraint(equalTo: logoWell.leadingAnchor, constant: -25).isActive = true
        
        // MARK: LOGO WELL:
        
        logoWell.translatesAutoresizingMaskIntoConstraints = false
        logoWell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        logoWell.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15).isActive = true
        
        // MARK: SELECT BUTTON:
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.topAnchor.constraint(equalTo: photoLottie.topAnchor).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: photoLottie.leadingAnchor).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: photoLottie.trailingAnchor).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: photoLottie.bottomAnchor).isActive = true
        
        // MARK: SELECT NEW BUTTON:
        
        selectNewButton.translatesAutoresizingMaskIntoConstraints = false
        selectNewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        selectNewButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -25).isActive = true
        selectNewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        selectNewButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        
        // MARK: SAVE BUTTON:
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 25).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        
        // MARK: LEFT HEIGHT SLIDER:
        
        leftHeightSlider.translatesAutoresizingMaskIntoConstraints = false
        leftHeightSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftHeightSlider.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        leftHeightSlider.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
        
        // MARK: RIGTH HEIGHT SLIDER:
        
        rightHeightSlider.translatesAutoresizingMaskIntoConstraints = false
        rightHeightSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightHeightSlider.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        rightHeightSlider.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: BACKGROUND IMAGE VIEW:
        
        backgroundImageView.image = UIImage(resource: .backgroundPhoto)
        backgroundImageView.contentMode = .scaleAspectFill
        
        // MARK: PHOTO LOTTIE:
        
        photoLottie.play()
        photoLottie.loopMode = .loop
        photoLottie.animationSpeed = 0.75
        
        // MARK: PHOTO LABEL:
        
        photoLabel.text = NSLocalizedString("Select photo / share", comment: "")
        photoLabel.textColor = .white
        photoLabel.font = FontManager.black(size: 12).uiFont
        photoLabel.textAlignment = .center
        photoLabel.adjustsFontSizeToFitWidth = true
        photoLabel.numberOfLines = 0
        
        // MARK: TITLE LABEL:
        
        titleLabel.text = NSLocalizedString("Create a story with a jump / share", comment: "")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = FontManager.bold(size: 36).uiFont
        ShimmerManager.instance.addShimmerEffect(shimmerView: titleShimmer, toView: titleLabel, speed: 100)
        
        // MARK: DESCRIPTION LABEL:
        
        descriptionLabel.text = NSLocalizedString("Create a story with jump data and share it on social media / share", comment: "")
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        descriptionLabel.font = FontManager.regular(size: 12).uiFont
        
        // MARK: IMAGE VIEW:
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        // MARK: COLOR WELL:
        
        columnWell.selectedColor = .white
        columnWell.supportsAlpha = false
        columnWell.selectedColor = .white
        columnWell.isHidden = true
        columnWell.addTarget(self, action: #selector(columnWellChanged), for: .valueChanged)
        
        // MARK: FONT SIZE SLIDER:
        
        fontSizeSlider.isHidden = true
        fontSizeSlider.minimumValue = 8
        fontSizeSlider.maximumValue = 16
        fontSizeSlider.addTarget(self, action: #selector(fontSizeSliderValueChanged), for: .valueChanged)
        
        // MARK: LOGO WELL:
        
        logoWell.selectedColor = .white
        logoWell.supportsAlpha = false
        logoWell.selectedColor = .white
        logoWell.isHidden = true
        logoWell.addTarget(self, action: #selector(logoWellChanged), for: .valueChanged)
        
        // MARK: SELECT BUTTON:
        
        selectButton.addTarget(self, action: #selector(photosButtonTapped), for: .touchUpInside)
        
        // MARK: SELECT NEW BUTTON:
        
        selectNewButton.setTitle(NSLocalizedString("  Select photo / share", comment: ""), for: .normal)
        selectNewButton.titleLabel?.adjustsFontSizeToFitWidth = true
        selectNewButton.setImage(UIImage(systemName: "photo.circle.fill")?.withTintColor(.colorLightGray, renderingMode: .alwaysOriginal), for: .normal)
        selectNewButton.backgroundColor = .colorCell
        selectNewButton.setTitleColor(.colorLightGray, for: .normal)
        selectNewButton.setTitleColor(.systemBlue, for: .highlighted)
        selectNewButton.titleLabel?.font = FontManager.medium(size: 12).uiFont
        selectNewButton.layer.cornerRadius = cornerRadius15
        selectNewButton.addTarget(self, action: #selector(photosButtonTapped), for: .touchUpInside)
        selectNewButton.layer.opacity = 0
        
        // MARK: SAVE BUTTON:
        
        saveButton.setTitle(NSLocalizedString("  Save photo / share", comment: ""), for: .normal)
        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        saveButton.setImage(UIImage(systemName: "square.and.arrow.down.fill")?.withTintColor(.colorLightGray, renderingMode: .alwaysOriginal), for: .normal)
        saveButton.backgroundColor = .colorCell
        saveButton.setTitleColor(.colorLightGray, for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .highlighted)
        saveButton.titleLabel?.font = FontManager.medium(size: 12).uiFont
        saveButton.layer.cornerRadius = cornerRadius15
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.layer.opacity = 0
        
        // MARK: LEFT HEIGHT SLIDER:
        
        leftHeightSlider.layer.opacity = 0.5
        leftHeightSlider.isHidden = true
        leftHeightSlider.minimumValue = -200
        leftHeightSlider.maximumValue = 200
        leftHeightSlider.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        leftHeightSlider.addTarget(self, action: #selector(leftHeightSliderValueChanged), for: .valueChanged)
        
        // MARK: RIGTH HEIGHT SLIDER:
        
        rightHeightSlider.layer.opacity = 0.5
        rightHeightSlider.isHidden = true
        rightHeightSlider.minimumValue = -200
        rightHeightSlider.maximumValue = 200
        rightHeightSlider.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        rightHeightSlider.addTarget(self, action: #selector(rightHeightSliderValueChanged), for: .valueChanged)
    }
    
    // MARK: - HELPERS:
    
    // MARK: SEND REQUES:
    
    @objc private func sendRequest() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.openPhotoGallery()
                }
            case .denied, .restricted:
                DispatchQueue.main.async {
                    AlertKitManager.instance.alertKit(title: NSLocalizedString("Get access in settings / share", comment: ""), icon: .error, style: .iOS17AppleMusic, haptic: .error)
                }
            case .notDetermined:
                DispatchQueue.main.async {
                    AlertKitManager.instance.alertKit(title: NSLocalizedString("Get access in settings / share", comment: ""), icon: .error, style: .iOS17AppleMusic, haptic: .error)
                }
            case .limited:
                DispatchQueue.main.async {
                    AlertKitManager.instance.alertKit(title: NSLocalizedString("Get access in settings / share", comment: ""), icon: .error, style: .iOS17AppleMusic, haptic: .error)
                }
            @unknown default:
                fatalError("Неизвестный статус.")
            }
        }
    }
    
    // MARK: SELECT PHOTOS TAPPED:

    @objc private func photosButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        sendRequest()
    }
    
    // MARK: OPEN PHOTO GALERY:

    private func openPhotoGallery() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: UPDATE CONSTRAINTS:
    
    private func updateConstraints() {
        view.constraints.forEach { constraint in
            if constraint.firstItem as? UIView == selectButton || constraint.secondItem as? UIView == selectButton {
                view.removeConstraint(constraint)
            }
        }

        // MARK: SELECT BUTTON:
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -25).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
    }
    
    // MARK: SAVE PHOTO TAPPED:
    
    @objc private func saveButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        UIImageWriteToSavedPhotosAlbum(imageView.image ?? UIImage(), self, #selector(imageSaveCompleted(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // MARK: APPLY EFFECT:
    private func applyEffect() {
        imageView.image = nil
        imageView.image = selectedImage.first
        guard let logo = UIImage(named: "AppIconVersion") else { return }

        let renderer = UIGraphicsImageRenderer(bounds: imageView.bounds)
        let finalImage = renderer.image { [weak self] context in
            guard let self = self else { return }
            imageView.layer.render(in: context.cgContext)
            
            let columnAttributes: [NSAttributedString.Key: Any] = [
                .font: FontManager.regular(size: fontSizeValue).uiFont,
                .foregroundColor: columnColor ?? UIColor.white
            ]
            let logoAttributes: [NSAttributedString.Key: Any] = [
                .font: FontManager.regular(size: 8).uiFont,
                .foregroundColor: logoColor ?? UIColor.white
            ]

            let leftColomn = ["# " + (number ?? ""), date, location, aircraft]
            let rightColomn = [canopy, mission, (height ?? "") + NSLocalizedString("m.", comment: ""), (time ?? "") + NSLocalizedString("s.", comment: "")]

            let calculateTotalHeight: ([Any]) -> CGFloat = { textArray in
                textArray.reduce(0) { total, line in
                    total + ((line as? NSString)?.size(withAttributes: columnAttributes).height ?? 0) + 5
                }
            }
            let totalTextHeight = max(calculateTotalHeight(leftColomn as [Any]), calculateTotalHeight(rightColomn as [Any]))
            let startY = (imageView.bounds.height - totalTextHeight) / 2

            func drawLeftColomn(_ textArray: [Any], startX: CGFloat, alignment: NSTextAlignment) {
                var yOffset = startY + leftHeightValue
                for line in textArray {
                    guard let lineString = line as? NSString else { continue }
                    let lineSize = lineString.size(withAttributes: columnAttributes)
                    let x = alignment == .left ? startX : (startX - lineSize.width)
                    lineString.draw(at: CGPoint(x: x, y: yOffset), withAttributes: columnAttributes)
                    yOffset += lineSize.height + 5
                }
            }
            
            func drawRightColomn(_ textArray: [Any], startX: CGFloat, alignment: NSTextAlignment) {
                var yOffset = startY + rightHeightValue
                for line in textArray {
                    guard let lineString = line as? NSString else { continue }
                    let lineSize = lineString.size(withAttributes: columnAttributes)
                    let x = alignment == .left ? startX : (startX - lineSize.width)
                    lineString.draw(at: CGPoint(x: x, y: yOffset), withAttributes: columnAttributes)
                    yOffset += lineSize.height + 5
                }
            }

            drawLeftColomn(leftColomn as [Any], startX: 25, alignment: .left)
            drawRightColomn(rightColomn as [Any], startX: imageView.bounds.width - 25, alignment: .right)

            let logokWidth = imageView.bounds.width * 0.1
            let logoHeight = logokWidth * logo.size.height / logo.size.width
            let logoOrigin = CGPoint(x: (imageView.bounds.width - logokWidth) / 2, y: imageView.bounds.height - logoHeight - 50)
            let logoRect = CGRect(origin: logoOrigin, size: CGSize(width: logokWidth, height: logoHeight))
            logo.draw(in: logoRect, blendMode: .normal, alpha: 0.8)


            let logoText = "iOS App \"Skydive Book\""
            let logoTextSize = (logoText as NSString).size(withAttributes: logoAttributes)
            let logoTextOrigin = CGPoint(x: (imageView.bounds.width - logoTextSize.width) / 2, y: logoRect.maxY + 5)
            (logoText as NSString).draw(at: logoTextOrigin, withAttributes: logoAttributes)
        }
        imageView.image = finalImage
    }


    // MARK: COMPLETION HANDLER AFTER SAVE:

    @objc private func imageSaveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            AlertKitManager.instance.alertKit(title: NSLocalizedString("Failed to save image / share", comment: ""), icon: .error, style: .iOS17AppleMusic, haptic: .error)
            print("Error saving image: \(error.localizedDescription)")
        } else {
            AlertKitManager.instance.alertKit(title: NSLocalizedString("Image saved successfully / share", comment: ""), icon: .done, style: .iOS17AppleMusic, haptic: .success)
        }
    }
    
    // MARK: COLUMN WELL CHANGED:
    
    @objc private func columnWellChanged() {
        VibrationManager.instance.vibrationStandart()
        guard let selectedColor = columnWell.selectedColor else { return }
        columnColor = selectedColor
        applyEffect()
    }
    
    // MARK: LOGO WELL CHANGED:
    
    @objc private func logoWellChanged() {
        VibrationManager.instance.vibrationStandart()
        guard let selectedImage = logoWell.selectedColor else { return }
        logoColor = selectedImage
        applyEffect()
    }
    
    // MARK: CONFIGURE:
    
    func configure(number: String, date: String, location: String, aircraft: String, canopy: String, misson: String, height: String, time: String) {
        self.number = number
        self.date = date
        self.location = location
        self.aircraft = aircraft
        self.canopy = canopy
        self.mission = misson
        self.height = height
        self.time = time
    }
    
    // MARK: LEFT HEIGHT SLIDER VALUE CHANGED:
    
    @objc private func leftHeightSliderValueChanged(_ sender: UISlider) {
        VibrationManager.instance.vibrationLight()
        leftHeightValue = CGFloat(sender.value)
        applyEffect()
    }
    
    // MARK: RIGHT HEIGHT SLIDER VALUE CHANGED:
    
    @objc private func rightHeightSliderValueChanged(_ sender: UISlider) {
        VibrationManager.instance.vibrationLight()
        rightHeightValue = CGFloat(sender.value)
        applyEffect()
    }
    
    // MARK: FONT SIZE VALUE CHANGED:
    
    @objc private func fontSizeSliderValueChanged(_ sender: UISlider) {
        VibrationManager.instance.vibrationLight()
        fontSizeValue = CGFloat(sender.value)
        applyEffect()
    }
}

// MARK: - EXTENSIONS:

extension ShareVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        guard !results.isEmpty else {
            AlertKitManager.instance.alertKit(title: NSLocalizedString("No photos selected / share", comment: ""), icon: .error, style: .iOS17AppleMusic, haptic: .error)
            return
        }
        selectedImage.removeAll()
            
        let dispatchGroup = DispatchGroup()

        for result in results {
            dispatchGroup.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                defer { dispatchGroup.leave() }
                if let image = object as? UIImage {
                    self?.selectedImage.append(image)
                }
            }
        }
            
        dispatchGroup.notify(queue: .main) {
            self.imageView.image = self.selectedImage.first
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                self.updateConstraints()
                self.selectNewButton.layer.opacity = 1
                self.saveButton.layer.opacity = 1
                self.titleLabel.isHidden = true
                self.descriptionLabel.isHidden = true
                self.columnWell.isHidden = false
                self.fontSizeSlider.isHidden = false
                self.logoWell.isHidden = false
                self.photoLottie.isHidden = true
                self.photoLabel.isHidden = true
                self.leftHeightSlider.isHidden = false
                self.rightHeightSlider.isHidden = false
                self.view.layoutIfNeeded()
            }
            self.applyEffect()
        }
    }
}
