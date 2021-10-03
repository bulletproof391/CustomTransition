//
//  InteractiveAnimator.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class DismissalInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Properties

    var inProgress: Bool = false

    private var shouldComplete: Bool = false

    private var shouldCompleteTransition: Bool = false

    private weak var presentedController: UIViewController?

    // MARK: - Initializer

    init(viewController: UIViewController) {
        super.init()

        completionSpeed = 0.99
        presentedController = viewController
        prepareGestureRecognizer(in: viewController.view.subviews.first!)
    }

    // MARK: - Private Functions

    private func prepareGestureRecognizer(in view: UIView) {
        let recognizer: UIPanGestureRecognizer = .init(
            target: self,
            action: #selector(handleGesture(_:))
        )

        recognizer.maximumNumberOfTouches = 1
        view.addGestureRecognizer(recognizer)
    }

    @objc
    func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = presentedController?.view else {
            return
        }

        let translation: CGPoint = gestureRecognizer.translation(in: view)
        let velocity: CGPoint = gestureRecognizer.velocity(in: view)
        let isVerticalScroll: Bool = abs(velocity.y) > abs(velocity.x)

        completionSpeed = min(1 - percentComplete, 0.99)

        switch gestureRecognizer.state {
        case .began:
            inProgress = true
            presentedController?.dismiss(animated: true)
        case .changed:
            if inProgress {
                let percentage: CGFloat = translation.y / (presentedController?.view.bounds.height ?? 100.0)
                shouldComplete = percentage > 0.3

                update(percentage)
            }
        case .cancelled:
            inProgress = false
            cancel()
        case .ended:
            inProgress = false
            shouldComplete && isVerticalScroll && translation.y > 0 ?
                finish() :
                cancel()
        default:
            break
        }

    }
}
