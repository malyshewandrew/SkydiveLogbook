import Firebase
import FirebaseStorage
import Lottie
import UIKit

protocol PartnersCellDelegate: AnyObject {
    func tapLinkButton(link: String)
}

final class PartnersCell: UITableViewCell {
    // MARK: - PRIVATE PROPERTIES:

    private let containerView = UIView()
    private let firstPlaceLottie = LottieAnimationView(name: "FirstPlace")
    private let secondPlaceLottie = LottieAnimationView(name: "SecondPlace")
    private let thirdPlaceLottie = LottieAnimationView(name: "ThirdPlace")
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = UICollectionViewFlowLayout()
    private let nicknameLabel = UILabel()
    private let nicknameValueLabel = UILabel()
    private let countryFlagLabel = UILabel()
    private let countryLabel = UILabel()
    private let countryValueLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let countJumpsValueLabel = UILabel()
    private let linkButton = UIButton()
    private var photos = [UIImage]()
    private var link: String = ""
    weak var delegate: PartnersCellDelegate?

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 300)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureUI()
        configureCollectionView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(containerView)
        containerView.addSubviews(firstPlaceLottie, secondPlaceLottie, thirdPlaceLottie, nicknameLabel, nicknameValueLabel, countryFlagLabel, countryLabel, countryValueLabel, collectionView, descriptionLabel, countJumpsValueLabel, linkButton)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: CONTAINER VIEW:

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true

        // MARK: PLACES LOTTIES:

        firstPlaceLottie.translatesAutoresizingMaskIntoConstraints = false
        firstPlaceLottie.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        firstPlaceLottie.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        firstPlaceLottie.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstPlaceLottie.widthAnchor.constraint(equalToConstant: 40).isActive = true

        secondPlaceLottie.translatesAutoresizingMaskIntoConstraints = false
        secondPlaceLottie.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        secondPlaceLottie.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        secondPlaceLottie.heightAnchor.constraint(equalToConstant: 50).isActive = true
        secondPlaceLottie.widthAnchor.constraint(equalToConstant: 50).isActive = true

        thirdPlaceLottie.translatesAutoresizingMaskIntoConstraints = false
        thirdPlaceLottie.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        thirdPlaceLottie.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        thirdPlaceLottie.heightAnchor.constraint(equalToConstant: 50).isActive = true
        thirdPlaceLottie.widthAnchor.constraint(equalToConstant: 50).isActive = true

        // MARK: NICKNAME LABEL:

        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        nicknameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: NICKNAME VALUE LABEL:

        nicknameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameValueLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor).isActive = true
        nicknameValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: COUNTRY LABEL:

        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true

        // MARK: COUNTRY VALUE LABEL:

        countryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        countryValueLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor).isActive = true
        countryValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true

        // MARK: COUNTRY FLAG IMAGE:

        countryFlagLabel.translatesAutoresizingMaskIntoConstraints = false
        countryFlagLabel.centerYAnchor.constraint(equalTo: countryValueLabel.centerYAnchor).isActive = true
        countryFlagLabel.trailingAnchor.constraint(equalTo: countryValueLabel.leadingAnchor, constant: -2).isActive = true
        countryFlagLabel.heightAnchor.constraint(equalTo: countryValueLabel.heightAnchor, multiplier: 1).isActive = true

        // MARK: COLLECTION VIEW:

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: nicknameValueLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true

        // MARK: DESCRIPTION LABEL:

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 9).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: linkButton.leadingAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true

        // MARK: COUNT JUMPS LABEL:

        countJumpsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        countJumpsValueLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 0).isActive = true
        countJumpsValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: LINK BUTTON:

        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        linkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        linkButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        contentView.backgroundColor = .clear
        selectionStyle = .none

        containerView.layer.cornerRadius = cornerRadius15
        containerView.backgroundColor = .colorCell

        firstPlaceLottie.play()
        firstPlaceLottie.loopMode = .loop
        firstPlaceLottie.isHidden = true
        secondPlaceLottie.play()
        secondPlaceLottie.loopMode = .playOnce
        secondPlaceLottie.animationSpeed = 0.6
        secondPlaceLottie.isHidden = true
        thirdPlaceLottie.play()
        thirdPlaceLottie.loopMode = .playOnce
        thirdPlaceLottie.animationSpeed = 0.6
        thirdPlaceLottie.isHidden = true

        nicknameLabel.text = NSLocalizedString("Community / name", comment: "") + ":"
        nicknameLabel.textAlignment = .center
        nicknameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nicknameLabel.textColor = .lightGray

        nicknameValueLabel.textColor = .white
        nicknameValueLabel.textAlignment = .left
        nicknameValueLabel.font = .boldSystemFont(ofSize: 16)
        nicknameValueLabel.adjustsFontSizeToFitWidth = true

        countryLabel.text = NSLocalizedString("Country / skydivers", comment: "") + ":"
        countryLabel.textAlignment = .center
        countryLabel.font = .systemFont(ofSize: 12, weight: .medium)
        countryLabel.textColor = .lightGray

        countryValueLabel.textColor = .white
        countryValueLabel.textAlignment = .right
        countryValueLabel.font = .boldSystemFont(ofSize: 16)
        countryValueLabel.adjustsFontSizeToFitWidth = true

        countryFlagLabel.textAlignment = .right
        countryFlagLabel.font = .systemFont(ofSize: 16)
        countryFlagLabel.adjustsFontSizeToFitWidth = true

        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .clear

        // MARK: COUNT JUMPS LABEL:

        countJumpsValueLabel.textColor = .colorWhite
        countJumpsValueLabel.textAlignment = .left
        countJumpsValueLabel.font = AppFont.regular(size: 12).uiFont
        countJumpsValueLabel.adjustsFontSizeToFitWidth = true

        // MARK: DESCRIPTION LABEL:

        descriptionLabel.textColor = .colorWhite
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = AppFont.regular(size: 12).uiFont
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.numberOfLines = 0

        // MARK: LINK BUTTON:

        linkButton.setTitle(NSLocalizedString("Profile / skydivers", comment: ""), for: .normal)
        linkButton.titleLabel?.font = AppFont.medium(size: 14).uiFont
        linkButton.setTitleColor(.colorWhite, for: .normal)
        linkButton.setTitleColor(.colorBackground, for: .highlighted)
        linkButton.backgroundColor = .colorGreen
        linkButton.layer.masksToBounds = true
        linkButton.layer.cornerRadius = cornerRadius15
        linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
    }

    // MARK: - CONFIGURE COLLECTION VIEW:

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PartnersCollectionViewCell.self, forCellWithReuseIdentifier: "PartnersCollectionViewCell")
    }

    // MARK: - SETUP CELL:

    func configureModel(partner: Partner) {
        nicknameValueLabel.text = partner.nickname.uppercased()
        countryValueLabel.text = partner.countryName.uppercased()
        countryFlagLabel.text = partner.countryFlag
        descriptionLabel.text = partner.description
        link = partner.link
    }

    // MARK: CONFIGURE PHOTOS:

    func configurePhotos(photos: [UIImage]) {
        for subview in collectionView.subviews {
            subview.removeFromSuperview()
        }
        self.photos = photos
        collectionView.reloadData()
        hideActivityIndicator()
    }
    
    // MARK: SHOW ACTIVITY INDICATOR:

    func showActivityIndicator() {
        collectionView.addSubview(activityIndicator)
        activityIndicator.center = collectionView.center
        activityIndicator.startAnimating()
    }

    // MARK: HIDE ACTIVITY INDICATOR:

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    // MARK: - ACTIONS:

    @objc private func linkButtonTapped() {
        delegate?.tapLinkButton(link: link)
    }
}

// MARK: - COLLECTION VIEW DELEGATE AND DATA SOURCE:

extension PartnersCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartnersCollectionViewCell", for: indexPath) as? PartnersCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setImage(photos[indexPath.item])
        return cell
    }
}
