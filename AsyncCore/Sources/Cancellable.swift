//
//  Cancellable.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public protocol Cancellable {
    var isCancelled: Bool { get }
    func cancel()
}
