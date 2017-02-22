//
//  ImageDrawer.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/7/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public final class ImageDrawer {

    private init() {
    }

    public static func makeRect(fillColor: UIColor, size: CGSize,
                                corners: Corners = [], radius: CGFloat = 0) -> UIImage {
        let view = RoundedView(corners: corners)
        view.frame.size = size
        view.radius = radius
        view.fillColor = fillColor
        UIGraphicsBeginImageContext(size)
        view.layer.draw(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
