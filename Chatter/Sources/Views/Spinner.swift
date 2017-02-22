//
//  Spinner.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/30/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

final class Spinner: UIView {

    private static let container = NotificationContainer(animation: .crossDissolve)

    static func show(color: UIColor? = nil) {
        let view = Spinner(frame: UIScreen.main.bounds)
        if let color = color {
            view.top.backgroundColor = color
        }
        view.startAnimation()
        container.show(with: view)
    }

    static func hide(after duration: TimeInterval = 0) {
        container.hide(after: duration)
    }

    private let bottom = Spinner.makeView(backgroundColor: UIColor.white.withAlphaComponent(0.85))
    private let top = Spinner.makeView(backgroundColor: .v21)

    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        bottom.clipsToBounds = true
        addSubview(bottom)
        bottom.addSubview(top)
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        let size = CGSize(width: 64, height: 64)
        bottom.frame.size = size
        bottom.center = center
        top.frame = CGRect(origin: CGPoint(x: -size.width, y: 0), size: size)
        top.layer.cornerRadius = size.width * 0.5
        bottom.layer.cornerRadius = size.width * 0.5
    }

    private func startAnimation() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [.autoreverse, .repeat, .curveEaseInOut],
            animations: { self.top.frame.origin.x += self.top.frame.width * 2 },
            completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeView(backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
}
