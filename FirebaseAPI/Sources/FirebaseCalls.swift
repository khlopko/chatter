//
//  FirebaseCalls.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import API
import AsyncCore
import Entities

final class FirebaseCalls: WebCalls {

    init() {
    }

    func createChat(with user: Entities.User) -> Wish<Chat> {
        return Wish { _ in

        }
    }

    func createChat(with users: [Entities.User]) -> Wish<Chat> {
        return Wish { _ in

        }
    }

    func createChat(title: String) -> Wish<Chat> {
        return Wish { _ in

        }
    }

    func deleteChat(_ chat: Chat) -> Wish<Void> {
        return Wish { _ in

        }
    }

    func markAsRead(chat: Chat) -> Wish<Chat> {
        return Wish { _ in

        }
    }

    func sendMessage(_ message: Message) -> Wish<Message> {
        return Wish { _ in

        }
    }

    func deleteMessage(_ mesasge: Message) -> Wish<Void> {
        return Wish { _ in

        }
    }
    
    func markAsRead(message: Message) -> Wish<Message> {
        return Wish { _ in

        }
    }
}

