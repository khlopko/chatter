//
//  PanInteractionDriver.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/24/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

final class PanInteractionDriver: InteractionDriver {

    typealias Controller = AnimatableTransitioningController & PanTransitioningController
    weak var viewController: Controller? {
        didSet {
            viewController?.pan?.addTarget(self, action: #selector(handle(pan:)))
        }
    }
    weak var interactionController: InteractionController?

    let direction: Direction

    init(direction: Direction) {
        self.direction = direction
    }

    @objc
    func handle(pan: UIPanGestureRecognizer) {
        guard let interactionController = interactionController else {
            return
        }
        switch pan.state {
        case .changed:
            let k = calculatePercents(pan: pan)
            interactionController.update(k)
        case .ended:
            let k = calculatePercents(pan: pan)
            if k >= 0.5 {
                interactionController.finish()
            } else {
                interactionController.cancel()
            }
            onComplete()
        default:
            interactionController.cancel()
            onComplete()
        }
    }

    private func calculatePercents(pan: UIPanGestureRecognizer) -> CGFloat {
        guard let viewController = viewController else {
            return 0
        }
        let translation = viewController.pan?.translation(in: viewController.mainView) ?? .zero
        switch direction {
        case .horizontal:
            return fabs(translation.x / viewController.mainView.bounds.width)
        case .vertical:
            return fabs(translation.y / viewController.mainView.bounds.height)
        }
    }

    private func onComplete() {
        viewController?.pan?.removeTarget(self, action: #selector(handle(pan:)))
    }
}

// MARK: - Direction

extension PanInteractionDriver {

    enum Direction {
        case vertical
        case horizontal
    }
}
