//
//  TaskBuilder.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public protocol TaskBuilder {

    associatedtype In
    associatedtype Out
    associatedtype RequestType: Request

    var map: (In) -> (Out) { get }
    var request: RequestType { get }
}

extension TaskBuilder where RequestType.Value == In {

    public final var task: Task<In, Out, RequestType> {
        return Task(builder: self)
    }
}
