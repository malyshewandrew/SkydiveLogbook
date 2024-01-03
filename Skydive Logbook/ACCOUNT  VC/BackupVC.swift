import UIKit

final class BackupVC: UIViewController {
    // MARK: - PROPERTIES:

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
    }

    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        
    }

    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        
    }

    // MARK: - CONFIGURE UI:

    private func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground

        // MARK: NAVIGATION CONTROLLER:

        navigationController?.navigationBar.isHidden = false
    }
}
