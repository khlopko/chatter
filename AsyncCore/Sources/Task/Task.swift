//
//  Task.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public final class Task<In, Out, RequestType: Request>: Cancellable where RequestType.Value == In {

    public typealias Value = RequestType.Value

    public typealias Completion = (Result<Out>) -> ()

    public var isCancelled: Bool {
        return request?.isCancelled ?? false
    }

    private var request: RequestType?
    private let map: (In) -> (Out)
    private var completion: Completion?
    private var _selfRef: Task<In, Out, RequestType>?

    init<B: TaskBuilder>(builder: B) where B.In == In, B.Out == Out, B.RequestType == RequestType {
        request = builder.request
        map = builder.map
        _selfRef = self
    }

    public func execute(_ completion: @escaping Completion) {
        self.completion = completion
        request?.execute { [weak self] result in
            switch result {
            case let .success(value):
                self?.handleSuccess(input: value)
            case let .failure(error):
                self?.handleFailure(error: error)
            }
        }
    }

    public func cancel() {
        request?.cancel()
    }

    private func handleSuccess(input: In) {
        completion?(.success(map(input)))
        finishRequest()
    }

    private func handleFailure(error: Error) {
        completion?(.failure(error))
        finishRequest()
    }

    private func finishRequest() {
        request = nil
        completion = nil
        _selfRef = nil
    }
}
