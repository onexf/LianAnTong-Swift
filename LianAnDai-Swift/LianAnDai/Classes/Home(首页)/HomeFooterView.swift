//
//  HomeFooterView.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/10.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class HomeFooterView: UIView {


    class func homeFooterView() -> HomeFooterView {
        return Bundle.main.loadNibNamed("HomeFooterView", owner: nil, options: nil)?.first as! HomeFooterView
    }

}
