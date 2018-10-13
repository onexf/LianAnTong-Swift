//
//  MineHomePageModel.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/12.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class MineHomePageModel: NSObject {
    /** 账户余额 */
    @objc var accountBalance : String?
    /** 我在联安通赚了（元 */
    @objc var earnTotalAmount : String?
    /** 错误信息 */
    @objc var errCode : NSNumber?
    @objc var errMsg : String?
    /** 黄金资产 */
    @objc var goldAssets : String?
    /** 其他资产 */
    @objc var otherAssets : String?
    /** 总余额 */
    @objc var totalAmount : String?
    /** 资产总价值 黄资产*浮动+其他资产+账户余额 */
    @objc var totalAssetValue : String?
    /** 昨日 */
    @objc var ydTotalAmount : String?
    /** 优惠券 */
    @objc var couponCount : NSNumber?

}
