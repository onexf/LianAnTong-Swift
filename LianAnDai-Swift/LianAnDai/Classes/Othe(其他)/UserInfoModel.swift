//
//  UserInfoModel.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/3.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class UserInfoModel: NSObject, NSCoding {
  
    
    
    var userId : NSNumber?
    var token : String?
    var inviteCode : String?
    var cellphone : String?
//    var isRegister : String?
//    var results : String?
    
    var phoneNum : String {
        get {
            if cellphone == nil {
                return "133****3333"
            }
//            var string : String = cellphone!
//
//            let rang : Range = Range.init(NSRange(location: 3, length: 4))!
//            let range = string.index(string.endIndex, offsetBy: -6)..<string.endIndex

            return "173****6282"

        }
    }
    
    
    
    init(dict : [String : AnyObject]) {
        super.init()

        uLog(dict)
        userId = dict["userId"] as? NSNumber
        token = dict["token"] as? String
        inviteCode = dict["inviteCode"] as? String
        cellphone = dict["cellphone"] as? String

        
//        setValuesForKeys(dict)
//        func setValue(value : Any?, forUndefinedKey key: String) {
//
//        }
        
    }
    // MARK:- 重写description属性
    override var description : String {
        return dictionaryWithValues(forKeys: ["cellphone", "inviteCode", "token", "userId"]).description
    }

    // MARK:- 归档&解档
    /// 解档的方法
    required init?(coder aDecoder: NSCoder) {
        userId = aDecoder.decodeObject(forKey: "userId") as? NSNumber
        token = aDecoder.decodeObject(forKey: "token") as? String
        inviteCode = aDecoder.decodeObject(forKey: "inviteCode") as? String
        cellphone = aDecoder.decodeObject(forKey: "cellphone") as? String
    }
    
    /// 归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(inviteCode, forKey: "inviteCode")
        aCoder.encode(cellphone, forKey: "cellphone")

    }
}
