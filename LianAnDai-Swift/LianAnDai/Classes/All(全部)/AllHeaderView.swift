//
//  AllHeaderView.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/10.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class AllHeaderView: UIView {

    class func allHeaderView() -> AllHeaderView {
        return Bundle.main.loadNibNamed("AllHeaderView", owner: nil, options: nil)?.first as! AllHeaderView
    }


}
