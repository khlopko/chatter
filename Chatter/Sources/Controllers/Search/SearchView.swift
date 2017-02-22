//
//  SearchView.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

final class SearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let all: [UIView] = []
        all.forEach(addSubview)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
