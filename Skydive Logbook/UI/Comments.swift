import Foundation

/*
MARK: - ПОДНЯТИЕ ЯЧЕЙКИ ДЛЯ ВВОДА КОММЕНТАРИЯ:
 file NewJump
 
 viewDidLoad:

 NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
 NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
 
 AFTER CLASS:
 // MARK: - ПОДНЯТИЕ ЯЧЕЙКИ ДЛЯ ВВОДА КОММЕНТАРИЯ:
 @objc func keyboardWillShow(notification: Notification) {
     if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
         let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
         tableView.contentInset = contentInsets
         tableView.scrollIndicatorInsets = contentInsets
     }
 }
 
 @objc func keyboardWillHide(notification: Notification) {
     tableView.contentInset = .zero
     tableView.scrollIndicatorInsets = .zero
 }
 */

/*
 // MARK: - ЧЕРЕЗ FOR EACH:
 // MARK: - ADD SUBVIEWS:
 extension UIView {
     func addSubviews(_ views: UIView...) {
         views.forEach(addSubview)
         }
     }
 */

/*
 // MARK: - КНОПКА ПРИЛОЖЕНИЯ ПОГОДЫ

 // MARK: - WEATHER BUTTON:

 weatherButton.translatesAutoresizingMaskIntoConstraints = false
 weatherButton.topAnchor.constraint(equalTo: calculatorButton.bottomAnchor, constant: 15).isActive = true
 weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 weatherButton.heightAnchor.constraint(equalToConstant: height35).isActive = true
 weatherButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55).isActive = true
 
 // MARK: - WEATHER BUTTON:

 weatherButton.setTitle("Прогоз погоды", for: .normal)
 weatherButton.layer.cornerRadius = cornerRadius10
 weatherButton.backgroundColor = colorCell
 weatherButton.titleLabel?.font = fontMediumStandart14
 weatherButton.setTitleColor(.white, for: .normal)
 weatherButton.addTarget(self, action: #selector(tapOnWeatherButton), for: .touchUpInside)
 
 // MARK: - FUNC FOR WEATHER:

 @objc func tapOnWeatherButton(_ sender: UIButton) {
     if let weatherURL = URL(string: "weather://") {
         if UIApplication.shared.canOpenURL(weatherURL) {
             UIApplication.shared.open(weatherURL, options: [:], completionHandler: nil)
         } else {
             let alert = UIAlertController(title: "Приложение не найдено", message: "Убедитесь что приложение 'Погода' установлено.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
             present(alert, animated: true)
         }
     }
 }
 */
