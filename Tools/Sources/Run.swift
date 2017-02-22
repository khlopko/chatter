//
//  Run.swift
//  SwiftyTwitter
//
//  Created by Kirill Khlopko on 11/10/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public struct Run {
	
	public static func after(_ delay: Double, closure: @escaping () -> ()) {
		DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
	}

    public static func async(in queue: DispatchQueue = .main, _ closure: @escaping () -> ()) {
        queue.async(execute: closure)
    }

    public static func sync(in queue: DispatchQueue = .main, _ closure: @escaping () -> ()) {
        if Thread.isMainThread {
            closure()
        } else {
            queue.sync(execute: closure)
        }
    }
	
	private init() {
	}
}
