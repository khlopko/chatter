//
//  ChatsView.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

final class ChatsView: UIView {

    let table = ChatsView.makeTable()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let all: [UIView] = [table,]
        all.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        table.frame = bounds
    }

    private static func makeTable() -> UITableView {
        let table = UITableView()
        return table
    }
}
