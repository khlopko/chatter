//
//  ChatsViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 1/29/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import FirebaseAPI
import Transitions

final class ChatsViewController: ViewController<ChatsView>,
    UITableViewDataSource,
    UITableViewDelegate,
    UIGestureRecognizerDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.table.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        contentView.table.dataSource = self
        contentView.table.delegate = self
        configureNavigation()
        contentView.pan.addTarget(self, action: #selector(handle(pan:)))
        contentView.pan.delegate = self
        (navigationController as? TabNavigationController)?.horizontalController = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customTabBar?.isInteractiveTransition = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        customTabBar?.isInteractiveTransition = false
    }

    func handle(profile: UIBarButtonItem) {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

    func handle(add: UIBarButtonItem) {
    }

    func handle(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            let translation = pan.translation(in: view)
            if fabs(translation.x) > fabs(translation.y) && translation.x <= 0 {
                customTabBar?.isInteractiveTransition = true
                tabBarController?.selectedIndex += 1
            }
        default:
            break
        }
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

    private func configureNavigation() {
        navigationItem.title = "Chats"
        navigationController?.navigationBar
            .backgroundColor(.v28)
            .attributeTitle(font: Font.bold.withSize(21), textColor: .white)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_person")?.withRenderingMode(.alwaysTemplate), style: .plain,
            target: self, action: #selector(handle(profile:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate), style: .plain,
            target: self, action: #selector(handle(add:)))
    }

    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - HorizontalAnimatingController

extension ChatsViewController: HorizontalAnimatingController {

    var mainView: UIView {
        return view
    }
    var pan: UIPanGestureRecognizer? {
        return contentView.pan
    }
}
