//import Firebase
//import FirebaseDatabaseInternal
//import FirebaseStorage
//import Lottie
//import SafariServices
//import UIKit
//import WebKit
//
//final class SkydiversVC: UIViewController {
//    private let skydiversLottie = LottieAnimationView(name: "Skydivers")
//    private let activityIndicator = UIActivityIndicatorView(style: .large)
//    private let skydiversLottieButton = UIButton()
//    private let titleLabel = UILabel()
//    private let skydiversTableView = UITableView()
//    private let partnersTableView = UITableView()
//    private let addButton = UIButton()
//    private let backButton = UIButton()
//    private let configurationImage = UIImage.SymbolConfiguration(pointSize: 26)
//    private var arraySkydivers: [Skydiver] = []
//    private var arrayPartners: [Partner] = []
//    private let segmentControl = UISegmentedControl()
//    private let skydivers: String = NSLocalizedString("Community / skydivers", comment: "")
//    private let partners: String = NSLocalizedString("Business / community", comment: "")
//
//    // MARK: - LIFYCYCLE:
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addSubviews()
//        configureConstraints()
//        configureUI()
//        configureTableView()
//        segmentControl.selectedSegmentIndex = 0
//        segmentedControlValueChanged(segmentControl)
//    }
//    
//    // MARK: - ADD SUBVIEWS:
//    
//    private func addSubviews() {
//        view.addSubviews(skydiversLottie, skydiversLottieButton, titleLabel, segmentControl, skydiversTableView, partnersTableView, addButton, backButton)
//    }
//    
//    // MARK: - CONFIGURE CONSTRAINTS:
//    
//    private func configureConstraints() {
//        
//        // MARK: BACK BUTTON:
//
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
//        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
//        
//        // MARK: ADD BUTTON:
//        
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
//        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
//        
//        // MARK: ANIMATION SKYDIVERS LOTTIE:
//        
//        skydiversLottie.translatesAutoresizingMaskIntoConstraints = false
//        skydiversLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
//        skydiversLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        skydiversLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
//        
//        // MARK: ANIMATION SKYDIVERS LOTTIE BUTTON:
//        
//        skydiversLottieButton.translatesAutoresizingMaskIntoConstraints = false
//        skydiversLottieButton.topAnchor.constraint(equalTo: skydiversLottie.topAnchor).isActive = true
//        skydiversLottieButton.bottomAnchor.constraint(equalTo: skydiversLottie.bottomAnchor).isActive = true
//        skydiversLottieButton.leadingAnchor.constraint(equalTo: skydiversLottie.leadingAnchor).isActive = true
//        skydiversLottieButton.trailingAnchor.constraint(equalTo: skydiversLottie.trailingAnchor).isActive = true
//        
//        // MARK: SEGMENT CONTROL:
//
//        segmentControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentControl.topAnchor.constraint(equalTo: skydiversLottieButton.bottomAnchor).isActive = true
//        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
//        
//        // MARK: TITLE LABEL:
//        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.topAnchor.constraint(equalTo: skydiversLottieButton.bottomAnchor, constant: 0).isActive = true
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        
//        // MARK: SKYDIVERS TABLE VIEW:
//        
//        skydiversTableView.translatesAutoresizingMaskIntoConstraints = false
//        skydiversTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10).isActive = true
//        skydiversTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        skydiversTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        skydiversTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
//        
//        // MARK: PARTNERS TABLE VIEW:
//        
//        partnersTableView.translatesAutoresizingMaskIntoConstraints = false
//        partnersTableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10).isActive = true
//        partnersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        partnersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        partnersTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
//    }
//    
//    // MARK: - CONFIGURE UI:
//    
//    private func configureUI() {
//        // MARK: VIEW:
//        
//        view.backgroundColor = .colorBackground
//        
//        // MARK: NAVIGATION CONTROLLER:
//        
//        navigationController?.navigationBar.isHidden = true
//        navigationItem.backButtonTitle = NSLocalizedString("back", comment: "")
//        navigationItem.title = ""
//        
//        // MARK: BACK BUTTON:
//
//        let backImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: configurationImage)?.withTintColor(.colorWhite, renderingMode: .alwaysOriginal)
//        backButton.setImage(backImage, for: .normal)
//        backButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
//        
//        // MARK: INFO BUTTON:
//        
//        let infoImage = UIImage(systemName: "plus.circle", withConfiguration: configurationImage)?.withTintColor(.colorWhite, renderingMode: .alwaysOriginal)
//        addButton.setImage(infoImage, for: .normal)
//        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        
//        // MARK: ANIMATIONS:
//        
//        skydiversLottie.play()
//        skydiversLottie.loopMode = .playOnce
//        
//        // MARK: ANIMATION SKYDIVERS LOTTIE BUTTON:
//        
//        skydiversLottieButton.addTarget(self, action: #selector(skydiversLottieButtonTapped), for: .touchUpInside)
//        
//        // MARK: TITLE LABEL:
//        
//        titleLabel.text = "SKYDIVE COMMUNITY"
//        titleLabel.textAlignment = .center
//        titleLabel.textColor = .colorWhite
//        titleLabel.font = FontManager.medium(size: 18).uiFont
//        
//        // MARK: SEGMENT CONTROL:
//        
//        segmentControl.insertSegment(withTitle: skydivers, at: 0, animated: true)
//        segmentControl.insertSegment(withTitle: partners, at: 1, animated: true)
//        segmentControl.backgroundColor = .colorCell
//        segmentControl.selectedSegmentTintColor = .systemBlue
//        segmentControl.layer.borderColor = UIColor.colorCell.cgColor
//        segmentControl.layer.borderWidth = 2
//        segmentControl.clipsToBounds = true
//        let normalTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white]
//        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
//        let selectedTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white]
//        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
//        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
//    }
//
//    // MARK: - CONFIGURE TABLE VIEW:
//    
//    private func configureTableView() {
//        skydiversTableView.dataSource = self
//        skydiversTableView.delegate = self
//        skydiversTableView.register(SkydiversCell.self, forCellReuseIdentifier: "SkydiversCell")
//        skydiversTableView.separatorStyle = .none
//        skydiversTableView.backgroundColor = .clear
//        skydiversTableView.isHidden = false
//        
//        partnersTableView.dataSource = self
//        partnersTableView.delegate = self
//        partnersTableView.register(PartnersCell.self, forCellReuseIdentifier: "PartnersCell")
//        partnersTableView.separatorStyle = .none
//        partnersTableView.backgroundColor = .clear
//        partnersTableView.isHidden = true
//    }
//    
//    // MARK: - NETWORK REQUEST:
//    
//    // MARK: - REQUEST SKYDIVERS FIREBASE:
//    
//    private func requestSkydiversFirebase() {
//        activityIndicator.center = view.center
//        activityIndicator.startAnimating()
//        view.addSubview(activityIndicator)
//        let dataBase = Database.database().reference()
//        dataBase.child("skydivers").getData { [weak self] error, snapshot in
//            guard let self = self, error == nil, let snapshot = snapshot else {
//                self?.showError()
//                return
//            }
//            var skydivers = [Skydiver]()
//            for child in snapshot.children {
//                guard let childSnapshot = child as? DataSnapshot,
//                      let skydiverDict = childSnapshot.value as? [String: Any] else { continue }
//
//                if let skydiver = self.parseSkydiverData(from: skydiverDict) {
//                    skydivers.append(skydiver)
//                }
//            }
//            self.arraySkydivers = skydivers.sorted { Int($0.nickname) ?? 0 > Int($1.nickname) ?? 0 }
//            self.skydiversTableView.reloadData()
//            self.activityIndicator.stopAnimating()
//            self.activityIndicator.removeFromSuperview()
//        }
//    }
//
//    // MARK: PARSE DATA SKYDIVERS:
//
//    private func parseSkydiverData(from skydiverDict: [String: Any]) -> Skydiver? {
//        guard let nickname = skydiverDict["nickname"] as? String,
//              let countryName = skydiverDict["countryName"] as? String,
//              let countryFlag = skydiverDict["countryFlag"] as? String,
//              let link = skydiverDict["link"] as? String,
//              let profession = skydiverDict["profession"] as? String,
//              let countJumps = skydiverDict["countJumps"] as? String,
//              let id = skydiverDict["id"] as? String
//        else {
//            return nil
//        }
//        let reference = Storage.storage().reference(forURL: "gs://skydivebook.appspot.com/\(id)")
//        let skydiver = Skydiver(nickname: nickname, countryFlag: countryFlag, countryName: countryName, countJumps: countJumps, profession: profession, link: link, photos: [], id: id)
//        
//        reference.listAll { result, error in
//            guard let result = result else { return }
//            var photos = [UIImage]()
//            for item in result.items {
//                item.getData(maxSize: Int64(1 * 1024 * 1024)) { [weak self] data, error in
//                    guard error == nil else { self?.showError(); return }
//                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
//                    photos.append(image)
//                    self?.updateSkydiverPhotos(skydiver: skydiver, photos: photos)
//                }
//            }
//        }
//        return skydiver
//    }
//    
//    // MARK: UPDATE PHOTOS SKYDIVERS:
//
//    private func updateSkydiverPhotos(skydiver: Skydiver, photos: [UIImage]) {
//        if let index = arraySkydivers.firstIndex(where: { $0.id == skydiver.id }) {
//            arraySkydivers[index].photos = photos
//            skydiversTableView.reloadData()
//            if let cell = skydiversTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SkydiversCell {
//                cell.hideActivityIndicator()
//            }
//        }
//    }
//    
//    // MARK: - REQUEST PARTNERS FIREBASE:
//    
//    private func requestPartnersFirebase() {
//        activityIndicator.center = view.center
//        activityIndicator.startAnimating()
//        view.addSubview(activityIndicator)
//        let dataBase = Database.database().reference()
//        dataBase.child("partners").getData { [weak self] error, snapshot in
//            guard let self = self, error == nil, let snapshot = snapshot else {
//                self?.showError()
//                return
//            }
//            var partners = [Partner]()
//            for child in snapshot.children {
//                guard let childSnapshot = child as? DataSnapshot,
//                      let partnerDict = childSnapshot.value as? [String: Any] else { continue }
//
//                if let partner = self.parsePartnerData(from: partnerDict) {
//                    partners.append(partner)
//                }
//            }
//            self.arrayPartners = partners.sorted { Int($0.nickname) ?? 0 > Int($1.nickname) ?? 0 }
//            self.partnersTableView.reloadData()
//            self.activityIndicator.stopAnimating()
//            self.activityIndicator.removeFromSuperview()
//        }
//    }
//    
//    // MARK: PARSE DATA PARTNERS:
//
//    private func parsePartnerData(from partnerDict: [String: Any]) -> Partner? {
//        guard let nickname = partnerDict["nickname"] as? String,
//              let countryName = partnerDict["countryName"] as? String,
//              let countryFlag = partnerDict["countryFlag"] as? String,
//              let link = partnerDict["link"] as? String,
//              let description = partnerDict["description"] as? String,
//              let id = partnerDict["id"] as? String
//        else {
//            return nil
//        }
//        let reference = Storage.storage().reference(forURL: "gs://skydivebook.appspot.com/\(id)")
//        let partner = Partner(nickname: nickname, countryFlag: countryFlag, countryName: countryName, description: description, link: link, photos: [], id: id)
//        
//        reference.listAll { result, error in
//            guard let result = result else { return }
//            var photos = [UIImage]()
//            for item in result.items {
//                item.getData(maxSize: Int64(1 * 1024 * 1024)) { [weak self] data, error in
//                    guard error == nil else { self?.showError(); return }
//                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
//                    photos.append(image)
//                    self?.updatePartnerPhotos(partner: partner, photos: photos)
//                }
//            }
//        }
//        return partner
//    }
//    
//    // MARK: UPDATE PHOTOS PARTNERS:
//
//    private func updatePartnerPhotos(partner: Partner, photos: [UIImage]) {
//        if let index = arrayPartners.firstIndex(where: { $0.id == partner.id }) {
//            arrayPartners[index].photos = photos
//            partnersTableView.reloadData()
//            if let cell = partnersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PartnersCell {
//                cell.hideActivityIndicator()
//            }
//        }
//    }
//    
//    // MARK: - HELPERS:
//    
//    // MARK: SHOW ERROR:
//
//    private func showError() {
//        let alert = UIAlertController(title: NSLocalizedString("No connection / adapty", comment: ""), message: NSLocalizedString("Message / adapty", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: { _ in
//            VibrationManager.instance.vibrationStandart()
//            self.dismiss(animated: true)
//        }))
//        present(alert, animated: true)
//    }
//        
//    // MARK: SKYDIVERS LOTTIE BUTTON TAPPED:
//    
//    @objc private func skydiversLottieButtonTapped() {
//        VibrationManager.instance.vibrationStandart()
//        skydiversLottie.play()
//        skydiversLottie.loopMode = .playOnce
//    }
//    
//    // MARK: BACK BUTTON:
//    
//    @objc private func backupButtonTapped() {
//        VibrationManager.instance.vibrationStandart()
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // MARK: ADD BUTTON:
//    
//    @objc private func addButtonTapped() {
//        VibrationManager.instance.vibrationStandart()
//        let alert = UIAlertController(title: NSLocalizedString("About rating / skydivers", comment: ""), message: NSLocalizedString("About rating message / skydivers", comment: ""), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default))
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Instagram", comment: ""), style: .default, handler: { _ in
//            self.tapInstagramButton()
//        }))
//        let addSkydiverViewController = AddSkydiverViewController()
//        present(addSkydiverViewController, animated: true)
//    }
//    
//    // MARK: TRANSITION ON INSTAGRAM:
//    
//    private func tapInstagramButton() {
//        guard let url = URL(string: "https://instagram.com/skydivebook") else { return }
//        let safariViewController = SFSafariViewController(url: url)
//        safariViewController.delegate = self
//        present(safariViewController, animated: true)
//    }
//    
//    // MARK: SEGMENT CONTROL VALUE CHANGED:
//
//    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
//        VibrationManager.instance.vibrationStandart()
//        if sender.selectedSegmentIndex == 0 {
//            requestSkydiversFirebase()
//            skydiversTableView.isHidden = false
//            partnersTableView.isHidden = true
//        } else if sender.selectedSegmentIndex == 1 {
//            requestPartnersFirebase()
//            skydiversTableView.isHidden = true
//            partnersTableView.isHidden = false
//        }
//    }
//}
//
//// MARK: - EXTENSION:
//
//extension SkydiversVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == skydiversTableView {
//            return arraySkydivers.count
//        } else if tableView == partnersTableView {
//            return arrayPartners.count
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == skydiversTableView {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkydiversCell", for: indexPath) as? SkydiversCell else { return UITableViewCell() }
//            let skydiver = arraySkydivers[indexPath.row]
//            cell.configureModel(skydiver: skydiver)
//            if skydiver.photos.isEmpty {
//                cell.showActivityIndicator()
//            } else {
//                cell.configurePhotos(photos: skydiver.photos)
//            }
//            cell.backgroundColor = .clear
//            cell.delegate = self
//            return cell
//        } else if tableView == partnersTableView {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PartnersCell", for: indexPath) as? PartnersCell else { return UITableViewCell() }
//            let partner = arrayPartners[indexPath.row]
//            cell.configureModel(partner: partner)
//            if partner.photos.isEmpty {
//                cell.showActivityIndicator()
//            } else {
//                cell.configurePhotos(photos: partner.photos)
//            }
//            cell.backgroundColor = .clear
//            cell.delegate = self
//            return cell
//        }
//        return UITableViewCell()
//    }
//}
//
//// MARK: - EXTENSION FOR SAFARI:
//
//extension SkydiversVC: SFSafariViewControllerDelegate {
//    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
//        print("Open in Safari app")
//    }
//}
//
//// MARK: - EXTENSION FOR SAFARI:
//
//extension SkydiversVC: SkydiversCellDelegate, PartnersCellDelegate {
//    func tapLinkButton(link: String) {
//        VibrationManager.instance.vibrationStandart()
//        guard let url = URL(string: link) else { return }
//        let safariViewController = SFSafariViewController(url: url)
//        safariViewController.delegate = self
//        present(safariViewController, animated: true)
//    }
//}
