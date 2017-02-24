//
//  AnimationController.swift
//  GoChat
//
//  Created on 2/24/17.
//  Copyright © 2017 GoChatz Inc. All rights reserved.
//

import UIKit

public protocol AnimationController: UIViewControllerAnimatedTransitioning {
    func isValid(from fromVC: UIViewController, to toVC: UIViewController) -> Bool
}

public protocol DrivingAnimationController: AnimationController {
    var driver: InteractionDriver { get }
}
