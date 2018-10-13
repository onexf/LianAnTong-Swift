//
//  TabBarController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/5.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self;

    }

    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.tabBarItem.title == "我" {
            if !(UserData.shareInstance.isLogin) {
                let loginVC = LoginViewController()
                let loginNavVC = UINavigationController(rootViewController: loginVC)
                present(loginNavVC, animated: true, completion: nil)

                return false
            }
        }
        return true
    }
}
