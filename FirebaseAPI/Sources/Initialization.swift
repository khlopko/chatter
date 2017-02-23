//
//  Initialization.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import API
import Firebase

final class Initialization: API.Initialization {

    public func initialize() {
        FIRApp.configure()
    }
}
