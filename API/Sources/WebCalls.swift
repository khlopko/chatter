//
//  WebCalls.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Entities
import AsyncCore

public protocol WebCalls: class {

    func createChat(with user: User) -> Wish<Chat>
    func createChat(with users: [User]) -> Wish<Chat>
    func createChat(title: String) -> Wish<Chat>
    func deleteChat(_ chat: Chat) -> Wish<Void>
    func markAsRead(chat: Chat) -> Wish<Chat>
    func sendMessage(_ message: Message) -> Wish<Message>
    func deleteMessage(_ mesasge: Message) -> Wish<Void>
    func markAsRead(message: Message) -> Wish<Message>
}

