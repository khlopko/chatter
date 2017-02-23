//
//  Chat.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Foundation

public protocol Chat: Entity {

    var id: ID { get }
    var title: String { get }
    var ownerID: ID { get }
    var isRead: Bool { get }
    var lastMessage: Message { get }
}
