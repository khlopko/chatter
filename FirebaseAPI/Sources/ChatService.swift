//
//  ChatService.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/31/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import Firebase

public class ChatService {

    private let ref = FIRDatabase.database().reference()
    private lazy var chatsRef: FIRDatabaseReference = self.ref.child("chats")

    public init() {
//        chatsRef.observe(.childAdded, with: { snapshot in
//            print(snapshot.value)
//        })
//        chatsRef.observe(.childChanged, with: { snapshot in
//            print(snapshot.value)
//        })
//        chatsRef.observe(.childMoved, with: { snapshot in
//            print(snapshot.value)
//        })
//        chatsRef.observe(.childChanged, with: { snapshot in
//            print(snapshot.value)
//        })
//        chatsRef.observe(.childRemoved, with: { snapshot in
//            print(snapshot.value)
//        })
    }

    public func add() {
        chatsRef.childByAutoId().setValue(["title": "Test"])
    }
}
