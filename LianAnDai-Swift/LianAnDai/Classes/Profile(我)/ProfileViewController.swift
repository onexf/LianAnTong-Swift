//
//  ProfileViewController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/3.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit
import MJRefresh

class ProfileViewController: UIViewController {

    // MARK: - 获取登录状态
    var isLogin : Bool = UserData.shareInstance.isLogin

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: -statusbarHeight, width: screenWidth, height: screenHeight + statusbarHeight - (tabBarController?.tabBar.bounds.size.height)!))
        tableView.backgroundColor = UIColor.background
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        weak var weakSelf = self
        tableView.mj_header = MJRefreshHeader.init(refreshingBlock: {
            weakSelf?.getAssetData()
        })
        return tableView
    }()
    
    lazy var dataSource : Array = [["image" : "wdyhk", "title" : "我的银行卡"], ["image" : "zfmm", "title" : "支付密码"], ["image" : "icon_my_order", "title" : "我的订单"], ["image" : "icon_in_gold", "title" : "卡券中心"], ["image" : "icon_invite", "title" : "我的邀请"], ["image" : "icon_help_center", "title" : "帮助中心"], ["image" : "icon_out_gold", "title" : "设置"]]
    
    lazy var headerView : ProfileHeaderView = {
        let headerView = ProfileHeaderView.profileHeaderView()
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        navigationController?.navigationBar.isHidden = true
        getAssetData()
    }
    
}
// MARK: - 数据请求
extension ProfileViewController {
    
    private func getAssetData() {
        let urlString = String.HostString + "/api/Users/MyIndex"
        
      
        NetWorkTool.request(type: .post, url: urlString, resultBlock: {
            (responseObj: Any?, error: Error?) -> () in

            self.tableView.mj_header.endRefreshing()
            if error != nil {
                return
            }
            let allDataDict = (responseObj as! [String : AnyObject])["data"] as! [String : AnyObject]
//            uLog(allDataDict)

            let assetsData = MineHomePageModel.mj_object(withKeyValues: allDataDict)
            self.headerView.assetsData = assetsData
//            self.tableView.reloadData()
        })

        
        

    }
    
}
// MARK: - UITableView
extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let identifer = "ProfileCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifer)
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.font = UIFont(name: "Helvetica", size: 14)
        }
        let dict : Dictionary = dataSource[indexPath.row]
        
        cell?.textLabel?.text = dict["title"]
        cell?.imageView?.image = UIImage(named: dict["image"]!)
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
