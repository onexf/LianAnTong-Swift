//
//  Global.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/5.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh

extension UIColor {
    class var background: UIColor {
        return UIColor(red: 242 / 255 , green: 242 / 255, blue: 242 / 255, alpha: 1)
    }
    
    class var theme: UIColor {
        return UIColor(red: 29 / 255, green: 221 / 255, blue: 43 / 255, alpha: 1)
        
    }
}

extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
    static let HostString = "https://api.lianandai.com"
}

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let statusbarHeight = UIApplication.shared.statusBarFrame.height //statusBar的高度

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

var isIphoneX: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
            || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: print
func uLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}


extension UICollectionView {
    
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}

//MARK: swizzledMethod
extension NSObject {
    
    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

