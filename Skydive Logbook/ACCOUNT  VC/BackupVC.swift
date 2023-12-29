import UIKit

final class BackupVC: UIViewController {
    // MARK: - PROPERTIES:

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - ADD SUBVIEWS:

    func addSubviews() {}

    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {}

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: - VIEW:

        view.backgroundColor = colorBackground
    }
}
