//
//  UINavigationBar+Configuration.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/9/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public extension UINavigationBar {

    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        setBackgroundImage(UIImage(), for: .default)
        barTintColor = color
        return self
    }

    @discardableResult
    func removeShadow() -> Self {
        shadowImage = UIImage()
        return self
    }

    @discardableResult
    func attributeTitle(font: UIFont, textColor: UIColor) -> Self {
        if titleTextAttributes == nil {
            titleTextAttributes = [:]
        }
        titleTextAttributes?[NSFontAttributeName] = font
        titleTextAttributes?[NSForegroundColorAttributeName] = textColor
        return self
    }
}
