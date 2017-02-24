//
//  ProfileViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import FirebaseAPI
import Transitions

final class ProfileViewController: ViewController<ProfileView> {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        contentView.logoutButton.addTarget(self, action: #selector(handle(logout:)), for: .touchUpInside)
        contentView.pan.addTarget(self, action: #selector(handle(pan:)))
        (navigationController as? TabNavigationController)?.horizontalController = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customTabBar?.isInteractiveTransition = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        customTabBar?.isInteractiveTransition = false
    }

    func handle(logout: UIButton) {
        Session.current.logout()
        router?.changeRootViewController(to: AuthorizationViewController(), animated: true)
    }

    func handle(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            let translation = pan.translation(in: view)
            if fabs(translation.x) > fabs(translation.y) && translation.x >= 0 {
                customTabBar?.isInteractiveTransition = true
                tabBarController?.selectedIndex -= 1
            }
        default:
            break
        }
    }
}

// MARK: - HorizontalAnimatingController

extension ProfileViewController: HorizontalAnimatingController {

    var mainView: UIView {
        return view
    }
    var pan: UIPanGestureRecognizer? {
        return contentView.pan
    }
}
