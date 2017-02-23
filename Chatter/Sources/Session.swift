//
//  Session.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/30/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Entities
import API
import AsyncCore

final class Session {

    static let current = Session()

    var user: Entities.User?

    private var auth: API.Authorization {
        return WebAPI.current.auth
    }

    func login(credentials: Credentials) -> Wish<Void>? {
        auth.credentials = credentials
        return auth.login().next { [weak self] user in self?.user = user }
    }

    func signup(credentials: Credentials) -> Wish<Void>? {
        auth.credentials = credentials
        return auth.signup().next { [weak self] user in self?.user = user }
    }

    func logout() {
        auth.logout()
    }
}
