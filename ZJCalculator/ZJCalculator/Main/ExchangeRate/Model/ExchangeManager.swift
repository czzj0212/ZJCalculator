//
//  ExchangeManager.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/23.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import UIKit
import Foundation
import CoreData
let kCommonCurrencyUserdefaultKey = "kCommonCurrencyUserdefaultKey"
let kDataUpdateTimeUserdefaultKey = "kDataUpdateTimeUserdefaultKey"
let kShouldCalculateNotificationKey = "kShouldCalculateNotificationKey"

class ExchangeManager: NSObject {
    
    //单例
    static let shared = ExchangeManager()
    private override init() {
        
        super.init()
        self.loadDataSource()
        if self.shouldRefreshExchangeRate() {
            
            self.refreshExchangeRate()
        }
    }
    
    var dataSource : Array<Any?> = []
    //要计算的货币index
    var calculateIndex = 0 {
    
        didSet(oldValue) {
            
            let model : CurrencyModel = dataSource[calculateIndex] as! CurrencyModel
            calculateCurPrice = model.exchangeRate
            calculateSumString = "1"

        }
    
    }
    //要计算的货币code
    var calculateCurCode :String {
    
        set(newValue){
        
        
        }
        get{
            print(calculateIndex)
            print(commonCurrencies![calculateIndex] as! String)
            return commonCurrencies![calculateIndex] as! String
        }
    }
    //输入的要计算的金额
    var calculateSumString : String = "1"{
    
        didSet(oldValue){
        
            if oldValue != calculateSumString {
                
                NotificationCenter.default.post(name: Notification.Name.init(kShouldCalculateNotificationKey), object: nil)
            }
        }
        
    }
    
    var calculateCurPrice : Float = 1.000
    
    //显示的3个货币
    var commonCurrencies :Array<Any>? {
        
        set(newValue){
         
            if newValue != nil {
                
                UserDefaults.standard.set(newValue, forKey: kCommonCurrencyUserdefaultKey)
            }
            self.loadDataSource()
        }
        
        get{
           
            var array =  UserDefaults.standard.value(forKey: kCommonCurrencyUserdefaultKey)
            if array == nil {
                
                array = ["CNY","EUR","USD"]
                UserDefaults.standard.set(array, forKey: kCommonCurrencyUserdefaultKey)
  
            }
            return array as? Array<Any>
        }
    }
    
    //刷新显示的货币
    func loadDataSource() {
        
        dataSource.removeAll()
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        
        let requestResult = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CurrencyModel")
        let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: "CurrencyModel", in: appDelegate.persistentContainer.viewContext)
        requestResult.entity = entity
        
        for code  in commonCurrencies! {
            
            let predicate = NSPredicate.init(format: "code = %@",code as! String)
            requestResult.predicate = predicate
            do{
                let fetchCodes = try appDelegate.persistentContainer.viewContext.fetch(requestResult)
                dataSource.append(fetchCodes.first)
            }catch{
                print("get_coredata_fail!")
            }
            
        }
        
    }
    //判断上次更新日期,是否需要更新
    func shouldRefreshExchangeRate()->Bool {
        let lastDateString = UserDefaults.standard.value(forKey: kDataUpdateTimeUserdefaultKey) as? String
        
        if lastDateString != nil {
            
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy年MM月dd日"
            let nowDateString = formatter.string(from: Date.init())
            if nowDateString == lastDateString {
            
                return false
            }else {
            
                return true
            }
        }else{
        
            return true
        }
    
    }
    //更新货币汇率
    func refreshExchangeRate() {
        NetworkManager.shared.request(requestType: .GET, urlString: http_getCurrencyListUrlString, parameters: nil) { (json) in
            
            if let jsonDic :NSDictionary = json as! NSDictionary? {
                print(json!)
                let filePath:String = NSHomeDirectory() + path_exchangePlist
                let result :NSDictionary = jsonDic["list"] as! NSDictionary
                let myArray: NSArray = result["resources"] as! NSArray
                
                for dic in myArray {
                    
                    let resource :NSDictionary = (dic as AnyObject)["resource"] as! NSDictionary
                    let fields :NSDictionary = resource["fields"] as! NSDictionary
                    
                    let symbol :String = fields["symbol"] as! String
                    let code = symbol.substring(to:symbol.index(symbol.startIndex, offsetBy: 3))
                    let price :String = fields["price"] as! String
                    //
                    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
                    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CurrencyModel")
                    let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: "CurrencyModel", in: appDelegate.persistentContainer.viewContext)!
                    let predicate = NSPredicate(format: "code=%@",code)
                    request.entity = entity
                    request.predicate = predicate
                    
                    //设置更新日期
                    let formatter = DateFormatter.init()
                    formatter.dateFormat = "yyyy年MM月dd日"
                    let nowDateString = formatter.string(from: Date.init())
                    UserDefaults.standard.set(nowDateString, forKey: kDataUpdateTimeUserdefaultKey)
                    do{
                        let userList = try appDelegate.persistentContainer.viewContext.fetch(request) as! [CurrencyModel] as NSArray
                        if userList.count != 0 {
                            let user = userList[0] as! CurrencyModel
                            user.exchangeRate = Float(price)!
                            try appDelegate.persistentContainer.viewContext.save()
                            print("修改成功 ~ ~")
                        }else{
                            print("修改失败，没有符合条件的货币！")
                        }
                    }catch{
                        print("修改失败 ~ ~")
                    }
                }
                
                print(filePath)
            }
            
        }
        
    }
    
    //计算按钮事件
    func caculatorWithButtonTag(tag:Int) -> () {
        
        if(tag<=10){
            
            if calculateSumString.characters.count >= 15 {
                
                return
            }
        
        }
        switch tag {
        case 0...9:
            if calculateSumString == "0" {
                calculateSumString = String(tag)
            }else {
                calculateSumString += String(tag)
            }
        case 10:
            //小数点
            if calculateSumString.contains(".") {
                break
            }else{
                calculateSumString += "."
            }
        case 11:
            //AC 清空
            calculateSumString = "0"

        case 12:
            //退格
            if calculateSumString.characters.count < 2 {
                calculateSumString = "0"
            }else{
            
                calculateSumString = calculateSumString.substring(to: calculateSumString.index(before:calculateSumString.endIndex))
            }

        default:
            break
        }
    }
    
    
}
