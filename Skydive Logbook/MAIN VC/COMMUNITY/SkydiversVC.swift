import Firebase
import FirebaseDatabaseInternal
import FirebaseStorage
import Lottie
import SafariServices
import UIKit
import WebKit

final class SkydiversVC: UIViewController {
    private let skydiversBackground = LottieAnimationView(name: "SkydiversBackground")
    private let skydiversLottie = LottieAnimationView(name: "Skydivers")
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let skydiversLottieButton = UIButton()
    private let titleLabel = UILabel()
    private let skydiversTableView = UITableView()
    private let infoButton = UIButton()
    private let backButton = UIButton()
    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 26)
    private let vibrationOn = Vibration()
    private var arraySkydivers: [Skydiver] = []
    
    private let segmentControl = UISegmentedControl()
    private let newsWebView = WKWebView()
    private let shopsWebView = WKWebView()
    private let news: String = NSLocalizedString("News", comment: "")
    private let skydivers: String = NSLocalizedString("Skydivers", comment: "")
    private let shops: String = NSLocalizedString("Shops", comment: "")

    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        configureTableView()
        
        segmentControl.isHidden = true
        segmentControl.selectedSegmentIndex = 0
        segmentedControlValueChanged(segmentControl)
        newsWebView.isHidden = true
        skydiversTableView.isHidden = false
        shopsWebView.isHidden = true
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(skydiversBackground, skydiversLottie, skydiversLottieButton, titleLabel, segmentControl, newsWebView, skydiversTableView, shopsWebView, infoButton, backButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: SKYDIVERS BACKGROUND:

        skydiversBackground.translatesAutoresizingMaskIntoConstraints = false
        skydiversBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skydiversBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        skydiversBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        skydiversBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // MARK: BACK BUTTON:

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        // MARK: INFO BUTTON:
        
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        // MARK: ANIMATION SKYDIVERS LOTTIE:
        
        skydiversLottie.translatesAutoresizingMaskIntoConstraints = false
        skydiversLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
        skydiversLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skydiversLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        // MARK: ANIMATION SKYDIVERS LOTTIE BUTTON:
        
        skydiversLottieButton.translatesAutoresizingMaskIntoConstraints = false
        skydiversLottieButton.topAnchor.constraint(equalTo: skydiversLottie.topAnchor).isActive = true
        skydiversLottieButton.bottomAnchor.constraint(equalTo: skydiversLottie.bottomAnchor).isActive = true
        skydiversLottieButton.leadingAnchor.constraint(equalTo: skydiversLottie.leadingAnchor).isActive = true
        skydiversLottieButton.trailingAnchor.constraint(equalTo: skydiversLottie.trailingAnchor).isActive = true
        
        // MARK: SEGMENT CONTROL:

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: skydiversLottieButton.bottomAnchor).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        
        // MARK: TITLE LABEL:
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: skydiversLottieButton.bottomAnchor, constant: 0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // MARK: TABLE VIEW:
        
        skydiversTableView.translatesAutoresizingMaskIntoConstraints = false
        skydiversTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10).isActive = true
        skydiversTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        skydiversTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        skydiversTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        // MARK: NEWS WEB VIEW:
        
        newsWebView.translatesAutoresizingMaskIntoConstraints = false
        newsWebView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newsWebView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15).isActive = true
        newsWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        newsWebView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        
        // MARK: SHOPS WEB VIEW:
        
        shopsWebView.translatesAutoresizingMaskIntoConstraints = false
        shopsWebView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shopsWebView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15).isActive = true
        shopsWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        shopsWebView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: SKYDIVERS BACKGROUND:

        skydiversBackground.play()
        skydiversBackground.loopMode = .loop
        skydiversBackground.animationSpeed = 1
        skydiversBackground.contentMode = .scaleAspectFill
        
        // MARK: NAVIGATION CONTROLLER:
        
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
        navigationItem.title = ""
        
        // MARK: BACK BUTTON:

        let backImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorDarkGray, renderingMode: .alwaysOriginal)
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        
        // MARK: INFO BUTTON:
        
        let infoImage = UIImage(systemName: "info.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorDarkGray, renderingMode: .alwaysOriginal)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        // MARK: ANIMATIONS:
        
        skydiversLottie.play()
        skydiversLottie.loopMode = .playOnce
        
        // MARK: ANIMATION SKYDIVERS LOTTIE BUTTON:
        
        skydiversLottieButton.addTarget(self, action: #selector(skydiversLottieButtonTapped), for: .touchUpInside)
        
        // MARK: TITLE LABEL:
        
        titleLabel.text = "SKYDIVE COMMUNITY"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .colorWhite
        titleLabel.font = fontMediumStandard18
        
        // MARK: SEGMENT CONTROL:

        segmentControl.insertSegment(withTitle: skydivers, at: 0, animated: true)
        segmentControl.insertSegment(withTitle: news, at: 1, animated: true)
        segmentControl.insertSegment(withTitle: shops, at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .colorCell
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        // MARK: NEWS WEB VIEW:
        
        newsWebView.layer.masksToBounds = true
        newsWebView.layer.cornerRadius = cornerRadius15
        
        // MARK: SHOPS WEB VIEW:
        
        shopsWebView.layer.masksToBounds = true
        shopsWebView.layer.cornerRadius = cornerRadius15
    }
    
    // MARK: - CONFIGURE NEWS WEB VIEW:
    
    private func configureNewsWebView() {
        let urlString = "https://skydivebook.tilda.ws/news"
        guard let url = URL(string: urlString) else {
            let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: NSLocalizedString("Message / adapty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
                self.vibrationOn.vibrationStandart()
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
            return
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10

        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: url) { [weak self] _, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
                        self?.vibrationOn.vibrationStandart()
                        self?.dismiss(animated: true)
                    }))
                    self?.present(alert, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self?.loadNewsWebView(with: url)
                }
            }
        }
        task.resume()
    }

    private func loadNewsWebView(with url: URL) {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        newsWebView.load(URLRequest(url: url))
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    // MARK: - CONFIGURE SHOPS WEB VIEW:
    
    private func configureShopsWebView() {
        let urlString = "https://skydivebook.tilda.ws/shops"
        guard let url = URL(string: urlString) else {
            let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: NSLocalizedString("Message / adapty", comment: ""), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
                self.vibrationOn.vibrationStandart()
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
            return
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10

        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: url) { [weak self] _, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
                        self?.vibrationOn.vibrationStandart()
                        self?.dismiss(animated: true)
                    }))
                    self?.present(alert, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self?.loadShopsWebView(with: url)
                }
            }
        }
        task.resume()
    }

    private func loadShopsWebView(with url: URL) {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        shopsWebView.load(URLRequest(url: url))
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    // MARK: - CONFIGURE TABLE VIEW:
    
    private func configureTableView() {
        skydiversTableView.dataSource = self
        skydiversTableView.delegate = self
        skydiversTableView.register(SkydiversCell.self, forCellReuseIdentifier: "SkydiversCell")
        skydiversTableView.separatorStyle = .none
        skydiversTableView.backgroundColor = .clear
    }
    
    // MARK: - NETWORK REQUEST:
    
    private func requestFirebase() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        let dataBase = Database.database().reference()
        dataBase.child("skydivers").getData { [weak self] error, snapshot in
            guard let self = self, error == nil, let snapshot = snapshot else {
                self?.showError()
                return
            }
            var skydivers = [Skydiver]()
            for child in snapshot.children {
                guard let childSnapshot = child as? DataSnapshot,
                      let skydiverDict = childSnapshot.value as? [String: Any] else { continue }

                if let skydiver = self.parseSkydiverData(from: skydiverDict) {
                    skydivers.append(skydiver)
                }
            }
            self.arraySkydivers = skydivers.sorted { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
            self.skydiversTableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    // MARK: PARSE DATA:

    private func parseSkydiverData(from skydiverDict: [String: Any]) -> Skydiver? {
        guard let rating = skydiverDict["rating"] as? String,
              let nickname = skydiverDict["nickname"] as? String,
              let countryName = skydiverDict["countryName"] as? String,
              let countryFlag = skydiverDict["countryFlag"] as? String,
              let link = skydiverDict["link"] as? String,
              let profession = skydiverDict["profession"] as? String,
              let countJumps = skydiverDict["countJumps"] as? String,
              let firstJump = skydiverDict["firstJump"] as? String,
              let id = skydiverDict["id"] as? String
        else {
            return nil
        }
        let reference = Storage.storage().reference(forURL: "gs://skydivebook.appspot.com/\(id)")
        let skydiver = Skydiver(nickname: nickname, rating: rating, countryFlag: countryFlag, countryName: countryName, countJumps: countJumps, firstJump: firstJump, profession: profession, link: link, photos: [], id: id)
        
        reference.listAll { result, error in
            guard let result = result else { return }
            var photos = [UIImage]()
            for item in result.items {
                item.getData(maxSize: Int64(1 * 1024 * 1024)) { [weak self] data, error in
                    guard error == nil else { self?.showError(); return }
                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
                    photos.append(image)
                    self?.updateSkydiverPhotos(skydiver: skydiver, photos: photos)
                }
            }
        }
        return skydiver
    }
    
    // MARK: UPDATE PHOTOS:

    private func updateSkydiverPhotos(skydiver: Skydiver, photos: [UIImage]) {
        if let index = arraySkydivers.firstIndex(where: { $0.id == skydiver.id }) {
            arraySkydivers[index].photos = photos
            skydiversTableView.reloadData()
            if let cell = skydiversTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SkydiversCell {
                cell.hideActivityIndicator()
            }
        }
    }
    
    // MARK: - HELPERS:
    
    // MARK: SHOW ERROR:

    private func showError() {
        let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: NSLocalizedString("Message / adapty", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
            self.vibrationOn.vibrationStandart()
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
        
    // MARK: SKYDIVERS LOTTIE BUTTON TAPPED:
    
    @objc private func skydiversLottieButtonTapped() {
        vibrationOn.vibrationStandart()
        skydiversLottie.play()
        skydiversLottie.loopMode = .playOnce
    }
    
    // MARK: BACK BUTTON:
    
    @objc private func backupButtonTapped() {
        vibrationOn.vibrationStandart()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: INFO BUTTON:
    
    @objc private func infoButtonTapped() {
        vibrationOn.vibrationStandart()
        let alert = UIAlertController(title: NSLocalizedString("About rating / skydivers", comment: ""), message: NSLocalizedString("About rating message / skydivers", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Instagram", comment: ""), style: .default, handler: { _ in
            self.tapInstagramButton()
        }))
        present(alert, animated: true)
    }
    
    // MARK: TRANSITION ON INSTAGRAM:
    
    private func tapInstagramButton() {
        guard let url = URL(string: "https://instagram.com/skydivebook") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
    
    // MARK: SEGMENT CONTROL VALUE CHANGED:

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            skydiversTableView.isHidden = false
            shopsWebView.isHidden = true
            newsWebView.isHidden = true
            requestFirebase()
        } else if sender.selectedSegmentIndex == 1 {
            newsWebView.isHidden = false
            shopsWebView.isHidden = true
            skydiversTableView.isHidden = true
            configureNewsWebView()
        } else if sender.selectedSegmentIndex == 2 {
            newsWebView.isHidden = true
            skydiversTableView.isHidden = true
            shopsWebView.isHidden = false
            configureShopsWebView()
        }
    }
}

// MARK: - EXTENSION:

extension SkydiversVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arraySkydivers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkydiversCell", for: indexPath) as? SkydiversCell else { return UITableViewCell() }
        let skydiver = arraySkydivers[indexPath.row]
        cell.configureModel(skydiver: skydiver)
        if skydiver.photos.isEmpty {
            cell.showActivityIndicator()
        } else {
            cell.configurePhotos(photos: skydiver.photos)
        }
//        cell.configurePlacesCell(index: indexPath)
        cell.backgroundColor = .clear
        cell.delegate = self
        return cell
    }
}

// MARK: - EXTENSION FOR SAFARI:

extension SkydiversVC: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}

// MARK: - EXTENSION FOR SAFARI:

extension SkydiversVC: SkydiversCellDelegate {
    func tapLinkButton(link: String) {
        vibrationOn.vibrationStandart()
        guard let url = URL(string: link) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        present(safariViewController, animated: true)
    }
}
