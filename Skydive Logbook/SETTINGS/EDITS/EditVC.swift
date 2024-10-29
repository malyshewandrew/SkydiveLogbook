import UIKit

final class EditVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let segmentControl = UISegmentedControl()
    private let containerView = UIView()
    private let accountViewController = EditAccountVC()
    private let locationViewController = EditLocationsVC()
    private let aircraftsViewController = EditAircraftsVC()
    private let canopiesViewController = EditCanopiesVC()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
        segmentControl.selectedSegmentIndex = 0
        segmentedControlValueChanged(segmentControl)
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(segmentControl, containerView)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        // MARK: SEGMENT CONTROL:

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        // MARK: CONTAINER CONTROLLER:
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 15).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: SEGMENT CONTROL:
        
        segmentControl.insertSegment(withTitle: NSLocalizedString("Account", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Locations", comment: ""), at: 1, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Aircraft", comment: ""), at: 2, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Canopy", comment: ""), at: 3, animated: true)
        segmentControl.backgroundColor = .colorCell
        segmentControl.selectedSegmentTintColor = .systemBlue
        segmentControl.layer.borderColor = UIColor.colorCell.cgColor
        segmentControl.layer.borderWidth = 2
        segmentControl.clipsToBounds = true
        let normalTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white]
        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        let selectedTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white]
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    // MARK: - HELPERS:
    
    // MARK: SEGMENT CONTROL VALUE CHANGED:

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        removeChildViewControllers()
        
        switch sender.selectedSegmentIndex {
        case 0:
            VibrationManager.instance.vibrationStandart()
            addChildVC(accountViewController)
        case 1:
            VibrationManager.instance.vibrationStandart()
            addChildVC(locationViewController)
        case 2:
            VibrationManager.instance.vibrationStandart()
            addChildVC(aircraftsViewController)
        case 3:
            VibrationManager.instance.vibrationStandart()
            addChildVC(canopiesViewController)
        default:
            break
        }
    }
    
    // MARK: ADD CHILD VIEW CONTROLLER:
    
    private func addChildVC(_ child: UIViewController) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }
    
    // MARK: REMOVE CHILD VIEW CONTROLLER:
    
    private func removeChildViewControllers() {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}
