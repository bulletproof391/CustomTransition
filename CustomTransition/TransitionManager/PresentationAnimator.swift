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

    lazy var shadowView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = .init(
            width: -1.0,
            height: -2.0
        )

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
        detailView.closeButton.alpha = 0.0

        containerView.addSubview(detailView)
        detailView.layoutIfNeeded()

        // Add shadow

        shadowView.frame = rectangle
        shadowView.layer.cornerRadius = cardView.layer.cornerRadius
        containerView.insertSubview(
            shadowView,
            belowSubview: detailView
        )

        // Setup Card before transition

        cardView.isHidden = true
        detailView.updateConstraintsToFullMode()

        // Animations

        let expandAnimator = makeExpandPropertyAnimator()

        expandAnimator.addAnimations { [weak self] in
            detailView.frame = transitionContext.finalFrame(for: toVC)
            detailView.layer.cornerRadius = 0.0
            detailView.closeButton.alpha = 1.0

            self?.shadowView.frame = transitionContext.finalFrame(for: toVC)
            self?.shadowView.layer.cornerRadius = 0.0
        }

        // After animations

        expandAnimator.addCompletion { [weak self] _ in
            cardView.isHidden = false
            self?.shadowView.removeFromSuperview()
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

    private func removeShadowFor(_ view: UIView) {
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.0
        view.layer.shadowRadius = 0.0
        view.layer.shadowOffset = .zero
    }
}
