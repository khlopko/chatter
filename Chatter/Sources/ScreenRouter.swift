//
//  ScreenRouter.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/30/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

final class ScreenRouter {

    private var window: UIWindow?

    func createWindow(rootViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    func changeRootViewController(to rootViewController: UIViewController, animated: Bool) {
        guard let window = window else {
            return
        }
        UIView.transition(
            with: window,
            duration: 0.3,
            options: [.curveLinear, .transitionCrossDissolve],
            animations: { [unowned self] in
                window.rootViewController = rootViewController
            },
            completion: nil)
    }
}
