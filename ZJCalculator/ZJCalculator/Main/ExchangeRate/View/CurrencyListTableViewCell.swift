//
//  CurrencyListTableViewCell.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/22.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {


    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var currencyModel : CurrencyModel? {
    
        didSet(oldValue){
    
            if currencyModel != nil {
                
                nameLabel.text =  currencyModel!.name! + currencyModel!.code!
                let imageName = "money_"+currencyModel!.code!
                iconImageView.image = UIImage.init(named: imageName)
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
