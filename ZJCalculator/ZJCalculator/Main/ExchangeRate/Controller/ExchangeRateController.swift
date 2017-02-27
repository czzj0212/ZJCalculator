//
//  ExchangeRateController.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/17.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import Foundation
import UIKit
import CoreData
//行高度
private let rowHeight : CGFloat = 86.0/667.0 * SCREEN_H
private let footerHeight : CGFloat = 15
private let tableHeight : CGFloat = rowHeight * 3 + footerHeight
class ExchangeRateController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    lazy var tableView : UITableView = {
        
        let tempTableView : UITableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.plain)

        tempTableView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: tableHeight)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.isScrollEnabled = false
        tempTableView.register(UINib.init(nibName: "ExchangeRateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "exchangeRateTableViewCellID")
        return tempTableView
    
        }()
    lazy var keyboardView : ExchangeKeyboardView = {
        
        let tempView : ExchangeKeyboardView = ExchangeKeyboardView.init(frame: CGRect.init(x: 0, y: tableHeight, width: self.view.bounds.width, height:self.view.bounds.height - 64 - tableHeight ))
        return tempView
        
    }()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "汇率计算"
        self.view.addSubview(tableView)
        self.view.addSubview(keyboardView)
        NotificationCenter.default.addObserver(self, selector: #selector(shouldCalculateNotificationAction), name: NSNotification.Name.init(kShouldCalculateNotificationKey), object: nil)

    }
    
    func shouldCalculateNotificationAction(){
    

        self.tableView.reloadData()
    }
    
        
    
    // MARK: - tableview delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeRateTableViewCellID") as? ExchangeRateTableViewCell

        let model : CurrencyModel = ExchangeManager.shared.dataSource[indexPath.row] as! CurrencyModel

        cell?.currencyModel = model

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return rowHeight
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: footerHeight))
        let label = UILabel.init(frame: view.frame)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = myColor(r: 147, g: 147, b: 147, a: 1)
        label.textAlignment = NSTextAlignment.center
        let text = UserDefaults.standard.value(forKey: kDataUpdateTimeUserdefaultKey)
        if text != nil {
            
            label.text = "汇率数据更新于: " + (text as! String!)!
        }
        view.addSubview(label)
        return view
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return footerHeight
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ExchangeManager.shared.dataSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ExchangeManager.shared.calculateIndex = indexPath.row
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let action = UITableViewRowAction.init(style: .default, title: "切换货币") { (action, indexPath) in
            let currencyListVC = CurrencyListViewController.init(index: indexPath.row)
            
            self.navigationController?.pushViewController(currencyListVC, animated: true)
            
        }
        
        return [action]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
