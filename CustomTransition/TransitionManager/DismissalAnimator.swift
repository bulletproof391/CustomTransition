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

        cardView.isHidden = true

        // Animations

        let collapseAnimator = makeCollapsePropertyAnimator()
        let shrinkAnimator = makeShrinkPropertyAnimator()

        shrinkAnimator.addAnimations {
            detailView.transform = CGAffineTransform(
                scaleX: 0.9,
                y: 0.9
            )
            detailView.layer.cornerRadius = cardView.layer.cornerRadius
        }

        shrinkAnimator.addCompletion { _ in
            detailView.updateConstraintsToCardMode()
            collapseAnimator.startAnimation()
        }


        collapseAnimator.addAnimations {
            detailView.transform = .identity
            detailView.frame = rectangle
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
