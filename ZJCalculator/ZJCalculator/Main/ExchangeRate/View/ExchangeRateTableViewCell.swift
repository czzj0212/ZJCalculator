//
//  ExchangeRateTableViewCell.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/23.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import UIKit

class ExchangeRateTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var currencyModel : CurrencyModel? {
        
        didSet(oldValue){
            
            if currencyModel != nil {
                
               priceLabel.text = String(currencyModel!.exchangeRate)
                nameLabel.text = currencyModel!.name
                codeLabel.text = currencyModel!.code
                let imageName = "money_"+currencyModel!.code!
                iconImageView.image = UIImage.init(named: imageName)
                //计算
                if currencyModel!.code == ExchangeManager.shared.calculateCurCode {
                    
                    priceLabel.text = ExchangeManager.shared.calculateSumString
                    priceLabel.textColor = UIColor.orange
                }else {
                    
                    let price = Float(ExchangeManager.shared.calculateSumString)!/ExchangeManager.shared.calculateCurPrice*currencyModel!.exchangeRate
                    priceLabel.text = String(price)
                    priceLabel.textColor = myColor(r: 74, g: 74, b: 74, a: 1)

                }
            }
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
