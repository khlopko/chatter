//
//  UITextField+Chain.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Tools

extension UITextField {

    public final class Chain {

        private var fields: [Weak<UITextField>] = []
        private var pointer = 0

        public var first: UITextField? {
            pointer = 0
            return next
        }

        public var next: UITextField? {
            if pointer == fields.count - 1 {
                return nil
            }
            pointer += 1
            let field = fields[pointer].value
            return field
        }

        public init() {
        }

        public func appendField(_ field: UITextField) {
            fields.append(Weak(field))
        }

        public func reset() {
            pointer = 0
        }
    }
}
