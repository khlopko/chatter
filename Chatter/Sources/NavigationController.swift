//
//  NavigationController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Tools
import Transitions

class NavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [rootViewController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

class TabNavigationController: NavigationController, HorizontalAnimatingController {

    weak var horizontalController: HorizontalAnimatingController?

    var mainView: UIView {
        return view
    }
    var pan: UIPanGestureRecognizer? {
        return horizontalController?.pan
    }
}
