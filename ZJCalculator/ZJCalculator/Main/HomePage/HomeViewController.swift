//
//  HomeViewController.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/17.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let calButtonWidth = SCREEN_W/3.0
    let calButtonHeight = (SCREEN_H-64)/3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray

        self.title = "ZJ计算器"
        for i:Int in 0 ..< 1 {
        
            let x = CGFloat(i/3)*calButtonWidth
            let y = CGFloat(i%3)*calButtonHeight
            createCalButton(x: x, y: y, imageNmae: "exchange_icon", title: "汇率计算",tag:i)
        }
        
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    func createCalButton(x:CGFloat,y:CGFloat,imageNmae:String,title:String,tag:Int) ->()
    {

        let buttonRect = CGRect(x: x, y: y, width: calButtonWidth, height:calButtonHeight)
    
        let button = HomeButton.init(frame: buttonRect)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle(title, for: .normal)
        button.setImage(UIImage.init(named: imageNmae), for: .normal)
        button.addTarget(self, action: #selector(calButtonAction(calButton:)), for: .touchUpInside)
        button.tag = tag
        self.view.addSubview(button)
    }
    
    func calButtonAction(calButton:UIButton) -> () {
        
        if calButton.tag == 0 {
            self.navigationController?.pushViewController(ExchangeRateController(), animated: true)
        }
    }
}
