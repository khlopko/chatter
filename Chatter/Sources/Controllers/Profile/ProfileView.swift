//
//  ProfileView.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

final class ProfileView: UIView {

    let pan = UIPanGestureRecognizer()
    let logoutButton = ProfileView.makeButton(title: "Logout")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let all: [UIView] = [logoutButton,]
        all.forEach(addSubview)
        addGestureRecognizer(pan)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        logoutButton.frame = CGRect(x: 0, y: bounds.height - 44, width: bounds.width, height: 44)
    }

    private static func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        return button
    }
}
