//
//  ResultHolder.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

class ResultHolder<Value> {

    private let holderQ = DispatchQueue(label: "l.resultholder.exec.queue", attributes: .concurrent)

    typealias Next = Wish<Value>.Next
    typealias Fail = Wish<Value>.Fail
    typealias Completion = Wish<Value>.Completion

    private var next: [Next] = []
    private var fail: [Fail] = []
    private var completion: [Completion] = []

    private(set) var result: Result<Value>! {
        didSet {
            holderQ.sync(flags: .barrier, execute: onFill)
        }
    }

    var isFilled: Bool {
        return result != nil
    }

    func next(_ closure: @escaping Next) {
        if let result = result, case let .success(value) = result {
            closure(value)
        } else {
            holderQ.sync { self.next.append(closure) }
        }
    }

    func fail(_ closure: @escaping Fail) {
        if let result = result, case let .failure(error) = result {
            closure(error)
        } else {
            holderQ.sync { self.fail.append(closure) }
        }
    }

    func completion(_ closure: @escaping Completion) {
        if isFilled {
            closure()
        } else {
            holderQ.sync { self.completion.append(closure) }
        }
    }

    func fill(with value: Value) {
        result = .success(value)
    }

    func fill(with error: Error) {
        result = .failure(error)
    }

    // MARK: - Private

    private func onFill() {
        guard let result = result else {
            return
        }
        switch result {
        case let .success(value):
            next.forEach { $0(value) }
        case let .failure(error):
            fail.forEach { $0(error) }
        }
        for handler in completion {
            handler()
        }
    }
}
