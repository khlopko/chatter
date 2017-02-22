//
//  AuthrizationContainerView.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/22/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class AuthorizationContainerView: UIView {

    let scrollView = Static.makeScrollView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
    }

    private static func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }
}
