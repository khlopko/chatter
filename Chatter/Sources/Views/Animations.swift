//
//  Animations.swift
//  Chatter
//
//  Created on 2/22/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public final class Animations {

    /// Style of animation
    public enum Style {
        /// Spring animation with damping and velocity.
        ///
        /// Same as UIView func
        ///
        ///     class func animate(
        ///         withDuration duration: TimeInterval,
        ///         delay: TimeInterval,
        ///         usingSpringWithDamping dampingRatio: CGFloat,
        ///         initialSpringVelocity velocity: CGFloat,
        ///         options: UIViewAnimationOptions = [],
        ///         animations: @escaping () -> Void,
        ///         completion: ((Bool) -> Void)? = nil)
        case rubber
        /// Simple animation
        ///
        /// Same as UIView func
        ///
        ///     class func animate(
        ///         withDuration duration: TimeInterval,
        ///         delay: TimeInterval,
        ///         options: UIViewAnimationOptions = [],
        ///         animations: @escaping () -> Void,
        ///         completion: ((Bool) -> Void)? = nil)
        case simple
    }
    private let duration: TimeInterval
    private var delay: TimeInterval = 0.0
    private var options: UIViewAnimationOptions = .curveEaseInOut
    private var style: Style = .simple
    private var completion: ((Bool) -> ())? = nil
    private var damping: CGFloat = 0.5
    private var velocity: CGFloat = 1.0


    /// main initializer
    /// - Parameter duration: Default value = 0.5. TimeInterval value to set animation duration.
    public init(duration: TimeInterval = 0.5) {
        self.duration = duration
    }

    /// update delay
    /// - Parameter delay: Default value = 0.0.
    @discardableResult
    public func delay(_ delay: TimeInterval) -> Animations {
        self.delay = delay
        return self
    }

    /// update options
    /// - Parameter options: Default value = .curveEaseIn.
    @discardableResult
    public func options(_ options: UIViewAnimationOptions) -> Animations {
        self.options = options
        return self
    }

    /// update completion
    /// - Parameter completion: Default value = nil.
    @discardableResult
    public func completion(_ completion: @escaping (Bool) -> ()) -> Animations {
        self.completion = completion
        return self
    }

    /// update animation style
    /// - Parameter style: Default value = .simple.
    @discardableResult
    public func style(_ style: Style) -> Animations {
        self.style = style
        return self
    }

    /// update animation damping
    /// - Parameter damping: Default value = 0.5. Has effect only when Animations.Style == .rubber
    @discardableResult
    public func damping(_ damping: CGFloat) -> Animations {
        self.damping = damping
        return self
    }

    /// update animation velocity
    /// - Parameter velocity: Default value = 1.0. Has effect only when Animations.Style == .rubber
    @discardableResult
    public func velocity(_ velocity: CGFloat) -> Animations {
        self.velocity = velocity
        return self
    }

    /// start animations
    /// - Parameter animations: A closure containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy.
    public func run(_ animations: @escaping () -> ()) {
        switch style {
        case .rubber:
            UIView.animate(
                withDuration: duration,
                delay: delay,
                usingSpringWithDamping: damping,
                initialSpringVelocity: velocity,
                options: options,
                animations: animations,
                completion: completion)
        case .simple:
            UIView.animate(
                withDuration: duration, delay: delay, options: options,
                animations: animations, completion: completion)
        }
    }
    
}
