//
//  AllViewController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/3.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit
import MJRefresh

class AllViewController: UITableViewController {

    lazy var dataArray : Array = [ProductModel]()

    lazy var allHeaderView : AllHeaderView = AllHeaderView.allHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.isHidden = true
//        automaticallyAdjustsScrollViewInsets = false
//
//        if #available(iOS 11.0, *) {
//            tableView.insetsContentViewsToSafeArea = false
//        } else {
//            // Fallback on earlier versions
//        }
        tableView.tableHeaderView = allHeaderView
        
        tableView.rowHeight = 137

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        loadData()
        
        tableView.mj_header = MJRefreshHeader(refreshingBlock: {
            self.loadData()
        })
    }

}

extension AllViewController {
    private func loadData() {
        
        let urlString = String.HostString + "/api/product/AllList"
        
        let dict : [String : AnyObject] = ["bigProductType" : "5" as AnyObject]
        
        
        NetWorkTool.request(type: .post, url: urlString, param: dict, resultBlock: {
            (responseObj: Any?, error: Error?) -> () in
            self.tableView.mj_header.endRefreshing()
            if error != nil {
                return
            }
            let allDataDict = (responseObj as! [String : AnyObject])["data"]
//            uLog(allDataDict)
            
            // MARK: - 处理数据
            self.dataArray = ProductModel.mj_objectArray(withKeyValuesArray: allDataDict) as! [ProductModel]

            self.tableView.reloadData()
            
        })

    }
    
    
}



// MARK: - tableView相关
extension AllViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.model = dataArray[indexPath.row]

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
