//
//  HomeHeaderView.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/5.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit
import FWCycleScrollView

class HomeHeaderView: UIView {
    
    @IBOutlet weak var cyckeScrollowView: FWCycleScrollView!
    
    @IBOutlet weak var activityImageView: UIImageView!
    
    // MARK:- 提供快速通过xib创建的类方法
    class func homeHeaderView() -> HomeHeaderView {
        return Bundle.main.loadNibNamed("HomeHeaderView", owner: nil, options: nil)?.first as! HomeHeaderView
    }

    
    
    @IBAction func pingtaijiesao(_ sender: Any) {
   
    }
    
    
    @IBAction func remenhuodong(_ sender: Any) {
    
    }
    
    @IBAction func yaoqinghaoyou(_ sender: Any) {
   
    }
    
    @IBAction func tejiazhuanqu(_ sender: Any) {
  
    }
    
}
