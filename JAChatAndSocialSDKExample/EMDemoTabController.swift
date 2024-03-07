//
//  EMDemoTabController.swift
//  JAChatAndSocialSDKExample
//
//  Created by 张嘉诚 on 2024/3/4.
//

import Foundation
import HyphenateChat
import SnapKit
import UIKit

class AmityDemoTabController: UITabBarController {
    let communityVC = E
    let chatVC = AmityChatHomePageViewController.make()
    let userVC = AmityUserProfilePageViewController.make(withUserId: "zhangjiacheng")
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = UIColor(named: "ComponentBackground")
        tabBar.tintColor = UIColor(named: "Tennis")
        tabBar.unselectedItemTintColor = UIColor(named: "ContentBackground")
        tabBar.setCorner(radii: 15)

        if #available(iOS 15.0, *) {
            let appearnce = UITabBarAppearance()
            appearnce.configureWithOpaqueBackground()
            appearnce.backgroundColor = UIColor(named: "ComponentBackground")
            tabBar.standardAppearance = appearnce
            tabBar.scrollEdgeAppearance = appearnce
        }

        addViewController()
    }

    override func viewDidLayoutSubviews() {
        var frame = tabBar.frame
        frame.size.width = view.frame.size.width - 88
        frame.origin.x = 44
        frame.origin.y = view.frame.size.height - frame.size.height - 18
        tabBar.frame = frame
    }

    private func addViewController() {
        setChildViewController(communityVC, NSLocalizedString("Community", comment: ""), "tennisball.fill")
        setChildViewController(chatVC, NSLocalizedString("Chat", comment: ""), "trophy.fill")
        setChildViewController(userVC, NSLocalizedString("User", comment: ""), "person.fill")
    }

    private func setChildViewController(_ childViewController: UIViewController, _ itemName: String, _ itemImage: String) {
        childViewController.title = itemName
        childViewController.tabBarItem.title = itemName
        childViewController.tabBarItem.image = UIImage(systemName: itemImage)

        let nav = UINavigationController(rootViewController: childViewController)
        addChild(nav)
    }
}


class SampleSessionHandler: SessionHandler {
    
    func sessionWillRenewAccessToken(renewal: AccessTokenRenewal) {
        renewal.renew()
    }
    
}

