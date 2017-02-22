//
//  AppDelegate.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import FirebaseAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = ScreenRouter()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ErrorNotification.isAutohideEnabled = true
        ErrorNotification.showTimeInterval = 5
        FirebaseAPI.Initializer.do()
        router.createWindow(rootViewController: AuthorizationViewController())
        return true
    }
}

extension UIViewController {

    var router: ScreenRouter? {
        return (UIApplication.shared.delegate as? AppDelegate)?.router
    }
}
