//
//  Authorization.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Entities
import AsyncCore

public protocol Authorization {
    func login() -> Wish<User>
    func signup() -> Wish<User>
    func logout()
}
