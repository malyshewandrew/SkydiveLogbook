import Lottie
import UIKit

final class JumpVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let tableView = UITableView()
    private var selectedJump: JumpStructure
    var jumpNumber: Int = 0
    var onTap: (() -> ())?

    init(selectedJump: JumpStructure) {
        self.selectedJump = selectedJump
        super.init(nibName: nil, bundle: nil)
    }

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
        view.addSubviews(tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        
        // MARK: VIEW:
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = colorBackground

        // MARK: TABLE VIEW:
        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JumpCell.self, forCellReuseIdentifier: "JumpCell")
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
        cell.configure(number: String(jumpNumber), date: selectedJump.date, location: selectedJump.location, aircraft: selectedJump.aircraft, canopy: selectedJump.canopy, mission: selectedJump.mission, height: selectedJump.height, time: selectedJump.time, cutaway: selectedJump.cutaway, comment: selectedJump.comment)
        return cell
    }
}
