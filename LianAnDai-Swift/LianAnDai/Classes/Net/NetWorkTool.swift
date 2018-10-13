//
//  NetWorkTool.swift
//  Zonghexiangmu
//
//  Created by 王鑫锋 on 2018/9/7.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import AFNetworking

class NetWorkTool: NSObject {

    static func request(type: RequestType, url: String, param: [String: Any] = ["platform" : "ios"], resultBlock: @escaping (Any?, Error?) -> ()) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        if UserData.shareInstance.userInfo != nil {
            let token = UserData.shareInstance.userInfo?.token
            manager.requestSerializer.setValue(token, forHTTPHeaderField: "Authorization")
        }

        let successBlock = {
            (tast: URLSessionDataTask?, responseObj: Any?) -> Void in
            resultBlock(responseObj, nil)
        }
        let failBlock = {
            (tast: URLSessionDataTask?, error: Error) -> Void in
            resultBlock(nil, error)
        }
        var dict = param
        dict["platform"] = "ios"
        dict["appID"] = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier")
        dict["appVersion"] = 2

        if type == .get {
            manager.get(url, parameters: dict, progress: nil, success: successBlock, failure: failBlock)
        } else {
            manager.post(url, parameters: dict, progress: nil, success: successBlock, failure: failBlock)
        }
        
        
    }
}
