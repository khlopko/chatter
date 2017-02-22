//
//  ChatsViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import FirebaseAPI

final class ChatsViewController: ViewController<ChatsView>, UITableViewDataSource, UITableViewDelegate {

    private let s = ChatService()

    override func viewDidLoad() {
        super.viewDidLoad()
//        contentView.table.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
//        contentView.table.dataSource = self
//        contentView.table.delegate = self
//        navigationItem.title = Session.current.user?.displayName
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_person")?.withRenderingMode(.alwaysTemplate), style: .plain,
            target: self, action: #selector(handle(profile:)))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate), style: .plain,
//            target: self, action: #selector(handle(add:)))
    }

    func handle(profile: UIBarButtonItem) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    func handle(add: UIBarButtonItem) {
        s.add()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.update()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
