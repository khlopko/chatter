//
//  Request.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public protocol Request: class, Cancellable {
    associatedtype Value
    func execute(_ completion: @escaping (Result<Value>) -> ())
}
