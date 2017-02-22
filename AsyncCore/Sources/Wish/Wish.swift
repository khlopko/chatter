//
//  Wish.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Tools

private var wishCounter = 0

open class Wish<Value> {

    open var isCompleted: Bool {
        return holder.isFilled
    }

    public typealias Action = (_ onNext: @escaping Next, _ onFail: @escaping Fail) throws -> ()
    public typealias Completion = () -> ()
    public typealias Next = (Value) -> ()
    public typealias Fail = (Swift.Error) -> ()

    private let holder = ResultHolder<Value>()
    private var _selfRef: Wish<Value>?

    public init(_ action: Action) {
#if WISHES
        wishCounter += 1
#endif
        _selfRef = self
        run(action)
    }

    deinit {
#if WISHES
        wishCounter -= 1
        log.d("Total wishes:", wishCounter)
#endif
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
    public func value(_ closure: @escaping (Value) -> ()) -> Self {
        holder.next(closure)
        return self
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
                    self?._selfRef = nil
                },
                { [weak self] error in
                    print("Error:", error)
                    self?.holder.fill(with: error)
                    self?._selfRef = nil
            })
        } catch {
            holder.fill(with: error)
            _selfRef = nil
        }
    }
}

extension Wish {

    public static func wrap(_ closure: ((@escaping (Value, Swift.Error?) -> ())) -> ()) -> Wish<Value> {
        return Wish { onNext, onFail in
            closure { value, error in
                if let error = error {
                    onFail(error)
                } else {
                    onNext(value)
                }
            }
        }
    }
}
