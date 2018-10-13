//
//  ProfileHeaderView.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/12.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet weak var phoneNum: UILabel!
    
    @IBOutlet weak var isAuthLabel: UILabel!
    
    @IBOutlet weak var zongzichan: UILabel!
    
    @IBOutlet weak var zongyue: UILabel!
    @IBOutlet weak var zongtouzi: UILabel!
    
    @IBOutlet weak var zongshouyi: UILabel!
    
    @IBOutlet weak var showAssetsBtn: UIButton!
    
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    
    var assetsData : MineHomePageModel? {
        didSet {
            if showAssetsBtn.isSelected == false {
                guard let assetsData = assetsData else {
                    return
                }
                
                phoneNum.text = UserData.shareInstance.userInfo?.phoneNum
                zongzichan.text = assetsData.totalAssetValue
                zongyue.text = assetsData.totalAmount
                zongtouzi.text = assetsData.otherAssets
                zongshouyi.text = assetsData.earnTotalAmount
            } else {
                zongzichan.text = "******"
                zongyue.text = "******"
                zongtouzi.text = "******"
                zongshouyi.text = "******"
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        isAuthLabel.layer.borderWidth = 1
        isAuthLabel.layer.borderColor = UIColor.white.cgColor
        isAuthLabel.layer.cornerRadius = 5
        topMargin.constant = statusbarHeight + 15.0
    }
    class func profileHeaderView() -> ProfileHeaderView {
        return Bundle.main.loadNibNamed("ProfileHeaderView", owner: nil, options: nil)?.first as! ProfileHeaderView
    }
    
    
    @IBAction func messageVC(_ sender: UIButton) {
        
    }
    
    @IBAction func hideShowAssets(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == false {
            guard let assetsData = assetsData else {
                return
            }
            zongzichan.text = assetsData.totalAssetValue
            zongyue.text = assetsData.totalAmount
            zongtouzi.text = assetsData.otherAssets
            zongshouyi.text = assetsData.earnTotalAmount
        } else {
            zongzichan.text = "******"
            zongyue.text = "******"
            zongtouzi.text = "******"
            zongshouyi.text = "******"
        }
    }
    
}
