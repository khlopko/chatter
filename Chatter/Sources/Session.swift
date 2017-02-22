//
//  Session.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/30/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Entities
import API
import FirebaseAPI
import AsyncCore

final class Session {

    static let current = Session()

    var user: Entities.User?

    private var auth: API.Authorization?

    func login(credentials: Credentials) -> Wish<Void>? {
        auth = FirebaseAPI.Authorization(credentials: credentials)
        return auth?.login().next { [weak self] user in self?.user = user }
    }

    func signup(credentials: Credentials) -> Wish<Void>? {
        auth = FirebaseAPI.Authorization(credentials: credentials)
        return auth?.signup().next { [weak self] user in self?.user = user }
    }

    func logout() {
        auth?.logout()
    }
}
