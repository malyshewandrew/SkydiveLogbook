import UIKit
import RealmSwift

// MARK: - PROTOCOL:

protocol StatisticCellDelegate {
    func tapGeneralInfoButton()
    func tapTotalButton()
    func tapYearButton()
    func tapCategoryButton()
    func tapMaxHeightButton()
    func tapAverageHeightButton()
    func tapMinHeightButton()
    func tapMaxDayButton()
    func tapAverageTimeButton()
    func tapCountCutawayButton()
    func tapDateFirstButton()
    func tapMaxTimeButton()
    func tapDateLastButton()
    func tapAircraftsButton()
    func tapCanopiesButton()
    func tapLocationsButton()
}

final class StatisticCell: UITableViewCell {
    // MARK: - PROPERTIES:
    
    private let generalInfoButton = UIButton()
    private let generalInfoLabel = UILabel()

    private let totalJumpsButton = UIButton()
    private let totalJumpsLabel = UILabel()
    private let jumpsYearButton = UIButton()
    private let jumpsYearLabel = UILabel()
    private let categoryButton = UIButton()
    private let categoryLabel = UILabel()

    private let maxHeightButton = UIButton()
    private let maxHeightLabel = UILabel()
    private let averageHeightButton = UIButton()
    private let averageHeightLabel = UILabel()
    private let minHeightButton = UIButton()
    private let minHeightLabel = UILabel()
    
    private let dateLastButton = UIButton()
    private let dateLastLabel = UILabel()
    private let maxTimeButton = UIButton()
    private let maxTimeLabel = UILabel()
    private let dateFirstButton = UIButton()
    private let dateFirstLabel = UILabel()
    
    private let maxDayButton = UIButton()
    private let maxDayLabel = UILabel()
    private let averageTimeButton = UIButton()
    private let averageTimeLabel = UILabel()
    private let countCutawayButton = UIButton()
    private let countCutawayLabel = UILabel()

    private let aircraftsButton = UIButton()
    private let aircraftsLabel = UILabel()
    private let canopiesButton = UIButton()
    private let canopiesLabel = UILabel()
    private let locationsButton = UIButton()
    private let locationsLabel = UILabel()
    
    private let missionsContainerView = UIView()
    private let missionsOneView = UIView()
    private let missionsButton = UIButton()
    private let missionsOneLabel = UILabel()
    private let missionsTwoLabel = UILabel()
    private let topMissionsButton = UIButton()
    private let topMissionsLabel = UILabel()
    private let missionsViewButton = UIButton()
    
    private let missionsTwoView = UIView()
    
    
    private var isFlippedMissionsView = false
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    let dateFormatter = DateFormatter()
    var delegate: StatisticCellDelegate?
    
    // MARK: - LIFECYCLE:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstrains()
        configureUI()
        reloadData()
    }
    
    override func prepareForReuse() {
        reloadData()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        contentView.addSubviews(generalInfoButton,
                                totalJumpsButton, jumpsYearButton, categoryButton,
                                maxHeightButton, averageHeightButton, minHeightButton,
                                dateFirstButton, maxTimeButton, dateLastButton,
                                maxDayButton, averageTimeButton, countCutawayButton,
                                aircraftsButton, canopiesButton, locationsButton,
                                missionsContainerView, activityIndicator)
        generalInfoButton.addSubview(generalInfoLabel)
        totalJumpsButton.addSubview(totalJumpsLabel)
        jumpsYearButton.addSubview(jumpsYearLabel)
        categoryButton.addSubview(categoryLabel)
        maxHeightButton.addSubview(maxHeightLabel)
        averageHeightButton.addSubview(averageHeightLabel)
        minHeightButton.addSubview(minHeightLabel)
        dateLastButton.addSubviews(dateLastLabel)
        maxTimeButton.addSubview(maxTimeLabel)
        dateFirstButton.addSubviews(dateFirstLabel)
        averageTimeButton.addSubview(averageTimeLabel)
        maxDayButton.addSubviews(maxDayLabel)
        countCutawayButton.addSubviews(countCutawayLabel)
        aircraftsButton.addSubview(aircraftsLabel)
        canopiesButton.addSubview(canopiesLabel)
        locationsButton.addSubview(locationsLabel)
        missionsContainerView.addSubviews(missionsTwoView, missionsOneView, missionsViewButton)
        missionsOneView.addSubviews(missionsButton, topMissionsButton)
        missionsButton.addSubviews(missionsOneLabel, missionsTwoLabel)
        topMissionsButton.addSubview(topMissionsLabel)
        missionsTwoView.addSubviews()
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: GENERAL INFO:

        generalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        generalInfoButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        generalInfoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        generalInfoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        generalInfoButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        
        generalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        generalInfoLabel.topAnchor.constraint(equalTo: generalInfoButton.topAnchor, constant: 15).isActive = true
        generalInfoLabel.leadingAnchor.constraint(equalTo: generalInfoButton.leadingAnchor, constant: 10).isActive = true
        generalInfoLabel.trailingAnchor.constraint(equalTo: generalInfoButton.trailingAnchor, constant: 0).isActive = true
        generalInfoLabel.bottomAnchor.constraint(equalTo: generalInfoButton.bottomAnchor, constant: -5).isActive = true
        
        // MARK: TOTAL JUMPS:

        totalJumpsButton.translatesAutoresizingMaskIntoConstraints = false
        totalJumpsButton.topAnchor.constraint(equalTo: generalInfoButton.bottomAnchor, constant: 15).isActive = true
        totalJumpsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        totalJumpsButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        totalJumpsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        totalJumpsLabel.translatesAutoresizingMaskIntoConstraints = false
        totalJumpsLabel.topAnchor.constraint(equalTo: totalJumpsButton.topAnchor, constant: 12).isActive = true
        totalJumpsLabel.leadingAnchor.constraint(equalTo: totalJumpsButton.leadingAnchor, constant: 0).isActive = true
        totalJumpsLabel.trailingAnchor.constraint(equalTo: totalJumpsButton.trailingAnchor, constant: 0).isActive = true
        totalJumpsLabel.bottomAnchor.constraint(equalTo: totalJumpsButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: JUMPS YEAR:

        jumpsYearButton.translatesAutoresizingMaskIntoConstraints = false
        jumpsYearButton.topAnchor.constraint(equalTo: generalInfoButton.bottomAnchor, constant: 15).isActive = true
        jumpsYearButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        jumpsYearButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        jumpsYearButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        jumpsYearLabel.translatesAutoresizingMaskIntoConstraints = false
        jumpsYearLabel.topAnchor.constraint(equalTo: jumpsYearButton.topAnchor, constant: 12).isActive = true
        jumpsYearLabel.leadingAnchor.constraint(equalTo: jumpsYearButton.leadingAnchor, constant: 0).isActive = true
        jumpsYearLabel.trailingAnchor.constraint(equalTo: jumpsYearButton.trailingAnchor, constant: 0).isActive = true
        jumpsYearLabel.bottomAnchor.constraint(equalTo: jumpsYearButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: CATEGORY:

        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.topAnchor.constraint(equalTo: generalInfoButton.bottomAnchor, constant: 15).isActive = true
        categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        categoryButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        categoryButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.topAnchor.constraint(equalTo: categoryButton.topAnchor, constant: 12).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: categoryButton.leadingAnchor, constant: 0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: categoryButton.trailingAnchor, constant: 0).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: MAXIMUM HEIGHT:

        maxHeightButton.translatesAutoresizingMaskIntoConstraints = false
        maxHeightButton.topAnchor.constraint(equalTo: totalJumpsButton.bottomAnchor, constant: 15).isActive = true
        maxHeightButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        maxHeightButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        maxHeightButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        maxHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        maxHeightLabel.topAnchor.constraint(equalTo: maxHeightButton.topAnchor, constant: 12).isActive = true
        maxHeightLabel.leadingAnchor.constraint(equalTo: maxHeightButton.leadingAnchor, constant: 0).isActive = true
        maxHeightLabel.trailingAnchor.constraint(equalTo: maxHeightButton.trailingAnchor, constant: 0).isActive = true
        maxHeightLabel.bottomAnchor.constraint(equalTo: maxHeightButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: AVERAGE HEIGHT:

        averageHeightButton.translatesAutoresizingMaskIntoConstraints = false
        averageHeightButton.topAnchor.constraint(equalTo: totalJumpsButton.bottomAnchor, constant: 15).isActive = true
        averageHeightButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        averageHeightButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        averageHeightButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        averageHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        averageHeightLabel.topAnchor.constraint(equalTo: averageHeightButton.topAnchor, constant: 12).isActive = true
        averageHeightLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        averageHeightLabel.trailingAnchor.constraint(equalTo: averageHeightButton.trailingAnchor, constant: 0).isActive = true
        averageHeightLabel.bottomAnchor.constraint(equalTo: averageHeightButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: MINIMUM HEIGHT:

        minHeightButton.translatesAutoresizingMaskIntoConstraints = false
        minHeightButton.topAnchor.constraint(equalTo: totalJumpsButton.bottomAnchor, constant: 15).isActive = true
        minHeightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        minHeightButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        minHeightButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        minHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        minHeightLabel.topAnchor.constraint(equalTo: minHeightButton.topAnchor, constant: 12).isActive = true
        minHeightLabel.leadingAnchor.constraint(equalTo: minHeightButton.leadingAnchor, constant: 0).isActive = true
        minHeightLabel.trailingAnchor.constraint(equalTo: minHeightButton.trailingAnchor, constant: 0).isActive = true
        minHeightLabel.bottomAnchor.constraint(equalTo: minHeightButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: DATE FIRST:

        dateFirstButton.translatesAutoresizingMaskIntoConstraints = false
        dateFirstButton.topAnchor.constraint(equalTo: maxHeightButton.bottomAnchor, constant: 15).isActive = true
        dateFirstButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dateFirstButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        dateFirstButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        dateFirstLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFirstLabel.topAnchor.constraint(equalTo: dateFirstButton.topAnchor, constant: 12).isActive = true
        dateFirstLabel.leadingAnchor.constraint(equalTo: dateFirstButton.leadingAnchor, constant: 0).isActive = true
        dateFirstLabel.trailingAnchor.constraint(equalTo: dateFirstButton.trailingAnchor, constant: 0).isActive = true
        dateFirstLabel.bottomAnchor.constraint(equalTo: dateFirstButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: MAX TIME:

        maxTimeButton.translatesAutoresizingMaskIntoConstraints = false
        maxTimeButton.topAnchor.constraint(equalTo: averageHeightButton.bottomAnchor, constant: 15).isActive = true
        maxTimeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        maxTimeButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        maxTimeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        maxTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTimeLabel.topAnchor.constraint(equalTo: maxTimeButton.topAnchor, constant: 12).isActive = true
        maxTimeLabel.leadingAnchor.constraint(equalTo: maxTimeButton.leadingAnchor, constant: 0).isActive = true
        maxTimeLabel.trailingAnchor.constraint(equalTo: maxTimeButton.trailingAnchor, constant: 0).isActive = true
        maxTimeLabel.bottomAnchor.constraint(equalTo: maxTimeButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: DATE LAST:

        dateLastButton.translatesAutoresizingMaskIntoConstraints = false
        dateLastButton.topAnchor.constraint(equalTo: minHeightButton.bottomAnchor, constant: 15).isActive = true
        dateLastButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        dateLastButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        dateLastButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        dateLastLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLastLabel.topAnchor.constraint(equalTo: dateLastButton.topAnchor, constant: 12).isActive = true
        dateLastLabel.leadingAnchor.constraint(equalTo: dateLastButton.leadingAnchor, constant: 0).isActive = true
        dateLastLabel.trailingAnchor.constraint(equalTo: dateLastButton.trailingAnchor, constant: 0).isActive = true
        dateLastLabel.bottomAnchor.constraint(equalTo: dateLastButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: MAX DAY:

        maxDayButton.translatesAutoresizingMaskIntoConstraints = false
        maxDayButton.topAnchor.constraint(equalTo: dateFirstButton.bottomAnchor, constant: 15).isActive = true
        maxDayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        maxDayButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        maxDayButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        maxDayLabel.translatesAutoresizingMaskIntoConstraints = false
        maxDayLabel.topAnchor.constraint(equalTo: maxDayButton.topAnchor, constant: 12).isActive = true
        maxDayLabel.leadingAnchor.constraint(equalTo: maxDayButton.leadingAnchor, constant: 0).isActive = true
        maxDayLabel.trailingAnchor.constraint(equalTo: maxDayButton.trailingAnchor, constant: 0).isActive = true
        maxDayLabel.bottomAnchor.constraint(equalTo: maxDayButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: AVERAGE TIME:

        averageTimeButton.translatesAutoresizingMaskIntoConstraints = false
        averageTimeButton.topAnchor.constraint(equalTo: maxTimeButton.bottomAnchor, constant: 15).isActive = true
        averageTimeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        averageTimeButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        averageTimeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        averageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        averageTimeLabel.topAnchor.constraint(equalTo: averageTimeButton.topAnchor, constant: 15).isActive = true
        averageTimeLabel.leadingAnchor.constraint(equalTo: averageTimeButton.leadingAnchor, constant: 0).isActive = true
        averageTimeLabel.trailingAnchor.constraint(equalTo: averageTimeButton.trailingAnchor, constant: 0).isActive = true
        averageTimeLabel.bottomAnchor.constraint(equalTo: averageTimeButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: CUTAWAY:

        countCutawayButton.translatesAutoresizingMaskIntoConstraints = false
        countCutawayButton.topAnchor.constraint(equalTo: dateLastButton.bottomAnchor, constant: 15).isActive = true
        countCutawayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        countCutawayButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        countCutawayButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        countCutawayLabel.translatesAutoresizingMaskIntoConstraints = false
        countCutawayLabel.topAnchor.constraint(equalTo: countCutawayButton.topAnchor, constant: 12).isActive = true
        countCutawayLabel.leadingAnchor.constraint(equalTo: countCutawayButton.leadingAnchor, constant: 0).isActive = true
        countCutawayLabel.trailingAnchor.constraint(equalTo: countCutawayButton.trailingAnchor, constant: 0).isActive = true
        countCutawayLabel.bottomAnchor.constraint(equalTo: countCutawayButton.bottomAnchor, constant: 0).isActive = true

        // MARK: AIRCRAFTS:

        aircraftsButton.translatesAutoresizingMaskIntoConstraints = false
        aircraftsButton.topAnchor.constraint(equalTo: maxDayButton.bottomAnchor, constant: 15).isActive = true
        aircraftsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        aircraftsButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        aircraftsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        aircraftsLabel.translatesAutoresizingMaskIntoConstraints = false
        aircraftsLabel.topAnchor.constraint(equalTo: aircraftsButton.topAnchor, constant: 12).isActive = true
        aircraftsLabel.leadingAnchor.constraint(equalTo: aircraftsButton.leadingAnchor, constant: 0).isActive = true
        aircraftsLabel.trailingAnchor.constraint(equalTo: aircraftsButton.trailingAnchor, constant: 0).isActive = true
        aircraftsLabel.bottomAnchor.constraint(equalTo: aircraftsButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: CANOPIES:

        canopiesButton.translatesAutoresizingMaskIntoConstraints = false
        canopiesButton.topAnchor.constraint(equalTo: maxDayButton.bottomAnchor, constant: 15).isActive = true
        canopiesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        canopiesButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        canopiesButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        canopiesLabel.translatesAutoresizingMaskIntoConstraints = false
        canopiesLabel.topAnchor.constraint(equalTo: canopiesButton.topAnchor, constant: 12).isActive = true
        canopiesLabel.leadingAnchor.constraint(equalTo: canopiesButton.leadingAnchor, constant: 0).isActive = true
        canopiesLabel.trailingAnchor.constraint(equalTo: canopiesButton.trailingAnchor, constant: 0).isActive = true
        canopiesLabel.bottomAnchor.constraint(equalTo: canopiesButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: LOCATIONS:

        locationsButton.translatesAutoresizingMaskIntoConstraints = false
        locationsButton.topAnchor.constraint(equalTo: maxDayButton.bottomAnchor, constant: 15).isActive = true
        locationsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        locationsButton.heightAnchor.constraint(equalToConstant: height75).isActive = true
        locationsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        locationsLabel.translatesAutoresizingMaskIntoConstraints = false
        locationsLabel.topAnchor.constraint(equalTo: locationsButton.topAnchor, constant: 12).isActive = true
        locationsLabel.leadingAnchor.constraint(equalTo: locationsButton.leadingAnchor, constant: 0).isActive = true
        locationsLabel.trailingAnchor.constraint(equalTo: locationsButton.trailingAnchor, constant: 0).isActive = true
        locationsLabel.bottomAnchor.constraint(equalTo: locationsButton.bottomAnchor, constant: 0).isActive = true
        
        // MARK: MISSION CONTAINER VIEW:
        
        missionsContainerView.translatesAutoresizingMaskIntoConstraints = false
        missionsContainerView.topAnchor.constraint(equalTo: aircraftsButton.bottomAnchor, constant: 15).isActive = true
        missionsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        missionsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        missionsContainerView.heightAnchor.constraint(equalTo: totalJumpsButton.heightAnchor, multiplier: 2).isActive = true
        missionsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        // MARK: MISSION ONE VIEW:
        
        missionsOneView.translatesAutoresizingMaskIntoConstraints = false
        missionsOneView.topAnchor.constraint(equalTo: aircraftsButton.bottomAnchor, constant: 15).isActive = true
        missionsOneView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        missionsOneView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        missionsOneView.heightAnchor.constraint(equalTo: totalJumpsButton.heightAnchor, multiplier: 2).isActive = true
        missionsOneView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        // MARK: MISSION TWO VIEW:
        
        missionsTwoView.translatesAutoresizingMaskIntoConstraints = false
        missionsTwoView.topAnchor.constraint(equalTo: aircraftsButton.bottomAnchor, constant: 15).isActive = true
        missionsTwoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        missionsTwoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        missionsTwoView.heightAnchor.constraint(equalTo: totalJumpsButton.heightAnchor, multiplier: 2).isActive = true
        missionsTwoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        // MARK: MISSIONS:

        missionsButton.translatesAutoresizingMaskIntoConstraints = false
        missionsButton.topAnchor.constraint(equalTo: missionsOneView.topAnchor).isActive = true
        missionsButton.leadingAnchor.constraint(equalTo: missionsOneView.leadingAnchor).isActive = true
        missionsButton.trailingAnchor.constraint(equalTo: missionsOneView.trailingAnchor).isActive = true
        missionsButton.bottomAnchor.constraint(equalTo: missionsOneView.bottomAnchor).isActive = true
        
        // MARK: MISSIONS ONE:
        
        missionsOneLabel.translatesAutoresizingMaskIntoConstraints = false
        missionsOneLabel.topAnchor.constraint(equalTo: missionsButton.topAnchor, constant: 21).isActive = true
        missionsOneLabel.leadingAnchor.constraint(equalTo: missionsButton.leadingAnchor, constant: 10).isActive = true
        missionsOneLabel.trailingAnchor.constraint(equalTo: topMissionsButton.leadingAnchor, constant: -10).isActive = true
        missionsOneLabel.bottomAnchor.constraint(equalTo: missionsButton.bottomAnchor, constant: -5).isActive = true
        
        // MARK: TOP MISSIONS:

        topMissionsButton.translatesAutoresizingMaskIntoConstraints = false
        topMissionsButton.topAnchor.constraint(equalTo: missionsButton.topAnchor).isActive = true
        topMissionsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        topMissionsButton.heightAnchor.constraint(equalTo: missionsButton.heightAnchor, multiplier: 1).isActive = true
        topMissionsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        
        topMissionsLabel.translatesAutoresizingMaskIntoConstraints = false
        topMissionsLabel.topAnchor.constraint(equalTo: topMissionsButton.topAnchor, constant: 21).isActive = true
        topMissionsLabel.leadingAnchor.constraint(equalTo: topMissionsButton.leadingAnchor).isActive = true
        topMissionsLabel.trailingAnchor.constraint(equalTo: topMissionsButton.trailingAnchor).isActive = true
        topMissionsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        topMissionsLabel.bottomAnchor.constraint(equalTo: topMissionsButton.bottomAnchor, constant: -5).isActive = true
        
        // MARK: MISSIONS TWO:
        
        missionsTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        missionsTwoLabel.topAnchor.constraint(equalTo: missionsButton.topAnchor, constant: 21).isActive = true
        missionsTwoLabel.leadingAnchor.constraint(equalTo: topMissionsButton.trailingAnchor, constant: 10).isActive = true
        missionsTwoLabel.trailingAnchor.constraint(equalTo: missionsButton.trailingAnchor, constant: -10).isActive = true
        missionsTwoLabel.bottomAnchor.constraint(equalTo: missionsButton.bottomAnchor, constant: -5).isActive = true
        
        // MARK: MISSION VIEW BUTTON:

        missionsViewButton.translatesAutoresizingMaskIntoConstraints = false
        missionsViewButton.topAnchor.constraint(equalTo: missionsOneView.topAnchor).isActive = true
        missionsViewButton.leadingAnchor.constraint(equalTo: missionsOneView.leadingAnchor).isActive = true
        missionsViewButton.trailingAnchor.constraint(equalTo: missionsOneView.trailingAnchor).isActive = true
        missionsViewButton.bottomAnchor.constraint(equalTo: missionsOneView.bottomAnchor).isActive = true
        
        // MARK: ACTIVITY INDICATOR:
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: - CONTENT VIEW:
        
        contentView.backgroundColor = .colorBackground
        selectionStyle = .none
        
        // MARK: GENERAL INFO:

        generalInfoButton.setTitle(NSLocalizedString("General info", comment: "") + ":", for: .normal)
        generalInfoButton.setTitleColor(.colorLightGray, for: .normal)
        generalInfoButton.titleLabel?.font = fontMediumStandard12
        generalInfoButton.contentVerticalAlignment = textAligmentTop
        generalInfoButton.backgroundColor = .colorCell
        generalInfoButton.layer.cornerRadius = cornerRadius15
        generalInfoButton.addTarget(self, action: #selector(generalInfoButtonTapped), for: .touchUpInside)
        
        generalInfoLabel.textAlignment = .center
        generalInfoLabel.baselineAdjustment = .alignCenters
        generalInfoLabel.font = fontMediumStandard12
        generalInfoLabel.textColor = .colorWhite
        generalInfoLabel.numberOfLines = 0
        generalInfoLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: TOTAL JUMPS:

        totalJumpsButton.setTitle(NSLocalizedString("Total jumps", comment: "") + ":", for: .normal)
        totalJumpsButton.setTitleColor(.colorLightGray, for: .normal)
        totalJumpsButton.titleLabel?.font = fontMediumStandard12
        totalJumpsButton.contentVerticalAlignment = textAligmentTop
        totalJumpsButton.backgroundColor = .colorCell
        totalJumpsButton.layer.cornerRadius = cornerRadius15
        totalJumpsButton.addTarget(self, action: #selector(totalButtonTapped), for: .touchUpInside)
        
        totalJumpsLabel.textAlignment = .center
        totalJumpsLabel.baselineAdjustment = .alignCenters
        totalJumpsLabel.font = fontBoldStandard30
        totalJumpsLabel.textColor = .colorWhite
        totalJumpsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: JUMPS YEAR:

        jumpsYearButton.setTitle(NSLocalizedString("In this year", comment: "") + ":", for: .normal)
        jumpsYearButton.setTitleColor(.colorLightGray, for: .normal)
        jumpsYearButton.titleLabel?.font = fontMediumStandard12
        jumpsYearButton.contentVerticalAlignment = textAligmentTop
        jumpsYearButton.backgroundColor = .colorCell
        jumpsYearButton.layer.cornerRadius = cornerRadius15
        jumpsYearButton.addTarget(self, action: #selector(yearButtonTapped), for: .touchUpInside)
        
        jumpsYearLabel.textAlignment = .center
        jumpsYearLabel.baselineAdjustment = .alignCenters
        jumpsYearLabel.font = fontBoldStandard30
        jumpsYearLabel.textColor = .colorWhite
        jumpsYearLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CATEGORY:

        categoryButton.setTitle(NSLocalizedString("Category", comment: "") + ":", for: .normal)
        categoryButton.setTitleColor(.colorLightGray, for: .normal)
        categoryButton.titleLabel?.font = fontMediumStandard12
        categoryButton.contentVerticalAlignment = textAligmentTop
        categoryButton.backgroundColor = .colorCell
        categoryButton.layer.cornerRadius = cornerRadius15
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        categoryLabel.textAlignment = .center
        categoryLabel.baselineAdjustment = .alignCenters
        categoryLabel.font = fontBoldStandard30
        categoryLabel.textColor = .colorWhite
        categoryLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAXIMUM HEIGHT:

        maxHeightButton.setTitle(NSLocalizedString("Max. height", comment: "") + ":", for: .normal)
        maxHeightButton.setTitleColor(.colorLightGray, for: .normal)
        maxHeightButton.titleLabel?.font = fontMediumStandard12
        maxHeightButton.contentVerticalAlignment = textAligmentTop
        maxHeightButton.backgroundColor = .colorCell
        maxHeightButton.layer.cornerRadius = cornerRadius15
        maxHeightButton.addTarget(self, action: #selector(maxHeightButtonTapped), for: .touchUpInside)
        
        maxHeightLabel.textAlignment = .center
        maxHeightLabel.baselineAdjustment = .alignCenters
        maxHeightLabel.font = fontBoldStandard30
        maxHeightLabel.textColor = .colorWhite
        maxHeightLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AVERAGE HEIGHT:

        averageHeightButton.setTitle(NSLocalizedString("Av. height", comment: "") + ":", for: .normal)
        averageHeightButton.setTitleColor(.colorLightGray, for: .normal)
        averageHeightButton.titleLabel?.font = fontMediumStandard12
        averageHeightButton.contentVerticalAlignment = textAligmentTop
        averageHeightButton.backgroundColor = .colorCell
        averageHeightButton.layer.cornerRadius = cornerRadius15
        averageHeightButton.addTarget(self, action: #selector(averageHeightButtonTapped), for: .touchUpInside)
        
        averageHeightLabel.textAlignment = .center
        averageHeightLabel.baselineAdjustment = .alignCenters
        averageHeightLabel.font = fontBoldStandard30
        averageHeightLabel.textColor = .colorWhite
        averageHeightLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MINIMUM HEIGHT:

        minHeightButton.setTitle(NSLocalizedString("Min. height", comment: "") + ":", for: .normal)
        minHeightButton.setTitleColor(.colorLightGray, for: .normal)
        minHeightButton.titleLabel?.font = fontMediumStandard12
        minHeightButton.contentVerticalAlignment = textAligmentTop
        minHeightButton.backgroundColor = .colorCell
        minHeightButton.layer.cornerRadius = cornerRadius15
        minHeightButton.addTarget(self, action: #selector(minHeightButtonTapped), for: .touchUpInside)
        
        minHeightLabel.textAlignment = .center
        minHeightLabel.baselineAdjustment = .alignCenters
        minHeightLabel.font = fontBoldStandard30
        minHeightLabel.textColor = .colorWhite
        minHeightLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: DATE FIRST:

        dateFirstButton.setTitle(NSLocalizedString("First jump", comment: "") + ":", for: .normal)
        dateFirstButton.setTitleColor(.colorLightGray, for: .normal)
        dateFirstButton.titleLabel?.font = fontMediumStandard12
        dateFirstButton.contentVerticalAlignment = textAligmentTop
        dateFirstButton.backgroundColor = .colorCell
        dateFirstButton.layer.cornerRadius = cornerRadius15
        dateFirstButton.addTarget(self, action: #selector(dateFirstButtonTapped), for: .touchUpInside)
        
        dateFirstLabel.textAlignment = .center
        dateFirstLabel.baselineAdjustment = .alignCenters
        dateFirstLabel.font = fontMediumStandard18
        dateFirstLabel.textColor = .colorWhite
        dateFirstLabel.numberOfLines = 1
        dateFirstLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAX TIME:

        maxTimeButton.setTitle(NSLocalizedString("Max. time", comment: "") + ":", for: .normal)
        maxTimeButton.setTitleColor(.colorLightGray, for: .normal)
        maxTimeButton.titleLabel?.font = fontMediumStandard12
        maxTimeButton.contentVerticalAlignment = textAligmentTop
        maxTimeButton.backgroundColor = .colorCell
        maxTimeButton.layer.cornerRadius = cornerRadius15
        maxTimeButton.addTarget(self, action: #selector(maxTimeButtonTapped), for: .touchUpInside)
        
        maxTimeLabel.textAlignment = .center
        maxTimeLabel.baselineAdjustment = .alignCenters
        maxTimeLabel.font = fontBoldStandard30
        maxTimeLabel.textColor = .colorWhite
        maxTimeLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: DATE LAST:

        dateLastButton.setTitle(NSLocalizedString("Last jump", comment: "") + ":", for: .normal)
        dateLastButton.setTitleColor(.colorLightGray, for: .normal)
        dateLastButton.titleLabel?.font = fontMediumStandard12
        dateLastButton.contentVerticalAlignment = textAligmentTop
        dateLastButton.backgroundColor = .colorCell
        dateLastButton.layer.cornerRadius = cornerRadius15
        dateLastButton.addTarget(self, action: #selector(dateLastButtonTapped), for: .touchUpInside)
        
        dateLastLabel.textAlignment = .center
        dateLastLabel.baselineAdjustment = .alignCenters
        dateLastLabel.font = fontMediumStandard18
        dateLastLabel.textColor = .colorWhite
        dateLastLabel.numberOfLines = 1
        dateLastLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MAX DAY:

        maxDayButton.setTitle(NSLocalizedString("Max. in day", comment: "") + ":", for: .normal)
        maxDayButton.setTitleColor(.colorLightGray, for: .normal)
        maxDayButton.titleLabel?.font = fontMediumStandard12
        maxDayButton.contentVerticalAlignment = textAligmentTop
        maxDayButton.backgroundColor = .colorCell
        maxDayButton.layer.cornerRadius = cornerRadius15
        maxDayButton.addTarget(self, action: #selector(maxDayButtonTapped), for: .touchUpInside)
        
        maxDayLabel.textAlignment = .center
        maxDayLabel.baselineAdjustment = .alignCenters
        maxDayLabel.font = fontBoldStandard30
        maxDayLabel.textColor = .colorWhite
        maxDayLabel.numberOfLines = 1
        maxDayLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AVERAGE TIME:

        averageTimeButton.setTitle(NSLocalizedString("Av. time", comment: "") + ":", for: .normal)
        averageTimeButton.setTitleColor(.colorLightGray, for: .normal)
        averageTimeButton.titleLabel?.font = fontMediumStandard12
        averageTimeButton.contentVerticalAlignment = textAligmentTop
        averageTimeButton.backgroundColor = .colorCell
        averageTimeButton.layer.cornerRadius = cornerRadius15
        averageTimeButton.addTarget(self, action: #selector(averageTimeButtonTapped), for: .touchUpInside)
        
        averageTimeLabel.textAlignment = .center
        averageTimeLabel.baselineAdjustment = .alignCenters
        averageTimeLabel.font = fontBoldStandard30
        averageTimeLabel.textColor = .colorWhite
        averageTimeLabel.numberOfLines = 0
        averageTimeLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: COUNT CUTAWAY:

        countCutawayButton.setTitle(NSLocalizedString("CutawayStatistic", comment: "") + ":", for: .normal)
        countCutawayButton.setTitleColor(.colorLightGray, for: .normal)
        countCutawayButton.titleLabel?.font = fontMediumStandard12
        countCutawayButton.contentVerticalAlignment = textAligmentTop
        countCutawayButton.backgroundColor = .colorCell
        countCutawayButton.layer.cornerRadius = cornerRadius15
        countCutawayButton.addTarget(self, action: #selector(countCutawayButtonTapped), for: .touchUpInside)
        
        countCutawayLabel.textAlignment = .center
        countCutawayLabel.baselineAdjustment = .alignCenters
        countCutawayLabel.font = fontBoldStandard30
        countCutawayLabel.textColor = .colorWhite
        countCutawayLabel.numberOfLines = 0
        countCutawayLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: AIRCRAFTS:

        aircraftsButton.setTitle(NSLocalizedString("Aircraft", comment: "") + ":", for: .normal)
        aircraftsButton.setTitleColor(.colorLightGray, for: .normal)
        aircraftsButton.titleLabel?.font = fontMediumStandard12
        aircraftsButton.contentVerticalAlignment = textAligmentTop
        aircraftsButton.backgroundColor = .colorCell
        aircraftsButton.layer.cornerRadius = cornerRadius15
        aircraftsButton.addTarget(self, action: #selector(aircraftsButtonTapped), for: .touchUpInside)
        
        aircraftsLabel.textAlignment = .center
        aircraftsLabel.baselineAdjustment = .alignCenters
        aircraftsLabel.font = fontBoldStandard30
        aircraftsLabel.textColor = .colorWhite
        aircraftsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: CANOPIES:

        canopiesButton.setTitle(NSLocalizedString("Canopies", comment: "") + ":", for: .normal)
        canopiesButton.setTitleColor(.colorLightGray, for: .normal)
        canopiesButton.titleLabel?.font = fontMediumStandard12
        canopiesButton.contentVerticalAlignment = textAligmentTop
        canopiesButton.backgroundColor = .colorCell
        canopiesButton.layer.cornerRadius = cornerRadius15
        canopiesButton.addTarget(self, action: #selector(canopiesButtonTapped), for: .touchUpInside)
        
        canopiesLabel.textAlignment = .center
        canopiesLabel.baselineAdjustment = .alignCenters
        canopiesLabel.font = fontBoldStandard30
        canopiesLabel.textColor = .colorWhite
        canopiesLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: LOCATIONS:

        locationsButton.setTitle(NSLocalizedString("Locations", comment: "") + ":", for: .normal)
        locationsButton.setTitleColor(.colorLightGray, for: .normal)
        locationsButton.titleLabel?.font = fontMediumStandard12
        locationsButton.contentVerticalAlignment = textAligmentTop
        locationsButton.backgroundColor = .colorCell
        locationsButton.layer.cornerRadius = cornerRadius15
        locationsButton.addTarget(self, action: #selector(locationsButtonTapped), for: .touchUpInside)
        
        locationsLabel.textAlignment = .center
        locationsLabel.baselineAdjustment = .alignCenters
        locationsLabel.font = fontBoldStandard30
        locationsLabel.textColor = .colorWhite
        locationsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MISSION ONE VIEW:
        
        missionsOneView.backgroundColor = .colorCell
        missionsOneView.layer.cornerRadius = cornerRadius15
        
        // MARK: MISSION TWO VIEW:
        
        missionsTwoView.backgroundColor = .colorCell
        missionsTwoView.layer.cornerRadius = cornerRadius15
        
        // MARK: MISSIONS:

        missionsButton.setTitleColor(.colorLightGray, for: .normal)
        missionsButton.titleLabel?.font = fontMediumStandard12
        missionsButton.contentVerticalAlignment = textAligmentTop
        missionsButton.backgroundColor = .colorCell
        missionsButton.layer.cornerRadius = cornerRadius15
        
        // MARK: MISSIONS ONE:

        missionsOneLabel.textAlignment = .left
        missionsOneLabel.font = fontMediumStandard9
        missionsOneLabel.textColor = .colorWhite
        missionsOneLabel.numberOfLines = 0
        missionsOneLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: TOP MISSION:

        topMissionsButton.setTitle(NSLocalizedString("Top 10" + ":", comment: ""), for: .normal)
        topMissionsButton.setTitleColor(.colorLightGray, for: .normal)
        topMissionsButton.titleLabel?.font = fontMediumStandard12
        topMissionsButton.contentVerticalAlignment = textAligmentTop
        topMissionsButton.titleLabel?.textAlignment = .center
        topMissionsButton.backgroundColor = .colorCell
        topMissionsButton.layer.cornerRadius = cornerRadius15
        
        topMissionsLabel.textAlignment = .center
        topMissionsLabel.font = fontMediumStandard9
        topMissionsLabel.textColor = .colorWhite
        topMissionsLabel.numberOfLines = 0
        topMissionsLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MISSIONS TWO:

        missionsTwoLabel.textAlignment = .right
        missionsTwoLabel.font = fontMediumStandard9
        missionsTwoLabel.textColor = .colorWhite
        missionsTwoLabel.numberOfLines = 0
        missionsTwoLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: MISSION VIEW BUTTON:

        missionsViewButton.addTarget(self, action: #selector(missionViewButtonTapped), for: .touchUpInside)
        
        // MARK: ACTIVITY INDICATOR:
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - HELPERS:
    
    // MARK: MISSION VIEW BUTTON TAPPED:
    
    @objc private func missionViewButtonTapped() {
        isFlippedMissionsView = !isFlippedMissionsView
        let fromView = isFlippedMissionsView ? missionsOneView : missionsTwoView
        let toView = isFlippedMissionsView ? missionsTwoView : missionsOneView
        UIView.transition(from: fromView, to: toView, duration: 1, options: [.curveEaseOut, .transitionFlipFromLeft, .showHideTransitionViews])
    }
    
    // MARK: GENERAL INFO:
    
    private func setGeneralInfo() {
        var sumTime = 0
        for jump in arrayJumpsRealm {
            sumTime += Int(jump.time) ?? 0
        }
        let seconds = sumTime % 60
        let minutes = sumTime / 60
        let hours = minutes / 60
        let hoursRemainder = minutes % 60
        let days = hours / 24
        let daysRemainder = hours % 24
        
        var sumHeight = 0
        for jump in arrayJumpsRealm {
            sumHeight += Int(jump.height) ?? 0
        }
        let kilometers = sumHeight / 1000
        let meters = sumHeight % 1000
        
        generalInfoLabel.text = """
        \(NSLocalizedString("Total height", comment: "")): \(sumHeight) \(NSLocalizedString("m.", comment: "")) (\(kilometers) \(NSLocalizedString("km.", comment: "")) \(meters) \(NSLocalizedString("m.", comment: "")))
        \(NSLocalizedString("Total time", comment: "")): \(sumTime) \(NSLocalizedString("s.", comment: "")) (\(days) \(NSLocalizedString("d.", comment: "")) \(daysRemainder) \(NSLocalizedString("h.", comment: "")) \(hoursRemainder) \(NSLocalizedString("min.", comment: "")) \(seconds) \(NSLocalizedString("s.", comment: "")))
        """
    }
    
    // MARK: TOTAL JUMPS:

    private func setTotalJumps() {
        totalJumpsLabel.text = String(arrayJumpsRealm.count)
    }
    
    // MARK: JUMPS YEAR:
    
    private func setJumpsYear() {
        let currentYear = Calendar.current.component(.year, from: Date())
        dateFormatter.dateFormat = "dd.MM.yyyy"

        let jumpsThisYearCount = arrayJumpsRealm.reduce(0) { count, jump in
            guard let jumpDate = dateFormatter.date(from: jump.date),
                  Calendar.current.component(.year, from: jumpDate) == currentYear
            else {
                return count
            }
            return count + 1
        }

        jumpsYearLabel.text = "\(jumpsThisYearCount)"
    }
    
    // MARK: CATEGORY:
    
    private func setCategories() {
        var sumTime = 0
        for jump in arrayJumpsRealm {
            sumTime += Int(jump.time) ?? 0
        }
        
        var categoryCount = ""
        var categoryTime = ""
        
        if arrayJumpsRealm.count >= 25 && arrayJumpsRealm.count <= 49 {
            categoryCount = "A"
        } else if arrayJumpsRealm.count >= 50 && arrayJumpsRealm.count <= 199 {
            categoryCount = "B"
        } else if arrayJumpsRealm.count >= 200 && arrayJumpsRealm.count <= 499 {
            categoryCount = "C"
        } else if arrayJumpsRealm.count >= 500 {
            categoryCount = "D"
        }
        
        if sumTime >= 600 && sumTime <= 1799 {
            categoryTime = "A"
        } else if sumTime >= 1800 && sumTime <= 3599 {
            categoryTime = "B"
        } else if sumTime >= 3600 && sumTime <= 10799 {
            categoryTime = "C"
        } else if sumTime >= 10800 {
            categoryTime = "D"
        }

        if (categoryCount == "A" && categoryTime == "A") || (categoryCount == "A" && categoryTime == "B") || (categoryCount == "A" && categoryTime == "C") || (categoryCount == "A" && categoryTime == "D") || (categoryCount == "B" && categoryTime == "A") || (categoryCount == "C" && categoryTime == "A") || (categoryCount == "D" && categoryTime == "A") {
            categoryLabel.text = "A"
            
        } else if (categoryCount == "B" && categoryTime == "B") || (categoryCount == "B" && categoryTime == "C") || (categoryCount == "B" && categoryTime == "D") || (categoryCount == "C" && categoryTime == "B") || (categoryCount == "D" && categoryTime == "B") {
            categoryLabel.text = "B"
                    
        } else if (categoryCount == "C" && categoryTime == "C") || (categoryCount == "C" && categoryTime == "D") || (categoryCount == "D" && categoryTime == "C") {
            categoryLabel.text = "C"
        } else if categoryCount == "D" && categoryTime == "D" {
            categoryLabel.text = "D"
        } else {
            categoryLabel.text = "0"
        }
    }
    
    // MARK: MAXIMUM HEIGHT:
    
    private func setMaxHeight() {
        var maxHeight = 0
        for jump in arrayJumpsRealm {
            if let jumpHeight = Int(jump.height), jumpHeight > maxHeight {
                maxHeight = jumpHeight
            }
        }

        maxHeightLabel.text = String(maxHeight)
    }
    
    // MARK: AVERAGE HEIGHT:
    
    private func setAverageHeight() {
        var sumAverageHeight = 0
        for jump in arrayJumpsRealm {
            sumAverageHeight += Int(jump.height) ?? 0
        }
        
        if arrayJumpsRealm.count == 0 {
            averageHeightLabel.text = "0"
        } else {
            let averageHeight = sumAverageHeight / arrayJumpsRealm.count
            averageHeightLabel.text = "\(averageHeight)"
        }
    }
    
    // MARK: MINIMUM HEIGHT:
    
    private func setMinHeight() {
        var minHeight = Int.max
        for jump in arrayJumpsRealm {
            if let jumpHeight = Int(jump.height), jumpHeight < minHeight {
                minHeight = jumpHeight
            }
        }
        
        if arrayJumpsRealm.count != 0 {
            minHeightLabel.text = String(minHeight)
        } else {
            minHeightLabel.text = "0"
        }
    }
    
    // MARK: DATE FIRST:
    
    private func setDateFirst() {
        arrayJumpsRealm.sort { jump1, jump2 -> Bool in
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let date1 = dateFormatter.date(from: jump1.date), let date2 = dateFormatter.date(from: jump2.date) {
                return date1 < date2
            }
            return false
        }
        
        dateFirstLabel.text = arrayJumpsRealm.first?.date ?? "0"
    }
    
    // MARK: MAX TIME:
    
    private func setMaxTime() {
        var maxTime = 0
        for jump in arrayJumpsRealm {
            if let jumpTime = Int(jump.time), jumpTime > maxTime {
                maxTime = jumpTime
            }
        }
        
        maxTimeLabel.text = String(maxTime)
    }
    
    // MARK: DATE LAST:
    
    private func setDateLast() {
        arrayJumpsRealm.sort { jump1, jump2 -> Bool in
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let date1 = dateFormatter.date(from: jump1.date), let date2 = dateFormatter.date(from: jump2.date) {
                return date1 < date2
            }
            return false
        }
        
        dateLastLabel.text = arrayJumpsRealm.last?.date ?? "0"
    }
    
    // MARK: MAX DAY:
    
    private func setMaxDay() {
        var jumpsMaxDay: [String: Int] = [:]
        
        for jump in arrayJumpsRealm {
            if let count = jumpsMaxDay[jump.date] {
                jumpsMaxDay[jump.date] = count + 1
            } else {
                jumpsMaxDay[jump.date] = 1
            }
        }
        
        if let maxDay = jumpsMaxDay.max(by: { $0.value < $1.value }) {
            let numberOfJumps = maxDay.value
            maxDayLabel.text = "\(numberOfJumps)"
        } else {
            maxDayLabel.text = "0"
        }
    }
    
    // MARK: AVERAGE TIME:
    
    private func setAverageTime() {
        var sumAverageTime = 0
        for jump in arrayJumpsRealm {
            sumAverageTime += Int(jump.time) ?? 0
        }
        
        if arrayJumpsRealm.count == 0 {
            averageTimeLabel.text = "0"
        } else {
            let averageTime = sumAverageTime / arrayJumpsRealm.count
            averageTimeLabel.text = "\(averageTime)"
        }
    }
    
    // MARK: COUNT CUTAWAY:
    
    private func setCountCutaway() {
        var countCutaway = 0
        for jump in arrayJumpsRealm {
            if jump.cutaway?.localizedValue == NSLocalizedString("Yes", comment: "") {
                countCutaway += 1
            }
        }
        
        countCutawayLabel.text = String(countCutaway)
    }
    
    // MARK: AIRCRAFTS:
    
    private func setAircrafts() {
        var setAircrafts: Set<String> = []
        for canopy in arrayJumpsRealm {
            setAircrafts.insert(canopy.aircraft)
        }
        
        aircraftsLabel.text = String(setAircrafts.count)
    }
    
    // MARK: CANOPIES:
    
    private func setCanopies() {
        var setCanopies: Set<String> = []
        for canopy in arrayJumpsRealm {
            setCanopies.insert(canopy.canopy)
        }
        
        canopiesLabel.text = String(setCanopies.count)
    }
    
    // MARK: LOCATIONS:
    
    private func setLocations() {
        var setLocations: Set<String> = []
        for canopy in arrayJumpsRealm {
            setLocations.insert(canopy.location)
        }
        
        locationsLabel.text = String(setLocations.count)
    }
    
    // MARK: MISSIONS ONE:
    
    private func setMissionsOne() {
        var arrayJumpsAccuracy: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Accuracy", comment: "") {
                arrayJumpsAccuracy.append(jump)
            }
        }
        
        var arrayJumpsAcrobatic: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Acrobatics", comment: "") {
                arrayJumpsAcrobatic.append(jump)
            }
        }
        
        var arrayJumpsAff: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("AFF", comment: "") {
                arrayJumpsAff.append(jump)
            }
        }
      
        var arrayJumpsBase: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Base", comment: "") {
                arrayJumpsBase.append(jump)
            }
        }
        
        var arrayJumpsBaseWingsuit: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Base/Wingsuit", comment: "") {
                arrayJumpsBaseWingsuit.append(jump)
            }
        }
        
        var arrayJumpsCanopyFormation: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Canopy formation", comment: "") {
                arrayJumpsCanopyFormation.append(jump)
            }
        }

        var arrayJumpsFreeFly: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Freefly", comment: "") {
                arrayJumpsFreeFly.append(jump)
            }
        }
        
        var arrayJumpsFreeStyle: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Freestyle", comment: "") {
                arrayJumpsFreeStyle.append(jump)
            }
        }
        
        var arrayJumpsFun: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Fun", comment: "") {
                arrayJumpsFun.append(jump)
            }
        }

        var arrayJumpsGroup: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Group", comment: "") {
                arrayJumpsGroup.append(jump)
            }
        }
        
        var arrayJumpsInstructor: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Instructor", comment: "") {
                arrayJumpsInstructor.append(jump)
            }
        }

        missionsOneLabel.text = """
        \(arrayJumpsAccuracy.count): \(NSLocalizedString("Accuracy", comment: ""))
        \(arrayJumpsAcrobatic.count): \(NSLocalizedString("Acrobatics", comment: "")):
        \(arrayJumpsAff.count): \(NSLocalizedString("AFF", comment: ""))
        \(arrayJumpsBase.count): \(NSLocalizedString("Base", comment: ""))
        \(arrayJumpsBaseWingsuit.count): \(NSLocalizedString("Base/Wingsuit", comment: ""))
        \(arrayJumpsCanopyFormation.count): \(NSLocalizedString("Canopy formation", comment: ""))
        \(arrayJumpsFreeFly.count): \(NSLocalizedString("Freefly", comment: "")):
        \(arrayJumpsFreeStyle.count): \(NSLocalizedString("Freestyle", comment: ""))
        \(arrayJumpsFun.count): \(NSLocalizedString("Fun", comment: ""))
        \(arrayJumpsGroup.count): \(NSLocalizedString("Group", comment: ""))
        \(arrayJumpsInstructor.count): \(NSLocalizedString("Instructor", comment: ""))
        """
    }
    
    // MARK: TOP MISSIONS:
    
    private func setTopMission() {
        var missionCounts: [String: Int] = [:]

        for jump in arrayJumpsRealm {
            if let count = missionCounts[jump.mission?.localizedValue ?? ""] {
                missionCounts[jump.mission?.localizedValue ?? ""] = count + 1
            } else {
                missionCounts[jump.mission?.localizedValue ?? ""] = 1
            }
        }

        let topMissions = missionCounts.sorted(by: {
            if $0.value == $1.value {
                return $0.key.localizedCaseInsensitiveCompare($1.key) == .orderedAscending
            }
            return $0.value > $1.value
        }).prefix(10)

        var maxMissionsText = ""
        for (mission, count) in topMissions {
            maxMissionsText += "\(mission): \(count)\n"
        }
        
        if missionCounts.count == 0 {
            topMissionsLabel.text = ""
        } else {
            topMissionsLabel.text = maxMissionsText
        }
    }

    
    // MARK: MISSIONS TWO:
    
    private func setMissionsTwo() {
        var arrayJumpsParachuting: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Military", comment: "") {
                arrayJumpsParachuting.append(jump)
            }
        }
        
        var arrayJumpsParaSki: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Para-ski", comment: "") {
                arrayJumpsParaSki.append(jump)
            }
        }
        
        var arrayJumpsProximity: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Proximity", comment: "") {
                arrayJumpsProximity.append(jump)
            }
        }

        var arrayJumpsSkySurfing: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Skysurfing", comment: "") {
                arrayJumpsSkySurfing.append(jump)
            }
        }
        
        var arrayJumpsStaticLine: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Static-line", comment: "") {
                arrayJumpsStaticLine.append(jump)
            }
        }
        
        var arrayJumpsSwoop: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Piloting", comment: "") {
                arrayJumpsSwoop.append(jump)
            }
        }
        
        var arrayJumpsTandem: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Tandem", comment: "") {
                arrayJumpsTandem.append(jump)
            }
        }
        
        var arrayJumpsVerticalAcro: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Vertical", comment: "") {
                arrayJumpsVerticalAcro.append(jump)
            }
        }
        
        var arrayJumpsVideo: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Video", comment: "") {
                arrayJumpsVideo.append(jump)
            }
        }
        
        var arrayJumpsWingsuit: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Wingsuit", comment: "") {
                arrayJumpsWingsuit.append(jump)
            }
        }
        
        var arrayJumpsFormation: [JumpClassRealm] = []
        for jump in arrayJumpsRealm {
            if jump.mission?.localizedValue == NSLocalizedString("Formation", comment: "") {
                arrayJumpsFormation.append(jump)
            }
        }
        
        missionsTwoLabel.text = """
        \(NSLocalizedString("Military", comment: "")): \(arrayJumpsParachuting.count)
        \(NSLocalizedString("Para-ski", comment: "")): \(arrayJumpsParaSki.count)
        \(NSLocalizedString("Proximity", comment: "")): \(arrayJumpsProximity.count)
        \(NSLocalizedString("Skysurfing", comment: "")): \(arrayJumpsSkySurfing.count)
        \(NSLocalizedString("Static-line", comment: "")): \(arrayJumpsStaticLine.count)
        \(NSLocalizedString("Piloting", comment: "")): \(arrayJumpsSwoop.count)
        \(NSLocalizedString("Tandem", comment: "")): \(arrayJumpsTandem.count)
        \(NSLocalizedString("Vertical", comment: "")): \(arrayJumpsVerticalAcro.count)
        \(NSLocalizedString("Video", comment: "")): \(arrayJumpsVideo.count)
        \(NSLocalizedString("Wingsuit", comment: "")): \(arrayJumpsWingsuit.count)
        \(NSLocalizedString("Formation", comment: "")): \(arrayJumpsFormation.count)
        """
    }
        
    // MARK: RELOAD DATA:
    
    private func reloadData() {
        activityIndicator.startAnimating()
        let mainQueue = DispatchQueue.main
        mainQueue.async {
            self.setGeneralInfo()
            self.setTotalJumps()
            self.setJumpsYear()
            self.setCategories()
            self.setMaxHeight()
            self.setAverageHeight()
            self.setMinHeight()
            self.setMaxDay()
            self.setAverageTime()
            self.setCountCutaway()
            self.setDateFirst()
            self.setMaxTime()
            self.setDateLast()
            self.setAircrafts()
            self.setCanopies()
            self.setLocations()
            self.setMissionsOne()
            self.setMissionsTwo()
            self.setTopMission()
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - FUNCTIONS DELEGATES:
    
    @objc private func generalInfoButtonTapped() {
        delegate?.tapGeneralInfoButton()
    }
    
    @objc private func totalButtonTapped() {
        delegate?.tapTotalButton()
    }
    
    @objc private func yearButtonTapped() {
        delegate?.tapYearButton()
    }
    
    @objc private func categoryButtonTapped() {
        delegate?.tapCategoryButton()
    }
    
    @objc private func maxHeightButtonTapped() {
        delegate?.tapMaxHeightButton()
    }
    
    @objc private func averageHeightButtonTapped() {
        delegate?.tapAverageHeightButton()
    }
    
    @objc private func minHeightButtonTapped() {
        delegate?.tapMinHeightButton()
    }
    
    @objc private func maxDayButtonTapped() {
        delegate?.tapMaxDayButton()
    }
    
    @objc private func averageTimeButtonTapped() {
        delegate?.tapAverageTimeButton()
    }
    
    @objc private func countCutawayButtonTapped() {
        delegate?.tapCountCutawayButton()
    }
    
    @objc private func dateFirstButtonTapped() {
        delegate?.tapDateFirstButton()
    }
    
    @objc private func maxTimeButtonTapped() {
        delegate?.tapMaxTimeButton()
    }
    
    @objc private func dateLastButtonTapped() {
        delegate?.tapDateLastButton()
    }
    
    @objc private func aircraftsButtonTapped() {
        delegate?.tapAircraftsButton()
    }
    
    @objc private func canopiesButtonTapped() {
        delegate?.tapCanopiesButton()
    }
    
    @objc private func locationsButtonTapped() {
        delegate?.tapLocationsButton()
    }
}
