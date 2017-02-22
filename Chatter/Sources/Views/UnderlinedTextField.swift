//
//  UnderlinedTextField.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/9/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

open class UnderlinedTextField: UITextField {

    private let line = UIView()

    public final var lineColor: UIColor = .clear {
        didSet { line.backgroundColor = lineColor }
    }
    public final var lineHeight: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(line)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        line.frame = CGRect(x: 0, y: bounds.height - lineHeight, width: bounds.width, height: lineHeight)
    }
}
