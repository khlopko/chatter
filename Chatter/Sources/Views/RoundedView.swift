//
//  RoundedView.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/7/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

private let floatPi = CGFloat(M_PI)

open class RoundedView: UIView {

    /// Set of corners to be drawn. For empty `init` call will be empty.
    public var corners: Corners {
        didSet { setNeedsDisplay() }
    }

    /// Corners radius. Default value is 5.
    public var radius: CGFloat = 5 {
        didSet { setNeedsDisplay() }
    }

    /// Path fill color. Default value is `white`.
    public var fillColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

    public convenience init(corners: Corners) {
        self.init(frame: .zero, corners: corners)
    }

    public init(frame: CGRect, corners: Corners = []) {
        self.corners = corners
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        var currentPoint = rect.origin
        var beginPoint = currentPoint
        if corners.contains(.topLeft) {
            let center = CGPoint(x: rect.minX + radius, y: rect.minY + radius)
            drawArc(at: path, center: center, angles: (floatPi, floatPi * 1.5))
            currentPoint.x += radius
            beginPoint.y += radius
        }
        currentPoint.x = rect.maxX - radius
        path.addLine(to: currentPoint)
        currentPoint.x += radius
        if corners.contains(.topRight) {
            let center = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
            drawArc(at: path, center: center, angles: (floatPi * 1.5, 0))
        } else {
            path.addLine(to: currentPoint)
        }
        currentPoint.y = rect.maxY - radius
        path.addLine(to: currentPoint)
        currentPoint.y += radius
        if corners.contains(.bottomRight) {
            let center = CGPoint(x: rect.maxX - radius, y: rect.maxY - radius)
            drawArc(at: path, center: center, angles: (0, floatPi * 0.5))
        } else {
            path.addLine(to: currentPoint)
        }
        currentPoint.x = rect.minX + radius
        path.addLine(to: currentPoint)
        currentPoint.x -= radius
        if corners.contains(.bottomLeft) {
            let center = CGPoint(x: rect.minX + radius, y: rect.maxY - radius)
            drawArc(at: path, center: center, angles: (floatPi * 0.5, floatPi))
        } else {
            path.addLine(to: currentPoint)
        }
        path.addLine(to: beginPoint)
        fillColor.setFill()
        path.fill()
    }

    private func drawArc(at path: UIBezierPath,
                         center: CGPoint,
                         angles: (start: CGFloat, end: CGFloat)) {
        path.addArc(
            withCenter: center, radius: radius,
            startAngle: angles.start, endAngle: angles.end,
            clockwise: true)
    }
}

// MARK: - Corners

public struct Corners: OptionSet, Hashable {

    public static let topLeft = Corners(rawValue: 4)
    public static let bottomLeft = Corners(rawValue: 3)
    public static let topRight = Corners(rawValue: 2)
    public static let bottomRight = Corners(rawValue: 1)

    public typealias RawValue = Int

    public var rawValue: RawValue

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public var hashValue: Int {
        return rawValue.hashValue
    }
}
