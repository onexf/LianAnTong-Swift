//
//  NetworkTools.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/5.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import AFNetworking

enum RequestType {
    case get
    case post
}

class NetworkTools: AFHTTPSessionManager {

    static let shareInstance : NetworkTools = {
        let manager = NetworkTools()
        
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return manager
    }()
    
}

extension NetworkTools {
    func request(type: RequestType, url: String, param: [String: Any], resultBlock: @escaping (Any?, Error?) -> ()) {
        
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
            NetworkTools.shareInstance.get(url, parameters: dict, progress: nil, success: successBlock, failure: failBlock)
        } else {
            NetworkTools.shareInstance.post(url, parameters: dict, progress: nil, success: successBlock, failure: failBlock)
        }
        
    }
}


// MARK: - 接口请求

extension NetworkTools {
    func loginRequest(dict : [String : Any], finished : @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) {
        let urlString = String.HostString + "/api/Users/loginwithpwd"
        request(type: .post, url: urlString, param: dict, resultBlock: { (result, error) -> () in
            finished(result as? [String : AnyObject], error! as NSError)
        })
    }
    
}
