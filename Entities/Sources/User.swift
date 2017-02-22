//
//  User.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public protocol User: Entity {
    
    var id: ID { get }
    var username: String { get }
    var email: String { get }
    var firstname: String { get }
    var lastname: String { get }
}

extension User {

    public var displayName: String {
        if !fullname.trimmingCharacters(in: .whitespaces).isEmpty {
            return fullname
        }
        if !username.isEmpty {
            return username
        }
        if !email.isEmpty {
            return email
        }
        return id
    }
    public var fullname: String {
        return "\(firstname) \(lastname)"
    }
}
