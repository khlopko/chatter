//
//  Animator.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

protocol Animator {
    weak var context: UIViewControllerContextTransitioning? { get }
}

extension Animator {

    var containerView: UIView {
        guard let containerView = context?.containerView else {
            fatalError("Illegal state: containerView is nil!")
        }
        return containerView
    }
    var fromViewController: UIViewController {
        guard let viewController = context?.viewController(forKey: .from) else {
            fatalError("Illegal state: fromViewController is nil!")
        }
        return viewController
    }
    var toViewController: UIViewController {
        guard let viewController = context?.viewController(forKey: .to) else {
            fatalError("Illegal state: toViewController is nil!")
        }
        return viewController
    }
    var fromView: UIView! {
        return context?.view(forKey: .from)
    }
    var toView: UIView! {
        return context?.view(forKey: .to)
    }
    var toInitialFrame: CGRect {
        return context?.initialFrame(for: toViewController) ?? .zero
    }
    var fromInitialFrame: CGRect {
        return context?.initialFrame(for: fromViewController) ?? .zero
    }
    var toFinalFrame: CGRect {
        return context?.finalFrame(for: toViewController) ?? .zero
    }
    var fromFinalFrame: CGRect {
        return context?.finalFrame(for: fromViewController) ?? .zero
    }
}
