import Lottie
import UIKit

final class NewJumpVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let newJumpLottie = LottieAnimationView(name: "NewJump")
    private let confettiLottie = LottieAnimationView(name: "NewJumpConfetti")
    private let confettiButton = UIButton()
    private let vibrationOn = Vibration()
    private let tableView = UITableView()
    
    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewJumpCell.self, forCellReuseIdentifier: "NewJumpCell")
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - ADD SUBVIEWS:

    private func addSubviews() {
        view.addSubviews(confettiLottie, tableView, newJumpLottie, confettiButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINS:

    private func configureConstrains() {
        // MARK: ANIMATION NEW JUMP LOTTIE:

        newJumpLottie.translatesAutoresizingMaskIntoConstraints = false
        newJumpLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newJumpLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        newJumpLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        newJumpLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        // MARK: ANIMATION LOTTIE CONFETTI:

        confettiLottie.translatesAutoresizingMaskIntoConstraints = false
        confettiLottie.centerXAnchor.constraint(equalTo: newJumpLottie.centerXAnchor).isActive = true
        confettiLottie.centerYAnchor.constraint(equalTo: newJumpLottie.centerYAnchor).isActive = true
        confettiLottie.heightAnchor.constraint(equalToConstant: 300).isActive = true
        confettiLottie.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        // MARK: BUTTON FOR ANIMATION LOTTIE CONFETTI:

        confettiButton.translatesAutoresizingMaskIntoConstraints = false
        confettiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confettiButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        confettiButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        confettiButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: newJumpLottie.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    // MARK: - CONFIGURE UI:

    private func configureUI() {
        view.backgroundColor = colorBackground
        
        // MARK: ANIMATIONS:

        newJumpLottie.play()
        newJumpLottie.loopMode = .autoReverse
        
        // MARK: THREE TAP FOR ANIMATIONS:

        let confettiGesture = UITapGestureRecognizer(target: self, action: #selector(confetti))
        confettiGesture.numberOfTapsRequired = 3
        confettiButton.addGestureRecognizer(confettiGesture)
        
        // MARK: TABLE VIEW:

        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }
    
    // MARK: - FUNC FOR CONFETTI + VIBRATION:

    @objc func confetti() {
        vibrationOn.vibrationSucces()
        confettiLottie.play()
    }
}
    
// MARK: - EXTENSION FOR TABLE VIEW:

extension NewJumpVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - COUNT OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    // MARK: CUSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewJumpCell", for: indexPath) as? NewJumpCell else { return UITableViewCell() }
        return cell
    }
}
