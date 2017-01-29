//
//  Result.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public enum Result<Value> {

    case success(Value)
    case failure(Error)

    public var isSucceed: Bool {
        return value != nil
    }
    public var isFailed: Bool {
        return error != nil
    }
    public var value: Value? {
        switch self {
        case let .success(value):
            return value
        case .failure(_):
            return nil
        }
    }
    public var error: Error? {
        switch self {
        case .success(_):
            return nil
        case let .failure(error):
            return error
        }
    }
}
