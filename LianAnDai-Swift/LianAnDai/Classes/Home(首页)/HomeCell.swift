//
//  HomeCell.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/6.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nianhualv: UILabel!
    @IBOutlet weak var qigoujine: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    var model : ProductModel? {
        didSet {
            guard let model = model else {
                return
            }
            nameLabel.text = model.productName
            if model.profitRatio!.contains("%") {
                nianhualv.text = model.profitRatio!
            } else {
                nianhualv.text = model.profitRatio! + "%"
            }
            qigoujine.text = (model.purchaseStartAmount?.stringValue)! + "元起购"
            timeLabel.text = (model.termOfInvestment?.stringValue)! + "天"
            typeLabel.text = model.riskLevel
            subTitle.text = model.smallTitle1
        }
    }

    override func awakeFromNib() {
        selectionStyle = .none
    }
}
