//
//  WebAPI.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/22/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import AsyncCore
import Entities

public final class WebAPI {

    public static var current: WebAPI!

    public let auth: Authorization
    public let calls: WebCalls
    public let initialization: Initialization

    public init(auth: Authorization, calls: WebCalls, initialization: Initialization) {
        self.auth = auth
        self.calls = calls
        self.initialization = initialization
    }
}
