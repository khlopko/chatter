//
//  LoginViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Entities
import Tools

final class LoginViewController: ViewController<AuthorizationView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.title = "login".uppercased()
        contentView.mainButtonTitle = "enter".uppercased()
        contentView.secondaryButtonTitle = "Forgot Password"
        contentView.addMainAction(#selector(handle(login:)), target: self)
        contentView.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.becomeFirstResponder()
    }

    func handle(login: UIButton) {
        let credentials = Credentials(email: contentView.email, password: contentView.password)
        contentView.isProcessing = true
        Session.current.login(credentials: credentials)?
            .completion { [weak self] in
                self?.contentView.isProcessing = false
            }
            .value { [weak self] in
                self?.view.endEditing(true)
                self?.router?.changeRootViewController(to: TabBarController(), animated: true)
            }
            .fail { error in
                ErrorNotification.show(with: error)
            }
    }
}
