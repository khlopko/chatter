//
//  Message.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public protocol Message: Entity {

    var id: ID { get }
    var senderID: ID { get }
    var chatID: ID { get }
    var text: String? { get }
}
