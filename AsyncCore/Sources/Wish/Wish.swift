//
//  Wish.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

open class Wish<Value> {

    open var isCompleted: Bool {
        return holder.isFilled
    }

    public typealias Action = (_ onNext: @escaping Next, _ onFail: @escaping Fail) throws -> ()
    public typealias Completion = () -> ()
    public typealias Next = (Value) -> ()
    public typealias Fail = (Swift.Error) -> ()

    let runManually: Bool

    private let action: Action!
    private let holder = ResultHolder<Value>()

    public init(_ action: Action) {
        runManually = false
        self.action = nil
        run(action)
    }

    public init(runManually: Bool, _ action: @escaping Action) {
        self.runManually = runManually
        if runManually {
            self.action = action
        } else {
            self.action = nil
            run(action)
        }
    }

    public func run() {
        if runManually {
            run(action)
        }
    }

    @discardableResult
    public func completion(_ closure: @escaping Completion) -> Self {
        holder.completion(closure)
        return self
    }

    @discardableResult
    public func next<N>(_ closure: @escaping (Value) -> (N)) -> Wish<N> {
        return Wish<N> { onNext, onFail in
            holder.next { value in
                onNext(closure(value))
            }
            holder.fail { error in
                onFail(error)
            }
        }
    }

    @discardableResult
    public func fail(_ closure: @escaping Fail) -> Self {
        holder.fail(closure)
        return self
    }

    // MARK: - Private

    private func run(_ action: Action) {
        do {
            try action(
                { [weak self] value in
                    self?.holder.fill(with: value)
                },
                { [weak self] error in
                    self?.holder.fill(with: error)
            })
        } catch {
            holder.fill(with: error)
        }
    }
}
