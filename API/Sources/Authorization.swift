//
//  Authorization.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Entities
import AsyncCore

public protocol Authorization: class {

    var credentials: Credentials { get set }

    func login() -> Wish<User>
    func signup() -> Wish<User>
    func logout()
}
