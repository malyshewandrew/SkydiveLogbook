import SpriteKit
import UIKit

class GameVC: UIViewController {
    // MARK: - PROPERTIES:

    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettings()
        addSubviews()
        configureConstraints()
        configureUI()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews()
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {}
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: TAB BAR CONTROLLER:
        
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - SET SETTINGS:
    
    private func setSettings() {
        let skView = SKView(frame: view.frame)
        view.addSubview(skView)
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}

// MARK: - EXTENSION:
