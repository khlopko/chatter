//
//  ViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class ViewController<View: UIView>: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    final var contentView: View {
        guard let contentView = view as? View else {
            fatalError("Screen initialized with from view class!")
        }
        return contentView
    }

    final override func loadView() {
        view = View()
    }
}
