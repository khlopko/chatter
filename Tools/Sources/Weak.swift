//
//  Weak.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/9/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public final class Weak<T: AnyObject> {

    public weak var value: T?

    public init(_ value: T) {
        self.value = value
    }
}
