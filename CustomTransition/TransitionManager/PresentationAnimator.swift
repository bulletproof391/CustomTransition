//
//  PresentationAnimator.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Properties

    let transitionDuration: Double = 0.8

    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect: UIBlurEffect = .init(style: .light)
        let view: UIVisualEffectView = .init(effect: blurEffect)

        return view
    }()

    lazy var dimmingView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .black

        return view
    }()

    lazy var whiteView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .white

        return view
    }()

    // MARK: - Functions

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.subviews.forEach { $0.removeFromSuperview() }

        // Get From and To View Controllers

        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? DailyAppsViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? AppDetailViewController
        else {
            return
        }

        // Before animations

        let detailView = toVC.view as! AppDetailView

        let cardView = fromVC.getSelectedCard()
        let rectangle = cardView.convert(
            cardView.frame,
            to: nil
        )

        detailView.frame = rectangle
        detailView.layer.cornerRadius = cardView.layer.cornerRadius
        detailView.layer.masksToBounds = true
        detailView.updateConstraintsToCardMode()

        containerView.addSubview(detailView)
        detailView.layoutIfNeeded()

        // Setup Card before transition

        cardView.isHidden = true

        // Animations

        let expandAnimator = makeExpandPropertyAnimator()

        detailView.updateConstraintsToFullMode()

        expandAnimator.addAnimations {
            detailView.frame = transitionContext.finalFrame(for: toVC)
            detailView.layer.cornerRadius = 0.0
        }

        // After animations

        expandAnimator.addCompletion { _ in
            cardView.isHidden = false
            transitionContext.completeTransition(true)
        }

        expandAnimator.startAnimation()
    }

    private func makeExpandPropertyAnimator() -> UIViewPropertyAnimator {
        let springTimingParameters: UISpringTimingParameters = .init(
            dampingRatio: 0.75,
            initialVelocity: .init(
                dx: 0.0,
                dy: 4.0
            )
        )

        let animator = UIViewPropertyAnimator(
            duration: transitionDuration,
            timingParameters: springTimingParameters
        )

        return animator
    }
}
