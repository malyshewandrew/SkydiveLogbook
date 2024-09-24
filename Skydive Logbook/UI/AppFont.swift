import UIKit

enum AppFont {
    case regular(size: CGFloat)
    case semibold(size: CGFloat)
    case medium(size: CGFloat)
    case bold(size: CGFloat)
    case thin(size: CGFloat)
    case black(size: CGFloat)
    
    var uiFont: UIFont {
        switch self {
        case .regular(let size):
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case .semibold(let size):
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        case .medium(let size):
            return UIFont.systemFont(ofSize: size, weight: .medium)
        case .bold(let size):
            return UIFont.systemFont(ofSize: size, weight: .bold)
        case .thin(let size):
            return UIFont.systemFont(ofSize: size, weight: .thin)
        case .black(let size):
            return UIFont.systemFont(ofSize: size, weight: .black)
        }
    }
}
