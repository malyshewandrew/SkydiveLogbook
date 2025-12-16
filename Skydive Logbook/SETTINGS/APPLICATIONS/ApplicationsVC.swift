import SafariServices
import UIKit
import WebKit

let applicationsArray: [ApplicationModel] = [ApplicationModel(title: "SkydiveBook",
                                                              description: NSLocalizedString("SkydiveBook / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/skydive-book/id6478469415",
                                                              photo: UIImage(resource: .skydiveBook)),
                                             ApplicationModel(title: "PulseFM",
                                                              description: NSLocalizedString("PulseFM / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/pulsefm-belarus/id6743941514",
                                                              photo: UIImage(resource: .pulseFM)),
                                             ApplicationModel(title: "Link Holder",
                                                              description: NSLocalizedString("Link Holder / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/link-holder/id6748039009",
                                                              photo: UIImage(resource: .linkHolder)),
                                             ApplicationModel(title: "RacersX",
                                                              description: NSLocalizedString("RacersX / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/racersx/id6503201749",
                                                              photo: UIImage(resource: .racersX)),
                                             ApplicationModel(title: "GalactriX",
                                                              description: NSLocalizedString("GalactriX / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/galactrix/id6483000958",
                                                              photo: UIImage(resource: .galactriX)),
                                             ApplicationModel(title: "BirthdayDate",
                                                              description: NSLocalizedString("BirthdayDate / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/birthdaydate/id6477539640",
                                                              photo: UIImage(resource: .birthdayDate)),
                                             ApplicationModel(title: "MovieNotes",
                                                              description: NSLocalizedString("MovieNotes / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/movienotes/id6477357057",
                                                              photo: UIImage(resource: .movieNotes)),
                                             ApplicationModel(title: "ArtImageView",
                                                              description: NSLocalizedString("ArtImageView / applications", comment: ""),
                                                              link: "https://apps.apple.com/by/app/artimageview/id6503667972",
                                                              photo: UIImage(resource: .artImageView))]

final class ApplicationsViewController: UIViewController {
    // MARK: - PROPERTIES:

    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.textAlignment = .center
        obj.text = NSLocalizedString("Title / applications", comment: "")
        obj.font = FontManager.bold(size: 26).uiFont
        return obj
    }()
    private let tableView: UITableView = {
        let obj = UITableView()
        obj.backgroundColor = .colorBackground
        obj.separatorStyle = .none
        return obj
    }()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(titleLabel, tableView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: TITLE LABEL:
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // VIEW:
        view.backgroundColor = .colorBackground
        
        // MARK: TABLE VIEW:

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ApplicationTableViewCell.self, forCellReuseIdentifier: ApplicationTableViewCell.id)
    }
    
    // MARK: - HELPERS:
}

// MARK: - EXTENSIONS:

extension ApplicationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        applicationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.id, for: indexPath) as? ApplicationTableViewCell else { return UITableViewCell() }
        let application = applicationsArray[indexPath.row]
        cell.configure(application: application)
        cell.installButton.addAction(UIAction(handler: { [weak self] _ in
            VibrationManager.instance.vibrationStandart()
            
            guard let self = self else { return }
            let application = applicationsArray[indexPath.row].link
            
            guard let url = URL(string: application) else {
                return
            }
            
            let safaviViewController = SFSafariViewController(url: url)
            safaviViewController.delegate = self
            self.present(safaviViewController, animated: true)
            
        }), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VibrationManager.instance.vibrationStandart()
        let application = applicationsArray[indexPath.row].link
        
        guard let url = URL(string: application) else {
            return
        }
        
        let safaviViewController = SFSafariViewController(url: url)
        safaviViewController.delegate = self
        present(safaviViewController, animated: true)
    }
}

// MARK: - EXTENSION:

extension ApplicationsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {
        print("Open in Safari app")
    }
}
