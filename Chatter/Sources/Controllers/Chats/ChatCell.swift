//
//  ChatCell.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/30/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

private struct Constant {
    static let inset: CGFloat = 10
}

final class ChatCell: UITableViewCell {

    let photoView = ChatCell.makePhotoView()
    let titleLabel = ChatCell.makeLabel(font: UIFont.systemFont(ofSize: 16), textColor: .black)
    let lastMessageLabel = ChatCell.makeLabel(font: UIFont.systemFont(ofSize: 14), textColor: .darkGray)
    let dateLabel = ChatCell.makeLabel(font: UIFont.systemFont(ofSize: 14), textColor: .darkGray)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let all: [UIView] = [photoView, titleLabel, lastMessageLabel, dateLabel,]
        all.forEach(contentView.addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutPhotoView()
        layoutDateLabel()
        layoutTitleLabel()
        layoutLastMessageLabel()
    }

    func update() {
        titleLabel.text = "Some chat"
        lastMessageLabel.text = "Here is last message"
        dateLabel.text = "Today"
        photoView.backgroundColor = .lightGray
        setNeedsLayout()
    }

    private func layoutPhotoView() {
        let side: CGFloat = bounds.height - Constant.inset * 2
        photoView.frame = CGRect(x: Constant.inset, y: Constant.inset, width: side, height: side)
        photoView.layer.cornerRadius = side * 0.5
    }

    private func layoutDateLabel() {
        let text = dateLabel.text ?? ""
        let width = text.width(font: dateLabel.font)
        let height = ceil(dateLabel.font.lineHeight)
        dateLabel.frame = CGRect(
            x: bounds.width - width - Constant.inset, y: photoView.center.y - height - Constant.inset * 0.25,
            width: width, height: height)
    }

    private func layoutTitleLabel() {
        let height = ceil(titleLabel.font.lineHeight)
        let x = photoView.frame.maxX + Constant.inset
        titleLabel.frame = CGRect(
            x: x, y: dateLabel.frame.minY,
            width: dateLabel.frame.minX - x, height: height)
    }

    private func layoutLastMessageLabel() {
        let height = ceil(lastMessageLabel.font.lineHeight)
        lastMessageLabel.frame = CGRect(
            x: titleLabel.frame.minX, y: photoView.center.y + Constant.inset * 0.25,
            width: titleLabel.frame.width, height: height)
    }

    private static func makePhotoView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .center
        return view
    }

    private static func makeLabel(font: UIFont,
                                  textColor: UIColor,
                                  alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
}
