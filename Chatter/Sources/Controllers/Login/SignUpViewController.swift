//
//  SignUpViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Entities
import FirebaseAPI

final class SignUpViewController: ViewController<AuthorizationView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.title = "sign up".uppercased()
        contentView.mainButtonTitle = "continue".uppercased()
        contentView.isSecondaryButtonHidden = true
        contentView.addMainAction(#selector(handle(signUp:)), target: self)
    }

    func handle(signUp: UIButton) {
        let credentials = Credentials(email: contentView.email, password: contentView.password)
        contentView.isProcessing = true
        Session.current.signup(credentials: credentials)?
            .completion { [weak self] in
                self?.contentView.isProcessing = false
            }
            .value { [weak self] in
                self?.router?.changeRootViewController(to: TabBarController(), animated: true)
            }
            .fail { error in
                ErrorNotification.show(with: error)
            }
    }
}
