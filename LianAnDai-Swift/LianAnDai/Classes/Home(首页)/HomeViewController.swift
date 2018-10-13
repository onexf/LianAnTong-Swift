//
//  HomeViewController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/3.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit
import MJExtension
import SDWebImage
import MJRefresh
class HomeViewController: UITableViewController {
    
    lazy var homeHeaderView : HomeHeaderView = HomeHeaderView.homeHeaderView()
    lazy var homeFooterView : HomeFooterView = HomeFooterView.homeFooterView()
    lazy var bannerData : Array = [HomeBannerModel]()
    lazy var section1 : Array = [ProductModel]()
    lazy var section2 :Array =  [ProductModel]()
    
    var isLogin : Bool = UserData.shareInstance.isLogin

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.isHidden = true

        tableView.tableHeaderView = homeHeaderView
        tableView.tableFooterView = homeFooterView
        tableView.rowHeight = 130
        
        requestHomeData()
        
        tableView.mj_header = MJRefreshHeader.init(refreshingBlock: {
            self.requestHomeData()
        })
    }

}
// MARK: - 数据请求
extension HomeViewController {
    private func requestHomeData() {
        
        let urlString = String.HostString + "/api/home/index"

        let dict : [String : AnyObject] = ["mobile" : "17319066282" as AnyObject]
        
        
        NetWorkTool.request(type: .post, url: urlString, param: dict, resultBlock: {
            (responseObj: Any?, error: Error?) -> () in
            self.tableView.mj_header.endRefreshing()
            if error != nil {
                return
            }
            let allDataDict = (responseObj as! [String : AnyObject])["data"] as! [String : AnyObject]
//            uLog(responseObj)

            // MARK: - 处理banner
            let bannerDictArray = allDataDict["banners"]
            let bannerArray = HomeBannerModel.mj_objectArray(withKeyValuesArray: bannerDictArray) as! [HomeBannerModel]
            self.bannerData = bannerArray
            var bannerImages = [String]()
            for bannerModel in bannerArray {
                bannerImages.append(bannerModel.picUrl!)
            }
            self.homeHeaderView.cyckeScrollowView.imageUrlStrArray = bannerImages
            
            // MARK: - 活动
            let activityDict = allDataDict["secondBaner"]

            let activityModel = ActivityModel.mj_object(withKeyValues: activityDict)
            
            self.homeHeaderView.activityImageView.sd_setImage(with: URL(string: (activityModel?.picUrl)!), completed: nil)
            
            // MARK: - 处理产品
            let product1ArrDict = allDataDict["newProductList"]
            let section1Arr = ProductModel.mj_objectArray(withKeyValuesArray: product1ArrDict) as! [ProductModel]
            self.section1 = section1Arr
            
            let product2ArrDict = allDataDict["productList"]
            self.section2 = ProductModel.mj_objectArray(withKeyValuesArray: product2ArrDict) as! [ProductModel]
            
            
            self.tableView.reloadData()

        })
        
    }

}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section1.count
        } else {
            return section2.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        
        // 2.给cell设置数据
        if indexPath.section == 0 {
            cell.model = section1[indexPath.row]
        } else {
            cell.model = section2[indexPath.row]
        }        
        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
