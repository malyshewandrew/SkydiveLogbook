import Lottie
import RealmSwift
import UIKit

final class JumpVC: UIViewController {
    // MARK: - PROPERTIES:

    private let backgroundJumpLottie = LottieAnimationView(name: "BackgroundJumpLottie")
    private let blackView = UIView()
    private let tableView = UITableView()
    private var selectedJump: JumpClassRealm
    var jumpNumber: Int = 0
    var onTap: (() -> ())?

    init(selectedJump: JumpClassRealm) {
        self.selectedJump = selectedJump
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(backgroundJumpLottie, blackView, tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
        // MARK: BACKGROUND JUMP LOTTIE:
        
        backgroundJumpLottie.translatesAutoresizingMaskIntoConstraints = false
        backgroundJumpLottie.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundJumpLottie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundJumpLottie.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundJumpLottie.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // MARK: BLACK VIEW:

        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        blackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = .colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = true
        
        // MARK: BACKGROUND JUMP LOTTIE:
        
        backgroundJumpLottie.play()
        backgroundJumpLottie.loopMode = .loop
        backgroundJumpLottie.contentMode = .scaleAspectFill
        backgroundJumpLottie.layer.opacity = 1
        
        // MARK: BLACK VIEW:

        blackView.backgroundColor = .black
        blackView.layer.opacity = 0.94
    }

    // MARK: - CONFIGURE TABLE VIEW:

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JumpCell.self, forCellReuseIdentifier: "JumpCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
}

// MARK: - EXTENSION FOR TABLE VIEW:

extension JumpVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JumpCell", for: indexPath) as? JumpCell else { return UITableViewCell() }

        // MARK: CONFIGURE:
        cell.configure(number: String(jumpNumber), date: selectedJump.date, location: selectedJump.location, aircraft: selectedJump.aircraft, canopy: selectedJump.canopy, mission: selectedJump.mission?.localizedValue ?? "", height: selectedJump.height, time: selectedJump.time, cutaway: selectedJump.cutaway?.localizedValue ?? "", comment: selectedJump.comment)
        
        cell.backgroundColor = .clear

        // MARK: JUBILEE LOTTIE:
        cell.jubileeShow(number: jumpNumber)
        return cell
    }
}
