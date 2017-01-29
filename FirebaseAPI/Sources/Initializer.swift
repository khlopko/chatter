//
//  Initializer.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Firebase

public final class Initializer {

    public static func `do`() {
        FIRApp.configure()
    }
}
