//
//  ExchangeKeyboardView.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/24.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import UIKit

class ExchangeKeyboardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = myColor(r: 31, g: 39, b: 43, a: 1)
        self.createButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func createButtons()  {
        
        let buttonWidth = self.frame.width/4.0
        let buttonHeight = self.frame.height/4.0
        for i in 0...12 {
            
            let x = CGFloat(i%3)*buttonWidth
            let y = buttonHeight*2 - CGFloat(i/3)*buttonHeight

            let button = UIButton.init(type: .custom)
            switch i {
            case 0...8:
                button.frame = CGRect.init(x: x, y: y, width: buttonWidth, height: buttonHeight)
                button.tag = i+1
                button.setTitle(String(i+1), for: .normal)
            case 9:
                button.frame = CGRect.init(x: 0, y: 3*buttonHeight, width: buttonWidth*2, height: buttonHeight)
                button.tag = 0
                button.setTitle(String(0), for: .normal)
            case 10:
                button.frame = CGRect.init(x: buttonWidth*2, y: 3*buttonHeight, width: buttonWidth, height: buttonHeight)
                button.setTitle(".", for: .normal)
                button.tag = i

            case 11:
                button.frame = CGRect.init(x: buttonWidth*3, y: 0, width: buttonWidth, height: 2*buttonHeight)
                button.setTitle("AC", for: .normal)
                button.setTitleColor(UIColor.orange, for: .normal)
                button.tag = i

            case 12:
                button.frame = CGRect.init(x: buttonWidth*3, y: 2*buttonHeight, width: buttonWidth, height: 2*buttonHeight)
                button.setImage(UIImage.init(named: "exchange_keyboard_del"), for: .normal)
                button.tag = i

            default: break
            
            }
            button.setTitleColor(UIColor.gray, for: .highlighted)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.gray.cgColor
            button.addTarget(self, action: #selector(keyBoardButtonAction(button:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    
    func keyBoardButtonAction(button:UIButton) -> () {
        
        ExchangeManager.shared.caculatorWithButtonTag(tag: button.tag)
    }
    
}

