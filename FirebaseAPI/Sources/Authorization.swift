//
//  Authorization.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import API
import Entities
import AsyncCore
import FirebaseAuth

final class Authorization: API.Authorization {

    var credentials: Credentials = .empty

    init() {
    }

    func login() -> Wish<Entities.User> {
        let credentials = self.credentials
        self.credentials = .empty
        return Wish { onNext, onFail in
            FIRAuth.auth()?.signIn(withEmail: credentials.email, password: credentials.password) { user, error in
                if let user = user {
                    onNext(User(user))
                } else {
                    let errorValue = error ?? NSError(domain: "", code: 0, userInfo: [:])
                    onFail(errorValue)
                }
            }
        }
    }

    func signup() -> Wish<Entities.User> {
        let credentials = self.credentials
        self.credentials = .empty
        return Wish { onNext, onFail in
            FIRAuth.auth()?.createUser(withEmail: credentials.email, password: credentials.password) { user, error in
                if let user = user {
                    onNext(User(user))
                } else {
                    let errorValue = error ?? NSError(domain: "", code: 0, userInfo: [:])
                    onFail(errorValue)
                }
            }
        }
    }

    func logout() {
        try? FIRAuth.auth()?.signOut()
    }
}
