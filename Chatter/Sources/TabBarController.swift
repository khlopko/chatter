//
//  TabBarController.swift
//  Chatter
//
//  Created by Kirill Khlopko on 2/23/17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import Tools
import Transitions

final class TabBarController: UITabBarController {

    private weak var chats: ChatsViewController?
    private weak var profile: ProfileViewController?

    let provider = AnimatorsProvider()

    var isInteractiveTransition: Bool {
        get { return provider.isInteractive }
        set { provider.isInteractive = newValue }
    }

    override var childViewControllerForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
        tabBar.barTintColor = .white
        tabBar.tintColor = .pictonBlue
        viewControllers = [makeChats(), makeProfile(),]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeChats() -> UIViewController {
        let chats = ChatsViewController()
        chats.title = "Chats"
        chats.tabBarItem.image = UIImage(named: "ic_view_list")
        chats.tabBarItem.selectedImage = UIImage(named: "ic_view_list_selected")
        self.chats = chats
        let navigation = TabNavigationController(rootViewController: chats)
        navigation.navigationBar.isTranslucent = false
        return navigation
    }

    private func makeProfile() -> UIViewController {
        let profile = ProfileViewController()
        profile.title = "Profile"
        profile.tabBarItem.image = UIImage(named: "ic_person")
        profile.tabBarItem.selectedImage = UIImage(named: "ic_person_selected")
        self.profile = profile
        let navigation = TabNavigationController(rootViewController: profile)
        navigation.navigationBar.isTranslucent = false
        return navigation
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return provider.animationController(from: fromVC, to: toVC)
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            let controller = provider.interactionController(for: animationController)
            controller?.delegate = self
            return controller
    }
}

// MARK: - InteractionControllerDelegate

extension TabBarController: InteractionControllerDelegate {

    func interactionControllerDidFinish(_ controller: InteractionController) {
        isInteractiveTransition = false
    }

    func interactionControllerDidCancel(_ controller: InteractionController) {
        isInteractiveTransition = false
    }
}

extension UIViewController {

    var customTabBar: TabBarController? {
        return tabBarController as? TabBarController
    }
}
