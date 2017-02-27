//
//  HomeNavigationController.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/17.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import Foundation
import UIKit


class HomeNavigationController: UINavigationController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //毛玻璃
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.gray
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black,NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)];

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
