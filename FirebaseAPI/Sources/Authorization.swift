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

public final class Authorization: API.Authorization {

    private let credentials: Credentials

    public init(credentials: Credentials) {
        self.credentials = credentials
    }

    public func login() -> Wish<Entities.User> {
        return Wish { onNext, onFail in
            FIRAuth.auth()?.signIn(withEmail: credentials.email, password: credentials.password) { user, error in
                if let user = user {
                    onNext(FirebaseAPI.User(user))
                } else {
                    let errorValue = error ?? NSError(domain: "", code: 0, userInfo: [:])
                    onFail(errorValue)
                }
            }
        }
    }

    public func logout() {
        try? FIRAuth.auth()?.signOut()
    }

    public func signup() -> Wish<Entities.User> {
        return Wish { onNext, onFail in
            FIRAuth.auth()?.createUser(withEmail: credentials.email, password: credentials.password) { user, error in
                if let user = user {
                    onNext(FirebaseAPI.User(user))
                } else {
                    let errorValue = error ?? NSError(domain: "", code: 0, userInfo: [:])
                    onFail(errorValue)
                }
            }
        }
    }
}
