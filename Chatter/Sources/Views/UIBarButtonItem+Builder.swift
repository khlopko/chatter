//
//  UIBarButtonItem+Builder.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/9/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

public extension UINavigationItem {

    var builder: Builder {
        return Builder(self)
    }

    public class Builder {

        public enum Position {
            case left
            case right
        }

        private struct Item {
            let title: String?
            let image: UIImage?
            weak var target: AnyObject?
            let action: Selector
        }

        private unowned var parent: UINavigationItem
        private var rightItem: Item?
        private var leftItem: Item?
        private var textColor: UIColor = .v28
        private var textSize: CGFloat = 14

        fileprivate init(_ parent: UINavigationItem) {
            self.parent = parent
        }

        public func textColor(_ textColor: UIColor) -> Self {
            self.textColor = textColor
            return self
        }

        public func textSize(_ textSize: CGFloat) -> Self {
            self.textSize = textSize
            return self
        }

        public func rightItem(title: String, target: AnyObject?, action: Selector) -> Self {
            rightItem = Item(title: title, image: nil, target: target, action: action)
            return self
        }

        public func leftItem(title: String, target: AnyObject?, action: Selector) -> Self {
            leftItem = Item(title: title, image: nil, target: target, action: action)
            return self
        }

        public func rightItem(image: UIImage?, target: AnyObject?, action: Selector) -> Self {
            rightItem = Item(title: nil, image: image, target: target, action: action)
            return self
        }

        public func leftItem(image: UIImage?, target: AnyObject?, action: Selector) -> Self {
            leftItem = Item(title: nil, image: image, target: target, action: action)
            return self
        }

        public func apply() {
            parent.leftBarButtonItem = makeBarButton(position: .left, item: leftItem)
            parent.rightBarButtonItem = makeBarButton(position: .right, item: rightItem)
        }

        private func makeBarButton(position: Position, item: Item?) -> UIBarButtonItem? {
            guard let item = item else {
                return nil
            }
            let button = UIButton()
            button.addTarget(item.target, action: item.action, for: .touchUpInside)
            let font = Font.regular.withSize(textSize)
            let width: CGFloat
            if let title = item.title {
                button.setTitle(item.title, for: .normal)
                button.setTitleColor(textColor, for: .normal)
                width = ceil(title.widthWith(font: font))
            } else {
                width = 44
            }
            button.setImage(item.image, for: .normal)
            button.titleLabel?.font = font
            button.frame = CGRect(x: 0, y: 0, width: width, height: 44)
            switch position {
            case .left:
                button.contentHorizontalAlignment = .left
            case .right:
                button.contentHorizontalAlignment = .right
            }
            return UIBarButtonItem(customView: button)
        }
    }
}
