//
//  DismissalAnimator.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class DismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Properties

    let transitionDuration: Double = 0.7

    let shrinkDuration: Double = 0.1

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
            let fromVC = transitionContext.viewController(forKey: .from) as? AppDetailViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? DailyAppsViewController
        else {
            return
        }

        // Before animations

        let detailView = fromVC.view as! AppDetailView

        let cardView = toVC.getSelectedCard()
        let rectangle = cardView.convert(
            cardView.frame,
            to: nil
        )

        containerView.addSubview(detailView)
        detailView.layer.masksToBounds = true
        detailView.layoutIfNeeded()

        // Add shadow

        shadowView.frame = detailView.frame
        shadowView.alpha = 0.0
        containerView.insertSubview(
            shadowView,
            belowSubview: detailView
        )

        // Setup Card before transition

        cardView.isHidden = true

        // Animations

        let collapseAnimator = makeCollapsePropertyAnimator()
        let shrinkAnimator = makeShrinkPropertyAnimator()

        shrinkAnimator.addAnimations { [weak self] in
            detailView.transform = CGAffineTransform(
                scaleX: 0.9,
                y: 0.9
            )
            detailView.layer.cornerRadius = cardView.layer.cornerRadius
            detailView.closeButton.alpha = 0.5

            self?.shadowView.alpha = 1.0
            self?.shadowView.layer.cornerRadius = cardView.layer.cornerRadius
            self?.shadowView.transform = detailView.transform
        }

        shrinkAnimator.addCompletion { _ in
            detailView.updateConstraintsToCardMode()
            collapseAnimator.startAnimation()
        }

        collapseAnimator.addAnimations { [weak self] in
            detailView.transform = .identity
            detailView.frame = rectangle
            detailView.closeButton.alpha = 0.0

            self?.shadowView.frame = rectangle
        }

        // After animations

        collapseAnimator.addCompletion { _ in
            cardView.isHidden = false
            transitionContext.completeTransition(true)
        }

        shrinkAnimator.startAnimation()
    }


    private func makeCollapsePropertyAnimator() -> UIViewPropertyAnimator {
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

    func makeShrinkPropertyAnimator() -> UIViewPropertyAnimator {
        .init(
            duration: shrinkDuration,
            curve: .easeOut
        )
    }
}
