//
//  NotificationContainer.swift
//
//  Created by Kirill Khlopko on 9/20/16.
//  Copyright © 2016 GoChat Inc. All rights reserved.
//

import UIKit
import Tools

public final class NotificationContainer {
	
	private var parentWindow: NotificationWindow?
	private var notificationView: UIView?
	private var windowLevel = UIWindowLevelStatusBar + 1

    private typealias Closure<T> = (T) -> ()
    private var animationClosure: Closure<Void>!
    private var prepareClosure: Closure<UIView>!

    enum Animation {
        case slide
        case crossDissolve
    }

    init(animation: Animation) {
        switch animation {
        case .slide:
            animationClosure = slide
            prepareClosure = prepareToSlide
        case .crossDissolve:
            animationClosure = crossDissolve
            prepareClosure = prepareToCrossDissolve
        }
	}
	
	public func show(with notificationView: UIView) {
		add(view: notificationView)
	}
	
	public func hide(after duration: Double = 0) {
		guard let currentView = notificationView else {
			return
		}
		Run.after(duration) {
			if !(self.notificationView === currentView) {
				return
			}
			self.hideAnimation {
				self.parentWindow?.resignKey()
				self.parentWindow = nil
				self.notificationView = nil
			}
		}
	}
	
	private func add(view notificationView: UIView) {
		if self.notificationView != nil {
			return
		}
		self.notificationView = notificationView
		let parentWindow = createWindow()
		parentWindow.isHidden = false
		parentWindow.addSubview(notificationView)
		parentWindow.isUserInteractionEnabled = true
		self.parentWindow = parentWindow
		show()
	}
	
	private func createWindow() -> NotificationWindow {
		let frame = CGRect(
			x: 0, y: 0,
			width: notificationView?.frame.width ?? 0, height: notificationView?.frame.maxY ?? 0)
		let window = NotificationWindow(frame: frame)
        prepareClosure(window)
		window.windowLevel = windowLevel
		return window
	}
	
	private func show() {
		UIView.animate(withDuration: 0.3, animations: animationClosure)
	}
	
	private func hideAnimation(completion: @escaping () -> ()) {
		UIView.animate(
			withDuration: 0.3,
			animations: animationClosure,
			completion: { _ in completion() })
	}

    private func slide() {
        let currentY = parentWindow?.frame.origin.y ?? 0
        if currentY < 0 {
            parentWindow?.frame.origin.y = 0
        } else {
            parentWindow?.frame.origin.y = -(notificationView?.frame.height ?? 0)
        }
    }

    private func crossDissolve() {
        let currentAlpha = parentWindow?.alpha ?? 0
        parentWindow?.alpha = 1 - currentAlpha
    }

    private func prepareToSlide(_ view: UIView) {
        view.frame.origin.y -= notificationView?.frame.height ?? 0
    }

    private func prepareToCrossDissolve(_ view: UIView) {
        view.alpha = 0
    }
}

// MARK: - NotificationWindow

public final class NotificationWindow: UIWindow {
	
	public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let view = super.hitTest(point, with: event)
		if subviews.count != 1 {
			return view
		}
		let resultView = subviews.first?.frame.contains(point) == true ? view : nil
		return resultView
	}
}
