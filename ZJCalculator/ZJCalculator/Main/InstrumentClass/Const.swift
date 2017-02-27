//
//  Const.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/17.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import Foundation
import UIKit

/// 判断汇率plist导入数据库是否成功
let exchangeCoredataSuccessKey = "exchangeCoredataSuccessKey"

/// 屏幕的宽
let SCREEN_W = UIScreen.main.bounds.width
/// 屏幕的高
let SCREEN_H = UIScreen.main.bounds.height
/// RGBA的颜色设置
func myColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//汇率plist目录
let path_exchangePlist = "/Documents/currency.plist"

//聚合数据,汇率appkey
let juhe_exchangeRateAppKey = "1cad3de60c4f104f787d718f508a0625"

//货币列表url
//let http_getCurrencyListUrlString = "http://op.juhe.cn/onebox/exchange/list"
let http_getCurrencyListUrlString = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"

/*
 名称	类型	必填	说明
 key	string	是	应用APPKEY(应用详细页查询)
 */

//汇率计算url
let http_ExchangeRateUrlString = "http://op.juhe.cn/onebox/exchange/currency"
/*
名称	类型	必填	说明
from	string	是	转换汇率前的货币代码
to	string	是	转换汇率成的货币代码
key	string	是	应用APPKEY(应用详细页查询)
*/
