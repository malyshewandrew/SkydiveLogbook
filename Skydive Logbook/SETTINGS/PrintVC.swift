import AlertKit
import PDFKit
import RealmSwift
import UIKit
import Lottie
import ShimmerSwift

final class PrintVC: UIViewController {
    // MARK: - PROPERTIES:
    
    private let printLottie = LottieAnimationView(name: "Print")
    private let printLabel = UILabel()
    private let printButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let realmManager = RealmManager()
    
    // MARK: - LIFYCYCLE:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    // MARK: - ADD SUBVIEWS:
    
    private func addSubviews() {
        view.addSubviews(printLottie, printLabel, printButton)
    }
    
    // MARK: - CONFIGURE CONSTRAINTS:
    
    private func configureConstraints() {
        
        // MARK: PRINT LOTTIE:
        
        printLottie.translatesAutoresizingMaskIntoConstraints = false
        printLottie.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        printLottie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        printLottie.heightAnchor.constraint(equalToConstant: 75).isActive = true
        printLottie.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        // MARK: PRINT LABEL:
        
        printLabel.translatesAutoresizingMaskIntoConstraints = false
        printLabel.topAnchor.constraint(equalTo: printLottie.bottomAnchor).isActive = true
        printLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        printLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        
        // MARK: PRINT BUTTON:
        
        printButton.translatesAutoresizingMaskIntoConstraints = false
        printButton.topAnchor.constraint(equalTo: printLabel.bottomAnchor, constant: 25).isActive = true
        printButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        printButton.heightAnchor.constraint(equalToConstant: height45).isActive = true
        printButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    // MARK: - CONFIGURE UI:
    
    private func configureUI() {
        // MARK: VIEW:
        
        view.backgroundColor = .colorBackground
        
        // MARK: PRINT LOTTIE:
        
        printLottie.loopMode = .loop
        printLottie.animationSpeed = 0.8
        
        // MARK: PRINT LABEL:
        
        printLabel.text = NSLocalizedString("Description text / print", comment: "")
        printLabel.textColor = .white
        printLabel.textAlignment = .center
        printLabel.numberOfLines = 0
        printLabel.font = FontManager.regular(size: 9).uiFont
        
        // MARK: PRINT BUTTON:
        
        printButton.setTitle(NSLocalizedString("Print / settings", comment: ""), for: .normal)
        printButton.layer.cornerRadius = cornerRadius15
        printButton.backgroundColor = .colorCell
        printButton.titleLabel?.font = FontManager.medium(size: 14).uiFont
        printButton.setTitleColor(.colorWhite, for: .normal)
        printButton.setTitleColor(.systemBlue, for: .highlighted)
        printButton.addTarget(self, action: #selector(printButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - HELPERS:
    
    // MARK: PRINT BUTTON TAPPED:

    @objc private func printButtonTapped() {
        VibrationManager.instance.vibrationStandart()
        printLottie.play()
        _ = PDFDocument()
        let jumps = realmManager.localRealm.objects(JumpClassRealm.self)
        let skydiver = realmManager.localRealm.objects(AccountClassRealm.self)
        
        let pdfMetaData = [
            kCGPDFContextCreator: "SkydiveBook",
            kCGPDFContextAuthor: "LogBook Print",
            kCGPDFContextTitle: "Jumps Report"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { context in
            context.beginPage()
            var currentY: CGFloat = 20
            
            let title = createTitle(for: skydiver)
            draw(text: title.text, at: title.rect, with: title.attributes, currentY: &currentY, in: context, pageRect: pageRect)
            
            let description = NSLocalizedString("Description text / print", comment: "")
            let descriptionAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 6),
                .foregroundColor: UIColor.black
            ]
            let descriptionRect = CGRect(x: 65, y: currentY, width: pageRect.width / 1.4, height: 70)
            description.draw(in: descriptionRect, withAttributes: descriptionAttributes)
            currentY += 60
            
            drawJumpDetails(for: jumps, currentY: &currentY, in: context, pageRect: pageRect)
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let formattedDate = dateFormatter.string(from: date)
            
            let footer = NSLocalizedString("Date", comment: "") + ": \(formattedDate)           _________________________________"
            let footerAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.black
            ]
            let footerSize = footer.size(withAttributes: footerAttributes)
            let footerRect = CGRect(x: 50 / 2, y: pageRect.height - footerSize.height - 20, width: footerSize.width, height: footerSize.height)
            footer.draw(in: footerRect, withAttributes: footerAttributes)
        }
        
        saveAndPresentPDF(data: data)
    }
    
    // MARK: CREATE TITLE:
    
    private func createTitle(for skydiver: Results<AccountClassRealm>) -> (text: String, rect: CGRect, attributes: [NSAttributedString.Key: Any]) {
        let nicknameValue = skydiver.first?.nickname ?? ""
        let title = "\(NSLocalizedString("Title document / print", comment: ""))\n\(nicknameValue)"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]
        let titleSize = title.size(withAttributes: titleAttributes)
        let titleRect = CGRect(x: (8.5 * 72.0 - titleSize.width - 50) / 2, y: 20, width: titleSize.width, height: titleSize.height)
        return (title, titleRect, titleAttributes)
    }
    
    // MARK: DRAW JUMP DETAILS:

    private func drawJumpDetails(for jumps: Results<JumpClassRealm>, currentY: inout CGFloat, in context: UIGraphicsPDFRendererContext, pageRect: CGRect) {
        var number = 1
        for jump in jumps {
            let missionValue = jump.mission?.localizedValue ?? "-"
            let cutawayValue = jump.cutaway?.localizedValue ?? ""
            
            let text = """
            №: \(number). \(NSLocalizedString("Date", comment: "")): \(jump.date). \(NSLocalizedString("Location", comment: "")): \(jump.location). \(NSLocalizedString("Aircraft", comment: "")): \(jump.aircraft). \(NSLocalizedString("Canopy", comment: "")): \(jump.canopy).
            \(NSLocalizedString("Mission", comment: "")): \(missionValue). \(NSLocalizedString("Height", comment: "")): \(jump.height). \(NSLocalizedString("Time", comment: "")): \(jump.time). \(NSLocalizedString("Cutaway", comment: "")): \(cutawayValue)
            """
            number += 1
            let textRect = CGRect(x: 50, y: currentY + 15, width: pageRect.width - 40, height: 50)
            text.draw(in: textRect, withAttributes: nil)
            currentY += 45
            if currentY + 50 > pageRect.height {
                context.beginPage()
                currentY = 20
            }
        }
    }
    
    // MARK: DRAW:

    private func draw(text: String, at rect: CGRect, with attributes: [NSAttributedString.Key: Any], currentY: inout CGFloat, in context: UIGraphicsPDFRendererContext, pageRect: CGRect) {
        text.draw(in: rect, withAttributes: attributes)
        currentY += rect.height + 20
    }
    
    // MARK: SAVE AND PRESENT PDF:

    private func saveAndPresentPDF(data: Data) {
        let pdfURL = getDocumentsDirectory().appendingPathComponent("JumpsReport.pdf")
        do {
            activityIndicator.center = view.center
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            try data.write(to: pdfURL)
            let activityViewController = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)
            activityViewController.completionWithItemsHandler = { _, completed, _, _ in
                if completed {
                    self.alertKitSuccess()
                } else {
                    self.alertKitError()
                }
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
            present(activityViewController, animated: true, completion: nil)
        } catch {
            alertKitError()
            print("Could not save PDF file: \(error.localizedDescription)")
        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // MARK: ALERT KIT SUCCESS:

    private func alertKitSuccess() {
        AlertKitAPI.present(
            title: NSLocalizedString("Success / alert kit", comment: ""),
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }

    // MARK: ALERT KIT ERROR:

    private func alertKitError() {
        AlertKitAPI.present(
            title: NSLocalizedString("Error / alert kit", comment: ""),
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
    }
}

// MARK: - EXTENSIONS:
