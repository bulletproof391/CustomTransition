//
//  TransitionManager.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

final class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    // MARK: - Public Functions

    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PresentationAnimator()
    }

    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        DismissalAnimator()
    }
}
