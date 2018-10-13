//
//  UserData.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/3.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import Foundation

class UserData: NSObject {

    // MARK: - 写成单例
    static let shareInstance : UserData = UserData()
    
    // MARK: - 用户信息
    var userInfo : UserInfoModel?
    
    // MARK:- 计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("accout.plist")
    }
    
    var loginState : Bool?
    
    var isLogin : Bool {
        if userInfo == nil {
            return false
        }
        return true
    }

    // MARK:- 重写init()函数
    override init () {
        super.init()
        // 1.从沙盒中读取中归档的信息
        userInfo = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserInfoModel
    }

    
}
