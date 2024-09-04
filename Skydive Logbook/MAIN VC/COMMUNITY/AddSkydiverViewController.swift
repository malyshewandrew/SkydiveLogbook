import Adapty
import AlertKit
import AudioToolbox
import AVFoundation
import CountryPickerView
import Firebase
import FirebaseStorage
import Photos
import PhotosUI
import UIKit
import Network

final class AddSkydiverViewController: UIViewController {
    // MARK: - PROPERTIES:
    
    private let backgroundImage = UIImageView()
    private let arrayBackgroundImages: [UIImage] = [UIImage(resource: .backgroundSkydiversOne), UIImage(resource: .backgroundSkydiversTwo), UIImage(resource: .backgroundSkydiversThree)]
    private let scrollView = UIScrollView()
    
    private let nicknameButton = UIButton()
    private let nicknameTextField = UITextField()
    
    private let countryButton = UIButton()
    private let countryTextField = UITextField()
    private let countryPickerView = CountryPickerView()
    
    private let countOfJumpsButton = UIButton()
    private let countOfJumpsTextField = UITextField()
    
    private let professionButton = UIButton()
    private let professionTextField = UITextField()
    
    private let linkButton = UIButton()
    private let linkTextField = UITextField()
    
    private let photosButton = UIButton(type: .system)
    
    private let layout: UICollectionViewFlowLayout = {
        let obj = UICollectionViewFlowLayout()
        obj.scrollDirection = .horizontal
        let itemWidth = UIScreen.main.bounds.width / 6
        let itemHeight: CGFloat = 100
        obj.itemSize = CGSize(width: itemWidth, height: itemHeight)
        obj.minimumInteritemSpacing = 5
        obj.minimumLineSpacing = 5
        return obj
    }()

    private let collectionView: UICollectionView = {
        let obj = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        obj.backgroundColor = .clear
        obj.layer.masksToBounds = true
        obj.clipsToBounds = true
        obj.layer.cornerRadius = cornerRadius15
        return obj
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.isHidden = true
        progressView.progressTintColor = .colorGreen
        progressView.trackTintColor = .colorTabBar
        progressView.layer.cornerRadius = 3
        progressView.clipsToBounds = true
        return progressView
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let cleanButton = UIButton(type: .system)
    private let sendButton = UIButton(type: .system)
    
    private var selectedImages: [UIImage] = []
    private var nickName: String = ""
    
    private var player = AVAudioPlayer()
    private let vibrationOn = Vibration()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        addSubviews()
        configureConstraints()
        configureUI()
        configureGestures()
        nicknameTextField.delegate = self
        collectionView.dataSource = self
        countryPickerView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(backgroundImage, scrollView)
        scrollView.addSubviews(nicknameButton, nicknameTextField, countryButton, countryTextField, countOfJumpsButton, countOfJumpsTextField, professionButton, professionTextField, linkButton, linkTextField, photosButton, collectionView, progressView, cleanButton, sendButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: BACKGROUND IMAGE:
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // MARK: SCROLL VIEW:
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: NICK NAME:
        
        nicknameButton.translatesAutoresizingMaskIntoConstraints = false
        nicknameButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 75).isActive = true
        nicknameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nicknameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        nicknameButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.6).isActive = true

        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.centerXAnchor.constraint(equalTo: nicknameButton.centerXAnchor).isActive = true
        nicknameTextField.bottomAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 0).isActive = true
        nicknameTextField.heightAnchor.constraint(equalTo: nicknameButton.heightAnchor, multiplier: 0.6).isActive = true
        nicknameTextField.widthAnchor.constraint(equalTo: nicknameButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: COUNTRY:

        countryButton.translatesAutoresizingMaskIntoConstraints = false
        countryButton.topAnchor.constraint(equalTo: nicknameButton.bottomAnchor, constant: 15).isActive = true
        countryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        countryButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.6).isActive = true
        
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        countryTextField.centerXAnchor.constraint(equalTo: countryButton.centerXAnchor).isActive = true
        countryTextField.bottomAnchor.constraint(equalTo: countryButton.bottomAnchor, constant: 0).isActive = true
        countryTextField.heightAnchor.constraint(equalTo: countryButton.heightAnchor, multiplier: 0.6).isActive = true
        countryTextField.widthAnchor.constraint(equalTo: countryButton.widthAnchor, multiplier: 1).isActive = true
        
        countryPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: COUNT OF JUMPS:

        countOfJumpsButton.translatesAutoresizingMaskIntoConstraints = false
        countOfJumpsButton.topAnchor.constraint(equalTo: countryButton.bottomAnchor, constant: 15).isActive = true
        countOfJumpsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countOfJumpsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        countOfJumpsButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.6).isActive = true
        
        countOfJumpsTextField.translatesAutoresizingMaskIntoConstraints = false
        countOfJumpsTextField.centerXAnchor.constraint(equalTo: countOfJumpsButton.centerXAnchor).isActive = true
        countOfJumpsTextField.bottomAnchor.constraint(equalTo: countOfJumpsButton.bottomAnchor, constant: 0).isActive = true
        countOfJumpsTextField.heightAnchor.constraint(equalTo: countOfJumpsButton.heightAnchor, multiplier: 0.6).isActive = true
        countOfJumpsTextField.widthAnchor.constraint(equalTo: countOfJumpsButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: PROFESSION:

        professionButton.translatesAutoresizingMaskIntoConstraints = false
        professionButton.topAnchor.constraint(equalTo: countOfJumpsButton.bottomAnchor, constant: 15).isActive = true
        professionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        professionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        professionButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.6).isActive = true
        
        professionTextField.translatesAutoresizingMaskIntoConstraints = false
        professionTextField.centerXAnchor.constraint(equalTo: professionButton.centerXAnchor).isActive = true
        professionTextField.bottomAnchor.constraint(equalTo: professionButton.bottomAnchor, constant: 0).isActive = true
        professionTextField.heightAnchor.constraint(equalTo: professionButton.heightAnchor, multiplier: 0.6).isActive = true
        professionTextField.widthAnchor.constraint(equalTo: professionButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: LINK:

        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.topAnchor.constraint(equalTo: professionButton.bottomAnchor, constant: 15).isActive = true
        linkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        linkButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        linkButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.6).isActive = true
        
        linkTextField.translatesAutoresizingMaskIntoConstraints = false
        linkTextField.centerXAnchor.constraint(equalTo: linkButton.centerXAnchor).isActive = true
        linkTextField.bottomAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 0).isActive = true
        linkTextField.heightAnchor.constraint(equalTo: linkButton.heightAnchor, multiplier: 0.6).isActive = true
        linkTextField.widthAnchor.constraint(equalTo: linkButton.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: PHOTOS BUTTON:
        
        photosButton.translatesAutoresizingMaskIntoConstraints = false
        photosButton.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 15).isActive = true
        photosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photosButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        photosButton.heightAnchor.constraint(equalTo: sendButton.heightAnchor, multiplier: 1.6).isActive = true
        
        // MARK: COLLECTION VIEW:
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: photosButton.bottomAnchor, constant: 15).isActive = true
        collectionView.heightAnchor.constraint(equalTo: photosButton.heightAnchor, multiplier: 2).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        // MARK: PROGRESS VIEW:

        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
        cleanButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10).isActive = true
        
        // MARK: SEND BUTTON:

        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        sendButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
        sendButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: SCROLL VIEW:
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 1.2)
        scrollView.isScrollEnabled = true
        
        // MARK: BACKGROUND IMAGE:
        
        backgroundImage.image = arrayBackgroundImages[Int.random(in: 0 ... 1)]
        backgroundImage.contentMode = .scaleAspectFill
        
        // MARK: NICKNAME:

        nicknameButton.backgroundColor = .colorCell
        nicknameButton.setTitle("\(NSLocalizedString("Nickname / community", comment: ""))*", for: .normal)
        nicknameButton.setTitleColor(.colorLightGray, for: .normal)
        nicknameButton.contentVerticalAlignment = textAligmentTop
        nicknameButton.titleLabel?.font = fontMediumStandard12
        nicknameButton.layer.cornerRadius = cornerRadius15
        nicknameTextField.placeholder = NSLocalizedString("Nickname / community", comment: "")
        nicknameTextField.backgroundColor = .colorTabBar
        nicknameTextField.font = fontMediumStandard18
        nicknameTextField.textColor = .colorWhite
        nicknameTextField.layer.cornerRadius = cornerRadius15
        nicknameTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        nicknameTextField.textAlignment = textAligmentCenter
        nicknameTextField.tintColor = .colorWhite
        nicknameTextField.layer.masksToBounds = true
        
        // MARK: COUNTRY:

        countryButton.backgroundColor = .colorCell
        countryButton.setTitle("\(NSLocalizedString("Country / community", comment: ""))*", for: .normal)
        countryButton.setTitleColor(.colorLightGray, for: .normal)
        countryButton.contentVerticalAlignment = textAligmentTop
        countryButton.titleLabel?.font = fontMediumStandard12
        countryButton.layer.cornerRadius = cornerRadius15
        countryTextField.placeholder = NSLocalizedString("Country choose / community", comment: "")
        countryTextField.backgroundColor = .colorTabBar
        countryTextField.font = fontMediumStandard18
        countryTextField.textColor = .colorWhite
        countryTextField.layer.cornerRadius = cornerRadius15
        countryTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        countryTextField.textAlignment = textAligmentCenter
        countryTextField.tintColor = .colorWhite
        countryTextField.layer.masksToBounds = true
        countryTextField.inputView = countryPickerView
        countryPickerView.showCountryCodeInView = false
        countryPickerView.showCountryNameInView = true
        countryPickerView.showPhoneCodeInView = false
        countryPickerView.font = fontBoldStandard24
        countryPickerView.textColor = .colorWhite
        
        // MARK: COUNT JUMPS:

        countOfJumpsButton.backgroundColor = .colorCell
        countOfJumpsButton.setTitle("\(NSLocalizedString("Count of jumps / community", comment: ""))*", for: .normal)
        countOfJumpsButton.setTitleColor(.colorLightGray, for: .normal)
        countOfJumpsButton.contentVerticalAlignment = textAligmentTop
        countOfJumpsButton.titleLabel?.font = fontMediumStandard12
        countOfJumpsButton.layer.cornerRadius = cornerRadius15
        countOfJumpsTextField.placeholder = NSLocalizedString("Count of jumps placeholder / community", comment: "")
        countOfJumpsTextField.backgroundColor = .colorTabBar
        countOfJumpsTextField.font = fontMediumStandard18
        countOfJumpsTextField.textColor = .colorWhite
        countOfJumpsTextField.layer.cornerRadius = cornerRadius15
        countOfJumpsTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        countOfJumpsTextField.textAlignment = textAligmentCenter
        countOfJumpsTextField.tintColor = .colorWhite
        countOfJumpsTextField.layer.masksToBounds = true
        countOfJumpsTextField.keyboardType = .numberPad
        countOfJumpsTextField.returnKeyType = .done
        
        // MARK: PROFESSION:

        professionButton.backgroundColor = .colorCell
        professionButton.setTitle("\(NSLocalizedString("Profession / community", comment: ""))*", for: .normal)
        professionButton.setTitleColor(.colorLightGray, for: .normal)
        professionButton.contentVerticalAlignment = textAligmentTop
        professionButton.titleLabel?.font = fontMediumStandard12
        professionButton.layer.cornerRadius = cornerRadius15
        professionTextField.placeholder = NSLocalizedString("Profession / community", comment: "")
        professionTextField.backgroundColor = .colorTabBar
        professionTextField.font = fontMediumStandard18
        professionTextField.textColor = .colorWhite
        professionTextField.layer.cornerRadius = cornerRadius15
        professionTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        professionTextField.textAlignment = textAligmentCenter
        professionTextField.tintColor = .colorWhite
        professionTextField.layer.masksToBounds = true
        
        // MARK: LINK:

        linkButton.backgroundColor = .colorCell
        linkButton.setTitle("\(NSLocalizedString("Link / community", comment: ""))*", for: .normal)
        linkButton.setTitleColor(.colorLightGray, for: .normal)
        linkButton.contentVerticalAlignment = textAligmentTop
        linkButton.titleLabel?.font = fontMediumStandard12
        linkButton.layer.cornerRadius = cornerRadius15
        linkTextField.placeholder = "Instagram / YouTube"
        linkTextField.backgroundColor = .colorTabBar
        linkTextField.font = fontMediumStandard18
        linkTextField.textColor = .colorWhite
        linkTextField.layer.cornerRadius = cornerRadius15
        linkTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        linkTextField.textAlignment = textAligmentCenter
        linkTextField.tintColor = .colorWhite
        linkTextField.layer.masksToBounds = true
        linkTextField.keyboardType = .URL
        
        // MARK: PHOTOS BUTTON:
        
        photosButton.setTitle("\(NSLocalizedString("5 photos / community", comment: ""))*", for: .normal)
        photosButton.backgroundColor = .colorCell
        photosButton.setTitleColor(.colorLightGray, for: .normal)
        photosButton.setTitleColor(.systemBlue, for: .highlighted)
        photosButton.titleLabel?.font = fontMediumStandard12
        photosButton.layer.cornerRadius = cornerRadius15
        photosButton.addTarget(self, action: #selector(photosButtonTapped), for: .touchUpInside)
                
        // MARK: CLEAN BUTTON:

        cleanButton.setTitle(NSLocalizedString("Clean / community", comment: ""), for: .normal)
        cleanButton.backgroundColor = .colorTabBar
        cleanButton.layer.cornerRadius = cornerRadius15
        cleanButton.setTitleColor(.colorWhite, for: .normal)
        cleanButton.setTitleColor(.systemBlue, for: .highlighted)
        cleanButton.titleLabel?.font = fontMediumStandard14
        cleanButton.addTarget(self, action: #selector(cleanButtonTapped), for: .touchUpInside)
        
        // MARK: SEND BUTTON:
        
        sendButton.setTitle(NSLocalizedString("Send / community", comment: ""), for: .normal)
        sendButton.backgroundColor = .colorCell
        sendButton.layer.cornerRadius = cornerRadius15
        sendButton.setTitleColor(.colorWhite, for: .normal)
        sendButton.setTitleColor(.systemBlue, for: .highlighted)
        sendButton.titleLabel?.font = fontMediumStandard14
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - CONFIGURE GESTURES:
    
    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - HELPERS:
    
    // MARK: SEND REQUES:
    
    @objc private func sendRequest() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Доступ разрешен.")
            case .denied, .restricted:
                print("Доступ запрещен.")
            case .notDetermined:
                print("Доступ не определен.")
            case .limited:
                print("Доступ ограничен.")
            @unknown default:
                fatalError("Неизвестный статус.")
            }
        }
    }
    
    // MARK: SELECT PHOTOS TAPPED:

    @objc private func photosButtonTapped() {
        sendRequest()
        resignFirstResponders()
        tapGestureDone()
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .images
            
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: SEND BUTTON TAPPED:
    
    @objc private func sendButtonTapped() {
        vibrationOn.vibrationStandart()
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        guard nicknameTextField.text != "" else {
            showError(textField: nicknameTextField)
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        guard countryTextField.text != "" else {
            showError(textField: countryTextField)
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        guard countOfJumpsTextField.text != "" else {
            showError(textField: countOfJumpsTextField)
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        guard professionTextField.text != "" else {
            showError(textField: professionTextField)
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        guard linkTextField.text != "" else {
            showError(textField: linkTextField)
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        guard selectedImages.count == 5 else {
            showErrorButton(button: photosButton)
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        
        Adapty.getProfile { result in
            if let profile = try? result.get(),
               profile.accessLevels["premium"]?.isActive ?? false
            {
                self.uploadDataToFirebase()
            } else {
                self.actionButtonSaveRedColor()
                self.showPaymentAlert(message: NSLocalizedString("Error adapty / adapty status", comment: ""))
                self.clearTextViews()
                self.resignFirstResponders()
                self.alertKitError()
                self.selectedImages.removeAll()
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
        }
    }
    
    // MARK: CHECK INTERNET CONNECTION:
    
    private func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                completion(true)
            } else {
                completion(false)
            }
            monitor.cancel()
        }
        
        monitor.start(queue: queue)
    }
    
    // MARK: UPLOAD DATA TO FIREBASE:
    
    func uploadDataToFirebase() {
        checkInternetConnection { [weak self] isConnected in
            guard let self = self else { return }
            if !isConnected {
                DispatchQueue.main.async {
                    self.showAlertWithMessage(
                        title: NSLocalizedString("Error / alert kit", comment: ""),
                        message: NSLocalizedString("Message / adapty", comment: ""))
                    self.alertKitError()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                }
                return
            }
            
            DispatchQueue.main.async {
                let nickname = self.nicknameTextField.text ?? ""
                let country = self.countryTextField.text ?? ""
                let countOfJumps = self.countOfJumpsTextField.text ?? ""
                let profession = self.professionTextField.text ?? ""
                let link = self.linkTextField.text ?? ""
                
                let ref = Database.database().reference()
                ref.child("SkydiversForCheck/\(nickname)").childByAutoId().setValue([
                    "Nickname": nickname,
                    "Country": country,
                    "Counts of jumps": countOfJumps,
                    "Profession": profession,
                    "Link": link
                ]) { [weak self] error, _ in
                    guard let self = self else { return }
                    if error != nil {
                        DispatchQueue.main.async {
                            self.showAlertWithMessage(
                                title: NSLocalizedString("Error / alert kit", comment: ""),
                                message: NSLocalizedString("Error / community", comment: ""))
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.removeFromSuperview()
                        }
                    } else {
                        self.uploadImagesToFirebase()
                    }
                }
            }
        }
    }
    
    // MARK: UPLOAD IMAGES TO FIREBASE:
    
    func uploadImagesToFirebase() {
        guard !selectedImages.isEmpty else { return }
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else { return }
        
        progressView.isHidden = false
        progressView.progress = 0.0

        let storage = Storage.storage()
        let storageRef = storage.reference()

        for (index, image) in selectedImages.enumerated() {
            let imageData = image.jpegData(compressionQuality: 0.8)
            let imageRef = storageRef.child("SkydiversForCheck/\(nickname)/\(nickname)\(index).jpg")

            let uploadTask = imageRef.putData(imageData!, metadata: nil) { _, error in
                if error != nil {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                    return
                }
                print("Изображение \(index + 1) успешно загружено!")
            }

            uploadTask.observe(.progress) { snapshot in
                guard let progress = snapshot.progress else { return }
                let percentComplete = Float(progress.completedUnitCount) / Float(progress.totalUnitCount)
                self.progressView.progress = percentComplete
                print("Загрузка изображения \(index + 1) завершена на \(percentComplete * 100)%")
            }

            uploadTask.observe(.success) { _ in
                print("Загрузка изображения \(index + 1) завершена!")
                if index == self.selectedImages.count - 1 {
                    self.progressView.isHidden = true
                }
            }

            uploadTask.observe(.failure) { _ in
                print("Ошибка при загрузке изображения \(index + 1)")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
            
            uploadTask.observe(.success) { _ in
                print("Загрузка изображения \(index + 1) завершена!")
                if index == self.selectedImages.count - 1 {
                    self.progressView.isHidden = true
                    self.handleUploadCompletion()
                }
            }
        }
    }
    
    // MARK: HANDLE UPLOAD COMPLETION:

    private func handleUploadCompletion() {
        showAlertWithMessage(title: NSLocalizedString("Success / alert kit", comment: ""), message: NSLocalizedString("Success / community", comment: ""))
        actionButtonSaveGreenColor()
        playSoundSucces()
        resignFirstResponders()
        clearTextViews()
        alertKitSuccess()
        selectedImages.removeAll()
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        sendTelegramMessage(message: "Новый пользователь подал заявку на публикацию своего профиля.")
    }
    
    // MARK: CLEAN BUTTON TAPPED:
    
    @objc private func cleanButtonTapped() {
        vibrationOn.vibrationStandart()
        selectedImages.removeAll()
        collectionView.reloadData()
        actionButtonCleanChangeColor()
        clearTextViews()
        resignFirstResponders()
        alertKitClear()
    }
    
    // MARK: CENTERING CONTENT IN COLLECTION VIEW:
    
    func centerContentInCollectionView() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let totalItemWidth = layout.itemSize.width * CGFloat(collectionView.numberOfItems(inSection: 0))
        let totalSpacingWidth = layout.minimumInteritemSpacing * CGFloat(collectionView.numberOfItems(inSection: 0) - 1)
        let totalContentWidth = totalItemWidth + totalSpacingWidth
        let collectionViewWidth = collectionView.bounds.width
        
        if totalContentWidth < collectionViewWidth {
            let inset = (collectionViewWidth - totalContentWidth) / 2
            collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        } else {
            collectionView.contentInset = UIEdgeInsets.zero
        }
    }
    
    // MARK: SHOW ERROR FOR EMPTY FIELDS:
    
    private func showError(textField: UITextField) {
        textField.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            textField.backgroundColor = .colorTabBar
        }
        resignFirstResponders()
        actionButtonSaveRedColor()
        alertKitError()
    }
    
    // MARK: SHOW ERROR FOR EMPTY PHOTOS:
    
    private func showErrorButton(button: UIButton) {
        button.backgroundColor = .colorRed
        UIView.animate(withDuration: 2, delay: 0, options: .transitionCrossDissolve) {
            button.backgroundColor = .colorTabBar
        }
        resignFirstResponders()
        actionButtonSaveRedColor()
        alertKitError()
    }
    
    // MARK: SHOW PAYMENT ALERT:
    
    private func showPaymentAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Alert / adapty status", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: CLOSE ALL TEXT FIELDS:
    
    private func resignFirstResponders() {
        nicknameTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        professionTextField.resignFirstResponder()
        linkTextField.resignFirstResponder()
    }
    
    // MARK: CLEAR ALL TEXT FIELDS:
    
    private func clearTextViews() {
        nicknameTextField.text = ""
        countryTextField.text = ""
        countOfJumpsTextField.text = ""
        professionTextField.text = ""
        linkTextField.text = ""
    }
    
    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonSaveGreenColor() {
        sendButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.sendButton.backgroundColor = .colorCell
        }
    }
    
    private func actionButtonSaveRedColor() {
        sendButton.backgroundColor = .colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.sendButton.backgroundColor = .colorCell
        }
    }
    
    private func actionButtonCleanChangeColor() {
        cleanButton.backgroundColor = .colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanButton.backgroundColor = .colorTabBar
        }
    }
    
    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc private func tapGestureDone() {
        view.endEditing(true)
    }
    
    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / alert kit", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
    
    // MARK: ALERT KIT CLEAR:

    private func alertKitClear() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    // MARK: SHOW ALERT WITH MESSAGE:

    private func showAlertWithMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: SEND TELEGRAM MESSAGE:
    
    func sendTelegramMessage(message: String) {
        let botToken = "7264425174:AAGOBEeZrrYhQSwrWPcwMURy90kfW65UlSg"
        let chatID = "298098804,"
        
        let messageText = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.telegram.org/bot\(botToken)/sendMessage?chat_id=\(chatID)&text=\(messageText)"
        
        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Ошибка при отправке сообщения в Telegram: \(error.localizedDescription)")
                return
            }
        }
        
        task.resume()
    }
}

// MARK: - EXTENSIONS:

extension AddSkydiverViewController: UITextFieldDelegate {}

extension AddSkydiverViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        selectedImages.removeAll()
            
        let dispatchGroup = DispatchGroup()

        for result in results {
            dispatchGroup.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                defer { dispatchGroup.leave() }
                    
                if let image = object as? UIImage {
                    self?.selectedImages.append(image)
                }
            }
        }
            
        dispatchGroup.notify(queue: .main) {
            print("Выбрано \(self.selectedImages.count) изображений")
            self.collectionView.reloadData()
            self.centerContentInCollectionView()
        }
    }
}

extension AddSkydiverViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(image: selectedImages[indexPath.item])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        cell.contentView.addSubview(imageView)
        imageView.frame = cell.contentView.frame
        return cell
    }
}

extension AddSkydiverViewController: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countryTextField.text = country.name
    }
}
