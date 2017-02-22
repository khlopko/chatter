//
//  ProfileViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import FirebaseAPI

final class ProfileViewController: ViewController<ProfileView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.logoutButton.addTarget(self, action: #selector(handle(logout:)), for: .touchUpInside)
    }

    func handle(logout: UIButton) {
        Session.current.logout()
        dismiss(animated: false)
        router?.changeRootViewController(to: AuthorizationViewController(), animated: true)
    }
}
