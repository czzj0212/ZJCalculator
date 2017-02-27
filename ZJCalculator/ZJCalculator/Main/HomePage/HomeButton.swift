//
//  HomeButton.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/27.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import UIKit

class HomeButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.titleLabel?.textAlignment = NSTextAlignment.center;

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imageW : CGFloat = contentRect.width/2.0
        let rect : CGRect = CGRect.init(x: 0, y: 0, width: imageW, height: imageW)
        
        return rect
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW : CGFloat = contentRect.width/2.0

        let rect : CGRect = CGRect.init(x: 0, y: imageW+20, width: imageW, height: contentRect.height-20-imageW);
        return rect
    }
}
