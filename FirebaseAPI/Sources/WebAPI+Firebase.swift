//
//  WebAPI+Firebase.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import API

public extension WebAPI {

    static func makeFirebaseAPI() -> WebAPI {
        return WebAPI(
            auth: FirebaseAPI.Authorization(),
            calls: FirebaseCalls(),
            initialization: FirebaseAPI.Initialization())
    }
}
