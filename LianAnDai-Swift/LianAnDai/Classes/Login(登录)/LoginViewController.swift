//
//  LoginViewController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/4.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwoedTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        phoneTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(false)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let dict : [String : AnyObject] = ["mobile" : phoneTextField?.text as AnyObject, "pwd" : passwoedTextField?.text as AnyObject]
   
        let urlString = String.HostString + "/api/Users/loginwithpwd"
        
        NetWorkTool.request(type: .post, url: urlString, param: dict, resultBlock: {
            (responseObj: Any?, error: Error?) -> () in
            if error != nil {
                return
            }
            
            let allData = responseObj as! [String : AnyObject]
            let userInfoDict = allData["data"]
            let userInfo = UserInfoModel(dict: userInfoDict as! [String : AnyObject])
            
            //将用户信息保存
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            accountPath = (accountPath as NSString).appendingPathComponent("accout.plist")
            NSKeyedArchiver.archiveRootObject(userInfo, toFile: accountPath)
            
            //account对象设置到单例对象中
            UserData.shareInstance.userInfo = userInfo

            self.dismissLoginVC()
        })
        
    }    
}


extension LoginViewController {
    
    private func setNavBarItems() {
        title = "登录"
        view.backgroundColor = UIColor.background
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "close_gray"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(LoginViewController.dismissLoginVC))
    }
    
    @objc private func dismissLoginVC() {
        tabBarController?.selectedIndex = 0
        dismiss(animated: true, completion: nil)
    }
    
}

