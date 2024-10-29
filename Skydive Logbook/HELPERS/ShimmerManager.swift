import UIKit
import ShimmerSwift

final class ShimmerManager {
    
    // MARK: - STATIC:

    static let instance = ShimmerManager()
    
    // MARK: - PRIVATE INIT:

    private init() {}
    
    // MARK: - PUBLIC METHODS:

    func addShimmerEffect<T: UIView>(shimmerView: ShimmeringView, toView: T, speed: CGFloat) {
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        shimmerView.topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
        shimmerView.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        shimmerView.leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
        shimmerView.trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
        shimmerView.layer.cornerRadius = cornerRadius15
        shimmerView.isShimmering = true
        shimmerView.layer.masksToBounds = true
        shimmerView.shimmerSpeed = speed
        shimmerView.contentView = toView
    }
}
