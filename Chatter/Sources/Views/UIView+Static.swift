//
//  UIView+Static.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/22/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public protocol StaticProtocol: class {
    associatedtype Static: UIView = Self
}

public extension StaticProtocol {
    typealias Static = Self
}

extension UIView: StaticProtocol {
}
