//
//  KeyboardListener.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/9/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

// MARK: KeyboardListenerDelegate

@objc public protocol KeyboardListenerDelegate: class {
    @objc optional func keyboardListener(_ listener: KeyboardListener, animateWithDuration duration: TimeInterval)
    @objc optional func keyboardListener(_ listener: KeyboardListener, willAnimateWithDuration duration: TimeInterval)
}

// MARK: - KeyboardListener

public final class KeyboardListener: NSObject {

    public static let shared = KeyboardListener()

    private var onceTimeObservers: [OnceTimeObserver: [() -> ()]] = [:]

    public var diff: CGFloat {
        return bottomInset - previousInset
    }
    private(set) public var status: Status = .hidden {
        didSet {
            if oldValue != status {
                let hiddenOrShown = status == .hidden || status == .shown
                if hiddenOrShown {
                    callObservers(forType: .didChangeVisibleState)
                }
            }
        }
    }
    public var animationInProgress: Bool {
        let inProgress = status == .willHide || status == .willShow
        return inProgress
    }
    private(set) public var previousInset: CGFloat = 0
    private(set) public var bottomInset: CGFloat = 0 {
        willSet { previousInset = bottomInset }
    }
    private var currentDuration: TimeInterval = 0
    private var delegates: [Weak<KeyboardListenerDelegate>] = []
    private var previousEndFrame: CGRect = .zero

    private override init() {
        super.init()
        let notifications: [(Selector, NSNotification.Name)] = [
            (#selector(willChangeFrame), .UIKeyboardWillChangeFrame),
            (#selector(didHide), .UIKeyboardDidHide),
            (#selector(didShow), .UIKeyboardDidShow),
            (#selector(willHide), .UIKeyboardWillHide),
            (#selector(willShow), .UIKeyboardWillShow),
        ]
        for (selector, name) in notifications {
            NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Interface

    public func addDelegate(_ delegate: KeyboardListenerDelegate) {
        delegates = delegates.filter { $0.value != nil }
        if (delegates.filter{ $0.value === delegate }.isEmpty) {
            delegates.append(Weak(delegate))
        }
    }

    public func removeDelegate(_ delegate: KeyboardListenerDelegate) {
        delegates = delegates.filter { $0.value !== delegate }
    }

    public func addOnceObserver(_ observer: OnceTimeObserver, closure: @escaping () -> ()) {
        var observers = onceTimeObservers[observer] ?? []
        observers.append(closure)
        onceTimeObservers[observer] = observers
    }

    // MARK: - Handlers

    func willChangeFrame(_ sender: Notification) {
        guard
            let info = sender.userInfo,
            let beginFrame = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let endFrame = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        if endFrame == previousEndFrame || UIApplication.shared.applicationState != .active {
            return
        }
        previousEndFrame = endFrame
        currentDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let yDiff = endFrame.minY - beginFrame.minY
        bottomInset = UIScreen.main.bounds.height - endFrame.minY
        if yDiff != 0 || bottomInset != previousInset {
            keyboardNotificationWillAnimate()
            UIView.animate(withDuration: currentDuration, animations: keyboardNotificationAnimate)
        }
    }

    func didHide(_ sender: Notification) {
        if UIApplication.shared.applicationState != .active {
            return
        }
        status = .hidden
        if bottomInset != 0 {
            currentDuration = 0
            bottomInset = 0
            keyboardNotificationWillAnimate()
            keyboardNotificationAnimate()
        }
    }

    func didShow(_ sender: Notification) {
        status = .shown
    }

    func willHide(_ sender: Notification) {
        status = .willHide
    }

    func willShow(_ sender: Notification) {
        status = .willShow
    }

    // MARK: - Private

    private func keyboardNotificationWillAnimate() {
        delegates.forEach {
            $0.value?.keyboardListener?(self, willAnimateWithDuration: self.currentDuration)
        }
    }

    private func keyboardNotificationAnimate() {
        delegates.forEach {
            $0.value?.keyboardListener?(self, animateWithDuration: self.currentDuration)
        }
    }

    private func callObservers(forType type: OnceTimeObserver) {
        let observers = onceTimeObservers.removeValue(forKey: type)
        observers?.forEach { $0() }
    }
}

// MARK: - OnceTimeObserver, Status

public extension KeyboardListener {

    enum OnceTimeObserver {
        case didChangeVisibleState
    }

    enum Status {
        case hidden
        case willHide
        case shown
        case willShow
    }
    
}
