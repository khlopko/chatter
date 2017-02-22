//
//  String+sizes.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/10/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

extension String {

    func widthWith(font: UIFont) -> CGFloat {
        let string = NSString(string: self)
        let width = string.size(attributes: [NSFontAttributeName: font]).width
        return width
    }

    func heightFor(width: CGFloat, font: UIFont) -> CGFloat {
        let inputSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let outputSize = self.boundingRect(
            with: inputSize, options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSFontAttributeName: font], context: nil)
        return outputSize.height
    }
}
