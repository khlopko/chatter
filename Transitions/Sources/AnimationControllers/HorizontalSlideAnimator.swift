//
//  HorizontalSlideAnimator.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Tools

// MARK: - HorizontalAnimatingController

public protocol HorizontalAnimatingController: AnimatableTransitioningController, PanTransitioningController {
}

// MARK: - HorizontalSlideAnimator

final class HorizontalSlideAnimator: NSObject, DrivingAnimationController, Animator {

    weak var context: UIViewControllerContextTransitioning?

    public var driver: InteractionDriver {
        return panDriver
    }
    private let panDriver = PanInteractionDriver(direction: .horizontal)

    private var forward: Bool = false

    func isValid(from: UIViewController, to: UIViewController) -> Bool {
        return from is HorizontalAnimatingController && to is HorizontalAnimatingController
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        panDriver.viewController = from
        prepare()
        animate()
    }

    private func prepare() {
        if let pan = from.pan {
            forward = pan.translation(in: from.mainView).x >= 0
        }
        fromView.frame = fromInitialFrame
        containerView.addSubview(toView)
        toView.frame = toFinalFrame.offsetBy(dx: toFinalFrame.width * directionK * -1, dy: 0)
        toView.layoutIfNeeded()
    }

    private var directionK: CGFloat {
        return forward ? 1 : -1
    }

    private func animate() {
        UIView.animate(
            withDuration: transitionDuration(using: context),
            animations: animations,
            completion: completion)
    }

    private func animations() {
        fromView.frame = fromInitialFrame.offsetBy(dx: fromInitialFrame.width * directionK, dy: 0)
        toView.frame = self.toFinalFrame
    }

    private func completion(_: Bool) {
        guard let context = context else {
            return
        }
        if context.transitionWasCancelled {
            fromView.frame = fromInitialFrame
            toView.frame = toInitialFrame
        }
        context.completeTransition(!context.transitionWasCancelled)
    }
}

private extension HorizontalSlideAnimator {

    var to: HorizontalAnimatingController {
        return toViewController as! HorizontalAnimatingController
    }
    var from: HorizontalAnimatingController {
        return fromViewController as! HorizontalAnimatingController
    }
}
