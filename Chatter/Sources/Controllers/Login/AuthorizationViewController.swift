//
//  AuthorizationViewController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/22/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Tools

final class AuthorizationViewController: ViewController<AuthorizationContainerView>, UIScrollViewDelegate {

    private let login = LoginViewController()
    private let signUp = SignUpViewController()

    private var currentIndex = 0

    private var childs: [ViewController<AuthorizationView>] {
        return [login, signUp,]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        childs.forEach(addChild)
        navigationController?.navigationBar.removeShadow().backgroundColor(.white)
        signUp.contentView.setEnabled(false, animated: false)
        contentView.scrollView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var childFrame = self.childFrame
        childs.forEach {
            $0.view.frame = childFrame
            childFrame.origin.x = $0.view.frame.maxX
        }
        let scrollView = contentView.scrollView
        scrollView.contentSize.width = scrollView.bounds.width + CGFloat(childs.count - 1) * childFrame.width
    }

    private func addChild(_ viewController: UIViewController) {
        addChildViewController(viewController)
        contentView.scrollView.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }

    private var childFrame: CGRect {
        var frame = contentView.scrollView.bounds
        let top = frame.height * 0.05
        frame.origin.y += top
        frame.size.height -= top
        let left: CGFloat = 60
        frame.origin.x += left
        frame.size.width -= left * 2
        return frame
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = min(
            childs.count - 1,
            max(0, Int(round(scrollView.contentOffset.x / scrollView.bounds.width)))
        )
        if index == currentIndex {
            return
        }
        childs[currentIndex].contentView.setEnabled(false)
        childs[index].contentView.setEnabled(true)
        currentIndex = index
    }
}
