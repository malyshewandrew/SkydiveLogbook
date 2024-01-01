import UIKit

final class SystemCell: UITableViewCell {
    // MARK: - PROPERTIES:

    private let containerView = UIView()
    private let editButton = UIButton()
    
    private let systemNameLabel = UILabel()
    
    private let containerLabel = UILabel()
    private let containerNameLabel = UILabel()
    private let containerSerialNumberLabel = UILabel()
    private let containerDomLabel = UILabel()
    private let containerServiceLifeYearsLabel = UILabel()
    private let containerExpirationDateLabel = UILabel()
    
    private let aadLabel = UILabel()
    private let aadNameLabel = UILabel()
    private let aadSerialNumberLabel = UILabel()
    private let aadDomLabel = UILabel()
    private let aadServiceLifeYearsLabel = UILabel()
    private let aadExpirationDateLabel = UILabel()
    
    private let mainCanopyLabel = UILabel()
    private let mainCanopyNameLabel = UILabel()
    private let mainCanopySerialNumberLabel = UILabel()
    private let mainCanopyDomLabel = UILabel()
    private let mainCanopyServiceLifeYearsLabel = UILabel()
    private let mainCanopyServiceLifeJumpsLabel = UILabel()
    private let mainCanopyCountJumpsLabel = UILabel()
    private let mainCanopyExpirationDateLabel = UILabel()
    private let mainCanopyRemainedCountLabel = UILabel()
    
    private let reserveCanopyLabel = UILabel()
    private let reserveCanopyNameLabel = UILabel()
    private let reserveCanopySerialNumberLabel = UILabel()
    private let reserveCanopyDomLabel = UILabel()
    private let reserveCanopyServiceLifeYearsLabel = UILabel()
    private let reserveCanopyCountRepackLabel = UILabel()
    private let reserveCanopyDatePackLabel = UILabel()
    private let reserveCanopyExpirationDateLabel = UILabel()
    
    private let systemCommentLabel = UILabel()
    
    var tapEditButton: (() -> ())?
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    override func prepareForReuse() {}

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(containerView)
        containerView.addSubviews(editButton, systemNameLabel,
                                  
                                  containerLabel, containerNameLabel, containerSerialNumberLabel, containerDomLabel, containerServiceLifeYearsLabel, containerExpirationDateLabel,
                                  
                                  aadLabel, aadNameLabel, aadSerialNumberLabel, aadDomLabel, aadServiceLifeYearsLabel, aadExpirationDateLabel,
                                  
                                  mainCanopyLabel, mainCanopyNameLabel, mainCanopySerialNumberLabel, mainCanopyDomLabel, mainCanopyServiceLifeYearsLabel, mainCanopyServiceLifeJumpsLabel, mainCanopyCountJumpsLabel, mainCanopyExpirationDateLabel, mainCanopyRemainedCountLabel,
                                  
                                  reserveCanopyLabel, reserveCanopyNameLabel, reserveCanopySerialNumberLabel, reserveCanopyDomLabel, reserveCanopyServiceLifeYearsLabel, reserveCanopyCountRepackLabel, reserveCanopyDatePackLabel, reserveCanopyExpirationDateLabel,
                                  systemCommentLabel)
    }

    // MARK: - CONFIGURE CONSTRAINTS:

    private func configureConstraints() {
        // MARK: CONTAINER VIEW:

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        // MARK: EDIT BUTTON:

        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        editButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        editButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2).isActive = true
        
        // MARK: SYSTEM NAME:
        
        systemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        systemNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        systemNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        systemNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        systemNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: CONTAINER LABEL:
        
        containerLabel.translatesAutoresizingMaskIntoConstraints = false
        containerLabel.topAnchor.constraint(equalTo: systemNameLabel.bottomAnchor, constant: 15).isActive = true
        containerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        containerLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        containerLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        // MARK: CONTAINER NAME:

        containerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerNameLabel.topAnchor.constraint(equalTo: containerLabel.bottomAnchor, constant: 0).isActive = true
        containerNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        containerNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        containerNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // MARK: CONTAINER SERIAL NUMBER:

        containerSerialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        containerSerialNumberLabel.topAnchor.constraint(equalTo: containerNameLabel.bottomAnchor, constant: 5).isActive = true
        containerSerialNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        containerSerialNumberLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        containerSerialNumberLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: CONTAINER DOM:

        containerDomLabel.translatesAutoresizingMaskIntoConstraints = false
        containerDomLabel.topAnchor.constraint(equalTo: containerSerialNumberLabel.bottomAnchor, constant: 0).isActive = true
        containerDomLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        containerDomLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        containerDomLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: CONTAINER SERVICE LIFE YEARS:
        
        containerServiceLifeYearsLabel.translatesAutoresizingMaskIntoConstraints = false
        containerServiceLifeYearsLabel.topAnchor.constraint(equalTo: containerDomLabel.bottomAnchor, constant: 0).isActive = true
        containerServiceLifeYearsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        containerServiceLifeYearsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        containerServiceLifeYearsLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true

        // MARK: CONTAINER EXPIRATION DATE:
        
        containerExpirationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerExpirationDateLabel.topAnchor.constraint(equalTo: containerServiceLifeYearsLabel.bottomAnchor, constant: 0).isActive = true
        containerExpirationDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        containerExpirationDateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        containerExpirationDateLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: AAD LABEL:
        
        aadLabel.translatesAutoresizingMaskIntoConstraints = false
        aadLabel.topAnchor.constraint(equalTo: systemNameLabel.bottomAnchor, constant: 15).isActive = true
        aadLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        aadLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        aadLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        // MARK: AAD NAME:

        aadNameLabel.translatesAutoresizingMaskIntoConstraints = false
        aadNameLabel.topAnchor.constraint(equalTo: aadLabel.bottomAnchor, constant: 0).isActive = true
        aadNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        aadNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        aadNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // MARK: AAD SERIAL NUMBER:
        
        aadSerialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        aadSerialNumberLabel.topAnchor.constraint(equalTo: aadNameLabel.bottomAnchor, constant: 5).isActive = true
        aadSerialNumberLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        aadSerialNumberLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        aadSerialNumberLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: AAD DOM:

        aadDomLabel.translatesAutoresizingMaskIntoConstraints = false
        aadDomLabel.topAnchor.constraint(equalTo: aadSerialNumberLabel.bottomAnchor, constant: 0).isActive = true
        aadDomLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        aadDomLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        aadDomLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: AAD SERVICE YEARS:
        
        aadServiceLifeYearsLabel.translatesAutoresizingMaskIntoConstraints = false
        aadServiceLifeYearsLabel.topAnchor.constraint(equalTo: aadDomLabel.bottomAnchor, constant: 0).isActive = true
        aadServiceLifeYearsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        aadServiceLifeYearsLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        aadServiceLifeYearsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: AAD EXPIRATION DATE:
        
        aadExpirationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        aadExpirationDateLabel.topAnchor.constraint(equalTo: aadServiceLifeYearsLabel.bottomAnchor, constant: 0).isActive = true
        aadExpirationDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        aadExpirationDateLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        aadExpirationDateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: MAIN CANOPY LABEL:
        
        mainCanopyLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyLabel.topAnchor.constraint(equalTo: containerExpirationDateLabel.bottomAnchor, constant: 30).isActive = true
        mainCanopyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        // MARK: MAIN CANOPY NAME:

        mainCanopyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyNameLabel.topAnchor.constraint(equalTo: mainCanopyLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // MARK: MAIN CANOPY SERIAL NUMBER:
        
        mainCanopySerialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopySerialNumberLabel.topAnchor.constraint(equalTo: mainCanopyNameLabel.bottomAnchor, constant: 5).isActive = true
        mainCanopySerialNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopySerialNumberLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        mainCanopySerialNumberLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: MAIN CANOPY DOM:

        mainCanopyDomLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyDomLabel.topAnchor.constraint(equalTo: mainCanopySerialNumberLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyDomLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyDomLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        mainCanopyDomLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: MAIN CANOPY SERVICE LIFE YEARS:
        
        mainCanopyServiceLifeYearsLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyServiceLifeYearsLabel.topAnchor.constraint(equalTo: mainCanopyDomLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyServiceLifeYearsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyServiceLifeYearsLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyServiceLifeYearsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: MAIN CANOPY EXPIRATION DATE:
        
        mainCanopyExpirationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyExpirationDateLabel.topAnchor.constraint(equalTo: mainCanopyServiceLifeYearsLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyExpirationDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyExpirationDateLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyExpirationDateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: MAIN CANOPY SERVICE LIFE JUMPS:
        
        mainCanopyServiceLifeJumpsLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyServiceLifeJumpsLabel.topAnchor.constraint(equalTo: mainCanopyExpirationDateLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyServiceLifeJumpsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyServiceLifeJumpsLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyServiceLifeJumpsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: MAIN CANOPY COUNT JUMP:

        mainCanopyCountJumpsLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyCountJumpsLabel.topAnchor.constraint(equalTo: mainCanopyServiceLifeJumpsLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyCountJumpsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyCountJumpsLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyCountJumpsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: MAIN CANOPY REMAINED COUNT
        
        mainCanopyRemainedCountLabel.translatesAutoresizingMaskIntoConstraints = false
        mainCanopyRemainedCountLabel.topAnchor.constraint(equalTo: mainCanopyCountJumpsLabel.bottomAnchor, constant: 0).isActive = true
        mainCanopyRemainedCountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainCanopyRemainedCountLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        mainCanopyRemainedCountLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: RESERVE CANOPY LABEL:
        
        reserveCanopyLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyLabel.topAnchor.constraint(equalTo: aadExpirationDateLabel.bottomAnchor, constant: 30).isActive = true
        reserveCanopyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        reserveCanopyLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        // MARK: RESERVE CANOPY NAME:

        reserveCanopyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyNameLabel.topAnchor.constraint(equalTo: reserveCanopyLabel.bottomAnchor, constant: 0).isActive = true
        reserveCanopyNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        reserveCanopyNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // MARK: RESERVE CANOPY SERIAL NUMBER:
        
        reserveCanopySerialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopySerialNumberLabel.topAnchor.constraint(equalTo: reserveCanopyNameLabel.bottomAnchor, constant: 5).isActive = true
        reserveCanopySerialNumberLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopySerialNumberLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        reserveCanopySerialNumberLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        
        // MARK: RESERVE CANOPY DOM:

        reserveCanopyDomLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDomLabel.topAnchor.constraint(equalTo: reserveCanopySerialNumberLabel.bottomAnchor, constant: 0).isActive = true
        reserveCanopyDomLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyDomLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        reserveCanopyDomLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
    
        // MARK: RESERVE CANOPY SERVICE LIFE YEARS:
        
        reserveCanopyServiceLifeYearsLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyServiceLifeYearsLabel.topAnchor.constraint(equalTo: reserveCanopyDomLabel.bottomAnchor, constant: 0).isActive = true
        reserveCanopyServiceLifeYearsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyServiceLifeYearsLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        reserveCanopyServiceLifeYearsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: RESERVE CANOPY EXPIRATION DATE:
        
        reserveCanopyExpirationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyExpirationDateLabel.topAnchor.constraint(equalTo: reserveCanopyServiceLifeYearsLabel.bottomAnchor, constant: 0).isActive = true
        reserveCanopyExpirationDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyExpirationDateLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        reserveCanopyExpirationDateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: RESERVE CANOPY COUNT REPACK:

        reserveCanopyCountRepackLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyCountRepackLabel.topAnchor.constraint(equalTo: reserveCanopyExpirationDateLabel.bottomAnchor, constant: 0).isActive = true
        reserveCanopyCountRepackLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyCountRepackLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        reserveCanopyCountRepackLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: RESERVE CANOPY COUNT DATE PACK:

        reserveCanopyDatePackLabel.translatesAutoresizingMaskIntoConstraints = false
        reserveCanopyDatePackLabel.topAnchor.constraint(equalTo: reserveCanopyCountRepackLabel.bottomAnchor, constant: 0).isActive = true
        reserveCanopyDatePackLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        reserveCanopyDatePackLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45).isActive = true
        reserveCanopyDatePackLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        // MARK: SYSTEM COMMENT:

        systemCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        systemCommentLabel.topAnchor.constraint(equalTo: mainCanopyRemainedCountLabel.bottomAnchor, constant: 5).isActive = true
        systemCommentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        systemCommentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        systemCommentLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: CONTENT VIEW:

        selectionStyle = .none
        contentView.backgroundColor = colorBackground

        // MARK: CONTAINER VIEW:

        containerView.backgroundColor = colorTabBar
        containerView.layer.cornerRadius = 10
        
        // MARK: EDIT BUTTON:

        editButton.setTitle(NSLocalizedString("Edit", comment: ""), for: .normal)
        editButton.setTitleColor(colorBlue, for: .normal)
        editButton.addTarget(self, action: #selector(tapOnEditButton), for: .touchUpInside)
        
        // MARK: SYSTEM NAME:
        
        systemNameLabel.textColor = colorWhite
        systemNameLabel.font = fontBoldStandart20
        systemNameLabel.textAlignment = .center
        systemNameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CONTAINER LABEL:
        
        containerLabel.text = "Ранец:".uppercased()
        containerLabel.textColor = colorLightGray
        containerLabel.font = fontBoldStandart10
        containerLabel.textAlignment = .left
        containerLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CONTAINER NAME:

        containerNameLabel.textColor = colorWhite
        containerNameLabel.font = fontBoldStandart22
        containerNameLabel.textAlignment = .left
        containerNameLabel.numberOfLines = 0
        containerNameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CONTAINER SERIAL NUMBER:

        containerSerialNumberLabel.textColor = colorWhite
        containerSerialNumberLabel.font = fontRegularStandart12
        containerSerialNumberLabel.textAlignment = .left
        containerSerialNumberLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CONTAINER DOM:

        containerDomLabel.textColor = colorWhite
        containerDomLabel.font = fontRegularStandart12
        containerDomLabel.textAlignment = .left
        containerDomLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CONTAINER SERVICE LIFE YEARS:
        
        containerServiceLifeYearsLabel.textColor = colorWhite
        containerServiceLifeYearsLabel.font = fontRegularStandart12
        containerServiceLifeYearsLabel.textAlignment = .left
        
        // MARK: CONTAINER EXPIRATION DATE:
        
        containerExpirationDateLabel.textColor = colorWhite
        containerExpirationDateLabel.font = fontRegularStandart12
        containerExpirationDateLabel.textAlignment = .left
        
        // MARK: AAD LABEL:
        
        aadLabel.text = "Страхующий прибор:".uppercased()
        aadLabel.textColor = colorLightGray
        aadLabel.font = fontBoldStandart10
        aadLabel.textAlignment = .right
        aadLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AAD NAME:

        aadNameLabel.textColor = colorWhite
        aadNameLabel.font = fontBoldStandart22
        aadNameLabel.textAlignment = .right
        aadNameLabel.numberOfLines = 0
        aadNameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AAD SERIAL NUMBER:
        
        aadSerialNumberLabel.textColor = colorWhite
        aadSerialNumberLabel.font = fontRegularStandart12
        aadSerialNumberLabel.textAlignment = .right
        aadSerialNumberLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AAD DOM:

        aadDomLabel.textColor = colorWhite
        aadDomLabel.font = fontRegularStandart12
        aadDomLabel.textAlignment = .right
        aadDomLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AAD EXPIRATION DATE:
        
        aadExpirationDateLabel.textColor = colorWhite
        aadExpirationDateLabel.font = fontRegularStandart12
        aadExpirationDateLabel.textAlignment = .right
        aadExpirationDateLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AAD SERVICE LIFE YEARS:
        
        aadServiceLifeYearsLabel.textColor = colorWhite
        aadServiceLifeYearsLabel.font = fontRegularStandart12
        aadServiceLifeYearsLabel.textAlignment = .right
        aadServiceLifeYearsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY LABEL:
        
        mainCanopyLabel.text = "Основной парашют:".uppercased()
        mainCanopyLabel.textColor = colorLightGray
        mainCanopyLabel.font = fontBoldStandart10
        mainCanopyLabel.textAlignment = .left
        mainCanopyLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY NAME:

        mainCanopyNameLabel.textColor = colorWhite
        mainCanopyNameLabel.font = fontBoldStandart22
        mainCanopyNameLabel.textAlignment = .left
        mainCanopyNameLabel.numberOfLines = 0
        mainCanopyNameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY SERIAL NUMBER:
        
        mainCanopySerialNumberLabel.textColor = colorWhite
        mainCanopySerialNumberLabel.font = fontRegularStandart12
        mainCanopySerialNumberLabel.textAlignment = .left
        mainCanopySerialNumberLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY DOM:

        mainCanopyDomLabel.textColor = colorWhite
        mainCanopyDomLabel.font = fontRegularStandart12
        mainCanopyDomLabel.textAlignment = .left
        mainCanopyDomLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY EXPIRATION DATE:
        
        mainCanopyExpirationDateLabel.textColor = colorWhite
        mainCanopyExpirationDateLabel.font = fontRegularStandart12
        mainCanopyExpirationDateLabel.textAlignment = .left
        mainCanopyExpirationDateLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY SERVICE LIFE YEARS:
        
        mainCanopyServiceLifeYearsLabel.textColor = colorWhite
        mainCanopyServiceLifeYearsLabel.font = fontRegularStandart12
        mainCanopyServiceLifeYearsLabel.textAlignment = .left
        mainCanopyServiceLifeYearsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY SERVICE LIFE JUMPS:
        
        mainCanopyServiceLifeJumpsLabel.textColor = colorWhite
        mainCanopyServiceLifeJumpsLabel.font = fontRegularStandart12
        mainCanopyServiceLifeJumpsLabel.textAlignment = .left
        mainCanopyServiceLifeJumpsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY COUNT JUMP:

        mainCanopyCountJumpsLabel.textColor = colorWhite
        mainCanopyCountJumpsLabel.font = fontRegularStandart12
        mainCanopyCountJumpsLabel.textAlignment = .left
        mainCanopyCountJumpsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAIN CANOPY REMAINED COUNT
        
        mainCanopyRemainedCountLabel.textColor = colorWhite
        mainCanopyRemainedCountLabel.font = fontRegularStandart12
        mainCanopyRemainedCountLabel.textAlignment = .left
        mainCanopyRemainedCountLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY LABEL:
        
        reserveCanopyLabel.text = "Запасной парашют:".uppercased()
        reserveCanopyLabel.textColor = colorLightGray
        reserveCanopyLabel.font = fontBoldStandart10
        reserveCanopyLabel.textAlignment = .right
        reserveCanopyLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY NAME:

        reserveCanopyNameLabel.textColor = colorWhite
        reserveCanopyNameLabel.font = fontBoldStandart22
        reserveCanopyNameLabel.textAlignment = .right
        reserveCanopyNameLabel.numberOfLines = 0
        reserveCanopyNameLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY SERIAL NUMBER:
        
        reserveCanopySerialNumberLabel.textColor = colorWhite
        reserveCanopySerialNumberLabel.font = fontRegularStandart12
        reserveCanopySerialNumberLabel.textAlignment = .right
        reserveCanopySerialNumberLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY DOM:

        reserveCanopyDomLabel.textColor = colorWhite
        reserveCanopyDomLabel.font = fontRegularStandart12
        reserveCanopyDomLabel.textAlignment = .right
        reserveCanopyDomLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY EXPIRATION DATE:
        
        reserveCanopyExpirationDateLabel.textColor = colorWhite
        reserveCanopyExpirationDateLabel.font = fontRegularStandart12
        reserveCanopyExpirationDateLabel.textAlignment = .right
        reserveCanopyExpirationDateLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY SERVICE LIFE YEARS:
        
        reserveCanopyServiceLifeYearsLabel.textColor = colorWhite
        reserveCanopyServiceLifeYearsLabel.font = fontRegularStandart12
        reserveCanopyServiceLifeYearsLabel.textAlignment = .right
        reserveCanopyServiceLifeYearsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY COUNT REPACK:

        reserveCanopyCountRepackLabel.textColor = colorWhite
        reserveCanopyCountRepackLabel.font = fontRegularStandart12
        reserveCanopyCountRepackLabel.textAlignment = .right
        reserveCanopyCountRepackLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: RESERVE CANOPY DATE PACK:
        
        reserveCanopyDatePackLabel.textColor = colorWhite
        reserveCanopyDatePackLabel.font = fontRegularStandart12
        reserveCanopyDatePackLabel.textAlignment = .right
        reserveCanopyDatePackLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: SYSTEM COMMENT:
        
        systemCommentLabel.textColor = colorWhite
        systemCommentLabel.font = fontRegularStandart10
        systemCommentLabel.textAlignment = .center
        systemCommentLabel.adjustsFontSizeToFitWidth = true
    }
        
    // MARK: - HELPERS:
    
    // MARK: CONFIGURE:

    func configure(_ system: SystemStructure) {
        systemNameLabel.text = system.name.uppercased()
        containerNameLabel.text = system.container.name
        containerSerialNumberLabel.text = "Номер: " + system.container.serialNumber
        containerDomLabel.text = "Изготовлен: " + system.container.dom
        containerServiceLifeYearsLabel.text = "Срок службы: " + system.container.serviceLifeYears + " лет"
        containerExpirationDateLabel.text = "Годен до: " + setContainerExpirationDate(system)
        aadNameLabel.text = system.aad.name
        aadSerialNumberLabel.text = "Номер: " + system.aad.serialNumber
        aadDomLabel.text = "Изготовлен: " + system.aad.dom
        aadServiceLifeYearsLabel.text = "Срок службы: " + system.aad.serviceLifeYears + " лет"
        aadExpirationDateLabel.text = "Годен до: " + setAadExpirationDate(system)
        mainCanopyNameLabel.text = system.mainCanopy.name
        mainCanopySerialNumberLabel.text = "Номер: " + system.mainCanopy.serialNumber
        mainCanopyDomLabel.text = "Изготовлен: " + system.mainCanopy.dom
        mainCanopyServiceLifeYearsLabel.text = "Срок службы: " + system.mainCanopy.serviceLifeYears + " лет"
        mainCanopyExpirationDateLabel.text = "Годен до: " + setMainCanopyExpirationDate(system)
        mainCanopyServiceLifeJumpsLabel.text = "Срок службы: " + system.mainCanopy.serviceLifeJumps + " прыжков"
        mainCanopyCountJumpsLabel.text = "Прыжков на куполе: " + setMainCanopyCountTotalJumps(system, arrayJumps)
        mainCanopyRemainedCountLabel.text = "Ресурс: " + setMainCanopyRemainedCountJumps(system, arrayJumps) + " прыжков"
        reserveCanopyNameLabel.text = system.reserveCanopy.name
        reserveCanopySerialNumberLabel.text = "Номер: " + system.reserveCanopy.serialNumber
        reserveCanopyDomLabel.text = "Изготовлен: " + system.reserveCanopy.dom
        reserveCanopyServiceLifeYearsLabel.text = "Срок службы: " + system.reserveCanopy.serviceLifeYears + " лет"
        reserveCanopyCountRepackLabel.text = "Переукладок: " + system.reserveCanopy.countRepack + "/" + system.reserveCanopy.serviceLifeYears
        reserveCanopyDatePackLabel.text = "Уложен: " + system.reserveCanopy.datePack
        reserveCanopyExpirationDateLabel.text = "Годен до: " + setReserveCanopyExpirationDate(system)
        systemCommentLabel.text = system.comment
    }
    
    // MARK: CONTAINER SERVICE LIFE YEARS:
    
    private func setContainerExpirationDate(_ system: SystemStructure) -> String {
        var expirationDateContainer = ""
        let containerDomLabelText = system.container.dom
        let containerServiceLifeYears = Int(system.container.serviceLifeYears)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        if let date = dateFormatter.date(from: containerDomLabelText) {
            guard let containerServiceLifeYears = containerServiceLifeYears else { return "" }
            if let newDate = Calendar.current.date(byAdding: .year, value: containerServiceLifeYears, to: date) {
                let newDateString = dateFormatter.string(from: newDate)
                expirationDateContainer += newDateString
            }
        }
        return expirationDateContainer
    }
    
    // MARK: AAD SERVICE LIFE YEARS:
    
    private func setAadExpirationDate(_ system: SystemStructure) -> String {
        var expirationDateAad = ""
        let aadDomLabelText = system.aad.dom
        let aadServiceLifeYears = Int(system.aad.serviceLifeYears)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        if let date = dateFormatter.date(from: aadDomLabelText) {
            guard let aadServiceLifeYears = aadServiceLifeYears else { return "" }
            if let newDate = Calendar.current.date(byAdding: .year, value: aadServiceLifeYears, to: date) {
                let newDateString = dateFormatter.string(from: newDate)
                expirationDateAad += newDateString
            }
        }
        return expirationDateAad
    }
    
    // MARK: MAIN CANOPY SERVICE LIFE YEARS:
    
    private func setMainCanopyExpirationDate(_ system: SystemStructure) -> String {
        var expirationDateMainCanopy = ""
        let mainCanopyDomLabelText = system.mainCanopy.dom
        let mainCanopyServiceLifeYears = Int(system.mainCanopy.serviceLifeYears)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        if let date = dateFormatter.date(from: mainCanopyDomLabelText) {
            guard let mainCanopyServiceLifeYears = mainCanopyServiceLifeYears else { return "" }
            if let newDate = Calendar.current.date(byAdding: .year, value: mainCanopyServiceLifeYears, to: date) {
                let newDateString = dateFormatter.string(from: newDate)
                expirationDateMainCanopy += newDateString
            }
        }
        return expirationDateMainCanopy
    }
    
    // MARK: MAIN CANOPY TOTAL JUMPS:
    
    private func setMainCanopyCountTotalJumps(_ system: SystemStructure, _ arrayJumps: [JumpStructure]) -> String {
        var totalJumps = 0
        for jump in arrayJumps {
            if jump.canopy == system.mainCanopy.name {
                totalJumps += 1
            }
        }
        let mainCanopyCountJumps = Int(system.mainCanopy.countJumps) ?? 0
        return String(mainCanopyCountJumps + totalJumps)
    }
    
    // MARK: MAIN CANOPY REMAINED COUNT:
    
    private func setMainCanopyRemainedCountJumps(_ system: SystemStructure, _ arrayJumps: [JumpStructure]) -> String {
        var totalJumps = 0
        for jump in arrayJumps {
            if jump.canopy == system.mainCanopy.name {
                totalJumps += 1
            }
        }
        let mainCanopyCountJumps = Int(system.mainCanopy.countJumps) ?? 0
        let sumMainCanopyCountJumps = mainCanopyCountJumps + totalJumps
        let remainedMainCanopyCountJumps = (Int(system.mainCanopy.serviceLifeJumps) ?? 0) - sumMainCanopyCountJumps
        return String(remainedMainCanopyCountJumps)
    }
    
    // MARK: RESERVE CANOPY SERVICE LIFE YEARS:
    
    private func setReserveCanopyExpirationDate(_ system: SystemStructure) -> String {
        var expirationDateReserveCanopy = ""
        let reserveCanopyDomLabelText = system.reserveCanopy.dom
        let reserveCanopyServiceLifeYears = Int(system.reserveCanopy.serviceLifeYears)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.yyyy"
        if let date = dateFormatter.date(from: reserveCanopyDomLabelText) {
            guard let reserveCanopyServiceLifeYears = reserveCanopyServiceLifeYears else { return "" }
            if let newDate = Calendar.current.date(byAdding: .year, value: reserveCanopyServiceLifeYears, to: date) {
                let newDateString = dateFormatter.string(from: newDate)
                expirationDateReserveCanopy += newDateString
            }
        }
        return expirationDateReserveCanopy
    }
    
    @objc private func tapOnEditButton() {
        tapEditButton?()
    }
}
