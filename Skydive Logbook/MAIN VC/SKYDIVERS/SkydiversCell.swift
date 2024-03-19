import Firebase
import FirebaseStorage
import Lottie
import UIKit

protocol SkydiversCellDelegate: AnyObject {
    func tapLinkButton(link: String)
}

final class SkydiversCell: UITableViewCell {
    // MARK: - PRIVATE PROPERTIES:

    private let containerView = UIView()
    private let firstPlaceLottie = LottieAnimationView(name: "FirstPlace")
    private let secondPlaceLottie = LottieAnimationView(name: "SecondPlace")
    private let thirdPlaceLottie = LottieAnimationView(name: "ThirdPlace")
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = UICollectionViewFlowLayout()
    private let ratingLabel = UILabel()
    private let ratingValueLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let nicknameValueLabel = UILabel()
    private let countryFlagLabel = UILabel()
    private let countryLabel = UILabel()
    private let countryValueLabel = UILabel()
    private let professionLabel = UILabel()
    private let countJumpsValueLabel = UILabel()
    private let dateFirstJumpLabel = UILabel()
    private let linkButton = UIButton()
    private var photos = [UIImage]()
    private var link: String = ""
    weak var delegate: SkydiversCellDelegate?

    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 280, height: 300)
        collectionView.collectionViewLayout = layout
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
        containerView.addSubviews(firstPlaceLottie, secondPlaceLottie, thirdPlaceLottie, ratingLabel, ratingValueLabel, nicknameLabel, nicknameValueLabel, countryFlagLabel, countryLabel, countryValueLabel, collectionView, professionLabel, countJumpsValueLabel, dateFirstJumpLabel, linkButton)
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

        // MARK: RATING LABEL:

        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 3).isActive = true
        ratingLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        // MARK: RATING VALUE LABEL:

        ratingValueLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingValueLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: -3).isActive = true
        ratingValueLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

        // MARK: NICKNAME LABEL:

        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.bottomAnchor.constraint(equalTo: nicknameValueLabel.topAnchor, constant: 0).isActive = true
        nicknameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: NICKNAME VALUE LABEL:

        nicknameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameValueLabel.topAnchor.constraint(equalTo: ratingValueLabel.bottomAnchor, constant: 5).isActive = true
        nicknameValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: COUNTRY LABEL:

        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.bottomAnchor.constraint(equalTo: countryValueLabel.topAnchor, constant: 0).isActive = true
        countryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true

        // MARK: COUNTRY VALUE LABEL:

        countryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        countryValueLabel.topAnchor.constraint(equalTo: ratingValueLabel.bottomAnchor, constant: 5).isActive = true
        countryValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true

        // MARK: COUNTRY FLAG IMAGE:

        countryFlagLabel.translatesAutoresizingMaskIntoConstraints = false
        countryFlagLabel.topAnchor.constraint(equalTo: ratingValueLabel.bottomAnchor, constant: 5).isActive = true
        countryFlagLabel.trailingAnchor.constraint(equalTo: countryValueLabel.leadingAnchor, constant: -2).isActive = true
        countryFlagLabel.heightAnchor.constraint(equalTo: countryValueLabel.heightAnchor, multiplier: 1).isActive = true

        // MARK: COLLECTION VIEW:

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: nicknameValueLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true

        // MARK: PROFESSION LABEL:

        professionLabel.translatesAutoresizingMaskIntoConstraints = false
        professionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 9).isActive = true
        professionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: COUNT JUMPS LABEL:

        countJumpsValueLabel.translatesAutoresizingMaskIntoConstraints = false
        countJumpsValueLabel.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 0).isActive = true
        countJumpsValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: DATE FIRST JUMP LABEL:

        dateFirstJumpLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFirstJumpLabel.topAnchor.constraint(equalTo: countJumpsValueLabel.bottomAnchor, constant: 0).isActive = true
        dateFirstJumpLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true

        // MARK: LINK BUTTON:

        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        linkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        linkButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        linkButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        linkButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        contentView.backgroundColor = .clear

        // MARK: CONTAINER VIEW:

        containerView.layer.cornerRadius = cornerRadius15
        containerView.backgroundColor = .colorCell

        // MARK: PLACES LOTTIES:

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

        // MARK: RATING LABEL:

        ratingLabel.text = NSLocalizedString("Rating / skydivers", comment: "") + ":"
        ratingLabel.textAlignment = .center
        ratingLabel.font = fontMediumStandard12
        ratingLabel.textColor = .colorLightGray

        // MARK: RATING VALUE LABEL:

        ratingValueLabel.textColor = .colorWhite
        ratingValueLabel.textAlignment = .center
        ratingValueLabel.font = fontBoldStandard30
        ratingValueLabel.adjustsFontSizeToFitWidth = true

        // MARK: NICKNAME LABEL:

        nicknameLabel.text = NSLocalizedString("Nickname / skydivers", comment: "") + ":"
        nicknameLabel.textAlignment = .center
        nicknameLabel.font = fontMediumStandard12
        nicknameLabel.textColor = .colorLightGray

        // MARK: NICKNAME VALUE LABEL:

        nicknameValueLabel.textColor = .colorWhite
        nicknameValueLabel.textAlignment = .left
        nicknameValueLabel.font = fontBoldStandard16
        nicknameValueLabel.adjustsFontSizeToFitWidth = true

        // MARK: COUNTRY LABEL:

        countryLabel.text = NSLocalizedString("Country / skydivers", comment: "") + ":"
        countryLabel.textAlignment = .center
        countryLabel.font = fontMediumStandard12
        countryLabel.textColor = .colorLightGray

        // MARK: COUNTRY VALUE LABEL:

        countryValueLabel.textColor = .colorWhite
        countryValueLabel.textAlignment = .right
        countryValueLabel.font = fontBoldStandard16
        countryValueLabel.adjustsFontSizeToFitWidth = true

        // MARK: COUNTRY FLAG LABEL:

        countryFlagLabel.textAlignment = .left
        countryFlagLabel.font = fontBoldStandard16
        countryFlagLabel.adjustsFontSizeToFitWidth = true

        // MARK: COLLECTION VIEW:

        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .clear

        // MARK: COUNT JUMPS LABEL:

        countJumpsValueLabel.textColor = .colorWhite
        countJumpsValueLabel.textAlignment = .left
        countJumpsValueLabel.font = fontRegularStandard12
        countJumpsValueLabel.adjustsFontSizeToFitWidth = true

        // MARK: DATE FIRST JUMP LABEL:

        dateFirstJumpLabel.textColor = .colorWhite
        dateFirstJumpLabel.textAlignment = .left
        dateFirstJumpLabel.font = fontRegularStandard12
        dateFirstJumpLabel.adjustsFontSizeToFitWidth = true

        // MARK: PROFESSION LABEL:

        professionLabel.textColor = .colorWhite
        professionLabel.textAlignment = .left
        professionLabel.font = fontRegularStandard12
        professionLabel.adjustsFontSizeToFitWidth = true

        // MARK: LINK BUTTON:

        linkButton.setTitle(NSLocalizedString("Profile / skydivers", comment: ""), for: .normal)
        linkButton.titleLabel?.font = fontMediumStandard14
        linkButton.setTitleColor(.colorWhite, for: .normal)
        linkButton.backgroundColor = .colorGreen
        linkButton.layer.masksToBounds = true
        linkButton.layer.cornerRadius = cornerRadius15
        linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
    }

    // MARK: - CONFIGURE COLLECTION VIEW:

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.isScrollEnabled = true
    }

    // MARK: - HELPERS:

    // MARK: CONFIGURE MODEL:

    func configureModel(skydiver: Skydiver) {
        ratingValueLabel.text = String(skydiver.rating)
        nicknameValueLabel.text = skydiver.nickname.uppercased()
        countryValueLabel.text = skydiver.countryName.uppercased()
        countryFlagLabel.text = skydiver.countryFlag
        professionLabel.text = NSLocalizedString("Profession / skydivers", comment: "") + ": " + skydiver.profession
        countJumpsValueLabel.text = NSLocalizedString("Count of jumps / skydivers", comment: "") + ": " + skydiver.countJumps
        dateFirstJumpLabel.text = NSLocalizedString("First jump / skydivers", comment: "") + ": " + skydiver.firstJump
        link = skydiver.link
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

    // MARK: CONFIGURE 1,2,3 PLACES CELL:

    func configurePlacesCell(index: IndexPath?) {
        guard let index = index else { return }
        firstPlaceLottie.isHidden = true
        secondPlaceLottie.isHidden = true
        thirdPlaceLottie.isHidden = true
        if index.row == 0 {
            containerView.backgroundColor = #colorLiteral(red: 0.7621314526, green: 0.5825900435, blue: 0.2354111075, alpha: 1)
            firstPlaceLottie.isHidden = false
            nicknameLabel.textColor = .black
            nicknameValueLabel.textColor = .white
            countryLabel.textColor = .black
            countryValueLabel.textColor = .white
            ratingLabel.textColor = .black
            ratingValueLabel.textColor = .white
            professionLabel.textColor = .white
            countJumpsValueLabel.textColor = .white
            dateFirstJumpLabel.textColor = .white
            linkButton.setTitleColor(.white, for: .normal)
        } else if index.row == 1 {
            containerView.backgroundColor = #colorLiteral(red: 0.5784137249, green: 0.6185954809, blue: 0.6074234843, alpha: 1)
            secondPlaceLottie.isHidden = false
            nicknameLabel.textColor = .black
            nicknameValueLabel.textColor = .white
            countryLabel.textColor = .black
            countryValueLabel.textColor = .white
            ratingLabel.textColor = .black
            ratingValueLabel.textColor = .white
            professionLabel.textColor = .white
            countJumpsValueLabel.textColor = .white
            dateFirstJumpLabel.textColor = .white
            linkButton.setTitleColor(.white, for: .normal)
        } else if index.row == 2 {
            containerView.backgroundColor = #colorLiteral(red: 0.7442381978, green: 0.3936595917, blue: 0.2051987648, alpha: 1)
            thirdPlaceLottie.isHidden = false
            nicknameLabel.textColor = .black
            nicknameValueLabel.textColor = .white
            countryLabel.textColor = .black
            countryValueLabel.textColor = .white
            ratingLabel.textColor = .black
            ratingValueLabel.textColor = .white
            professionLabel.textColor = .white
            countJumpsValueLabel.textColor = .white
            dateFirstJumpLabel.textColor = .white
            linkButton.setTitleColor(.white, for: .normal)
        } else {
            containerView.backgroundColor = .colorCell
            nicknameValueLabel.textColor = .colorWhite
            countryValueLabel.textColor = .colorWhite
            ratingValueLabel.textColor = .colorWhite
            professionLabel.textColor = .colorWhite
            countJumpsValueLabel.textColor = .colorWhite
            dateFirstJumpLabel.textColor = .colorWhite
            linkButton.setTitleColor(.white, for: .normal)
        }
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

    // MARK: DELEGATE:

    @objc private func linkButtonTapped() {
        delegate?.tapLinkButton(link: link)
    }
}

// MARK: - EXTENSION:

extension SkydiversCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: COUNT IMAGES:

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    // MARK: CUSTOM CELL:

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        imageCell.setImage(photos[indexPath.row])
        return imageCell
    }
}

// MARK: - EXTENSION:

extension SkydiversCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.center = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.midY)
    }
}
