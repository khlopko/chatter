//
//  DefaultControllerProtocols.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/25/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public protocol AnimatableTransitioningController: class {
    var mainView: UIView { get }
}

public protocol PanTransitioningController: class {
    var pan: UIPanGestureRecognizer? { get }
}
