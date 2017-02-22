//
//  User.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/30/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Entities
import FirebaseAuth

public struct User: Entities.User {

    public let id: ID
    public let username: String
    public var email: String
    public var firstname: String
    public var lastname: String

    init(_ user: FIRUser) {
        id = user.uid
        username = ""
        email = user.email ?? ""
        firstname = user.displayName ?? ""
        lastname = ""
    }
}
