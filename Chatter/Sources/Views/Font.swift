//
//  Font.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/7/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public enum Font: String {

    case regular = "Lato-Regular"
    case italic = "Lato-Italic"
    case light = "Lato-Light"
    case bold = "Lato-Bold"
    case thin = "Lato-Thin"

    public func withSize(_ size: CGFloat) -> UIFont {
        let fontName = rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Don't exist font with name \(fontName)")
        }
        return font
    }
}
