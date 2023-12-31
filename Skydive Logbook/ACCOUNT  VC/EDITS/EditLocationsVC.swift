import AVFoundation
import Lottie
import UIKit

final class EditLocationsVC: UIViewController {
    // MARK: - PRIVATE PROPERTIES:

    private let vibrationOn = Vibration()
    private let locationLottie = LottieAnimationView(name: "Location")
    private let enterTextTextField = UITextField()
    private let saveButton = UIButton()
    private let cleanButton = UIButton()
    private let tableView = UITableView()
    private var player = AVAudioPlayer()

    // MARK: - LIFECYCLE:

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstrains()
        configureUI()
        configureTableView()
        configureGestures()
        enterTextTextField.delegate = self
    }

    // MARK: - ADD SUBVIEWS:

    func addSubviews() {
        view.addSubviews(locationLottie, enterTextTextField, saveButton, cleanButton, tableView)
    }

    // MARK: - CONFIGURE CONSTRAINS:

    func configureConstrains() {
        // MARK: ANIMATION:

        locationLottie.translatesAutoresizingMaskIntoConstraints = false
        locationLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        locationLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        locationLottie.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

        // MARK: TEXT VIEW:

        enterTextTextField.translatesAutoresizingMaskIntoConstraints = false
        enterTextTextField.topAnchor.constraint(equalTo: locationLottie.bottomAnchor, constant: 20).isActive = true
        enterTextTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enterTextTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        enterTextTextField.heightAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 1).isActive = true

        // MARK: SAVE BUTTON:

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: enterTextTextField.bottomAnchor, constant: 15).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true

        // MARK: CLEAN BUTTON:

        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        cleanButton.topAnchor.constraint(equalTo: enterTextTextField.bottomAnchor, constant: 15).isActive = true
        cleanButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        cleanButton.heightAnchor.constraint(equalToConstant: height40).isActive = true
        cleanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.24).isActive = true

        // MARK: TABLE VIEW:

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }

    // MARK: - CONFIGURE UI:

    func configureUI() {
        // MARK: VIEW:

        view.backgroundColor = colorBackground

        // MARK: NAVIGATION CONTROLLER

        navigationController?.navigationBar.isHidden = false

        // MARK: ANIMATION:

        locationLottie.play()
        locationLottie.loopMode = .loop

        // MARK: TEXT VIEW:

        enterTextTextField.backgroundColor = colorTabBar
        enterTextTextField.textColor = colorWhite
        enterTextTextField.layer.cornerRadius = cornerRadius10
        enterTextTextField.textAlignment = textAligmentCenter
        enterTextTextField.placeholder = NSLocalizedString("Enter location", comment: "")

        // MARK: SAVE BUTTON:

        saveButton.backgroundColor = colorCell
        saveButton.titleLabel?.font = fontMediumStandart14
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = cornerRadius10
        saveButton.addTarget(self, action: #selector(tapSave), for: .touchUpInside)

        // MARK: CLEAN BUTTON:

        cleanButton.backgroundColor = colorTabBar
        cleanButton.titleLabel?.font = fontMediumStandart14
        cleanButton.setTitleColor(.white, for: .normal)
        cleanButton.setTitle(NSLocalizedString("Clean", comment: ""), for: .normal)
        cleanButton.layer.cornerRadius = cornerRadius10
        cleanButton.addTarget(self, action: #selector(tapOnCleanButton), for: .touchUpInside)
    }

    // MARK: - CONFIGURE TABLE VIEW

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditLocationsCell.self, forCellReuseIdentifier: "EditLocationsCell")
        tableView.backgroundColor = colorBackground
        tableView.separatorStyle = .none
    }

    // MARK: - CONFIGURE GESTURES:

    private func configureGestures() {
        // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - HELPERS:

    // MARK: ACTION FOR TAP ON SAVE BUTTON:

    @objc private func tapSave() {
        guard enterTextTextField.text != "" else {
            actionButtonSaveRedColor()
            vibrationOn.vibrationError()
            return
        }
        arrayLocationPickerViewValues.append(enterTextTextField.text ?? "")
        actionButtonSaveGreenColor()
        vibrationOn.vibrationSucces()
        playSoundSucces()
        enterTextTextField.text = ""
        enterTextTextField.resignFirstResponder()
        tableView.reloadData()
    }

    // MARK: ACTION FOR TAP ON CLEAN BUTTON:

    @objc private func tapOnCleanButton() {
        enterTextTextField.text = ""
        actionButtonCleanChangeColor()
        vibrationOn.vibrationSucces()
        tableView.reloadData()
    }

    // MARK: FUNC FOR CHANGE COLOR BUTTONS "SAVE" AND "CLEAN":

    private func actionButtonSaveGreenColor() {
        saveButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = colorCell
        }
    }

    private func actionButtonSaveRedColor() {
        saveButton.backgroundColor = colorRed
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.saveButton.backgroundColor = colorCell
        }
    }

    private func actionButtonCleanChangeColor() {
        cleanButton.backgroundColor = colorGreen
        UIView.animate(withDuration: 1.5, delay: 0, options: .transitionCrossDissolve) {
            self.cleanButton.backgroundColor = colorTabBar
        }
    }

    // MARK: CUSTOM SOUND PLAY FOR BUTTON SAVE:

    private func playSoundSucces() {
        let url = Bundle.main.url(forResource: "Succes", withExtension: "mp3")
        guard let url = url else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }

    // MARK: TAP ON FREE SPACE FOR CLOSE ALL VIEWS ACTION:

    @objc private func tapGestureDone() {
        view.endEditing(true)
    }
}

// MARK: - EXTENSIONS:

extension EditLocationsVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: COUNTS OF CELLS:

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayLocationPickerViewValues.count
    }

    // MARK: COSTUM CELL:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditLocationsCell", for: indexPath) as? EditLocationsCell else { return UITableViewCell() }

        let locationString = arrayLocationPickerViewValues[indexPath.row]
        cell.configure(text: locationString)

        return cell
    }

    // MARK: DELETE CELL:

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertDelete = UIAlertController(title: NSLocalizedString("Delete location?", comment: ""), message: NSLocalizedString("This action cannot be undone.", comment: ""), preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive, handler: { _ in
                arrayLocationPickerViewValues.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.vibrationOn.vibrationSucces()
                tableView.reloadData()
            }))
            present(alertDelete, animated: true)
        }
    }
}

// MARK: - EXTENSION FOR TEXT FIELD DELEGATE: MAX COUNT OF CHARECTERS:

extension EditLocationsVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let range = Range(range, in: text) else {
            return false
        }
        let newText = text.replacingCharacters(in: range, with: string)
        return newText.count <= 20
    }
}
