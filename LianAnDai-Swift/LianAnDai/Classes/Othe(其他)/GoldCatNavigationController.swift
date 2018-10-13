//
//  GoldCatNavigationController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/10.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class GoldCatNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
