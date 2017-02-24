//
//  AnimatorsProvider.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Tools

open class AnimatorsProvider {

    open var isInteractive = false

    private let controllers: [AnimationController] = [
        HorizontalSlideAnimator(),
    ]
    private let interactionController = PercentDrivenInteractionController()

    public init() {
    }

    open func animationController(from fromVC: UIViewController, to toVC: UIViewController) -> AnimationController? {
        return controllers.filter { $0.isValid(from: fromVC, to: toVC) }.first
    }

    open func interactionController(for animationController: UIViewControllerAnimatedTransitioning) -> InteractionController? {
        guard isInteractive, let drivingController = animationController as? DrivingAnimationController else {
            return nil
        }
        interactionController.driver = drivingController.driver
        return interactionController
    }
}
