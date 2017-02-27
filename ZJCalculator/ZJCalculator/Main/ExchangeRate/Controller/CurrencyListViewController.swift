//
//  CurrencyListViewController.swift
//  JJCalculator
//
//  Created by 陈志健 on 2017/2/23.
//  Copyright © 2017年 chenzhijian. All rights reserved.
//

import UIKit
import CoreData

class CurrencyListViewController: UIViewController,NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var selectedIndex : Int = 0
    
    
    init(index : Int)  {
        
        super.init(nibName: nil, bundle: nil)
        self.selectedIndex = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView : UITableView = {
        
        let tempTableView : UITableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.grouped)
        
        tempTableView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height - 64.0)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "CurrencyListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "currencyListCellID")
        return tempTableView
        
    }()
    lazy var fetchController : NSFetchedResultsController<NSFetchRequestResult> = {
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        
        let sort = NSSortDescriptor.init(key: "firstCharactor", ascending: true)
        let requestResult = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CurrencyModel")
        requestResult.sortDescriptors = [sort]
        let tempFetch = NSFetchedResultsController.init(fetchRequest: requestResult, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: "firstCharactor", cacheName: nil)
        tempFetch.delegate = self
        return tempFetch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.title = "货币选择"
        do {
            try         self.fetchController.performFetch()
            
        } catch  {
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - tableview delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyListCellID") as? CurrencyListTableViewCell
        
        let sec : NSFetchedResultsSectionInfo = (self.fetchController.sections?[indexPath.section])!
        let model : CurrencyModel = sec.objects![indexPath.row] as! CurrencyModel
        cell?.currencyModel = model
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
      return (self.fetchController.sections?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var titleArray = Array<String>.init()
        for obj in self.fetchController.sections! {
            
            let sec : NSFetchedResultsSectionInfo = obj
            let model : CurrencyModel = sec.objects![0] as! CurrencyModel
            
            titleArray.append(model.firstCharactor!)
        }
        return titleArray
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        let sec : NSFetchedResultsSectionInfo = (self.fetchController.sections?[section])!
        let model : CurrencyModel = sec.objects![0] as! CurrencyModel
        
        return model.firstCharactor
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sec : NSFetchedResultsSectionInfo = (self.fetchController.sections?[section])!
        
        return sec.numberOfObjects
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sec : NSFetchedResultsSectionInfo = (self.fetchController.sections?[indexPath.section])!
        let model : CurrencyModel = sec.objects![indexPath.row] as! CurrencyModel
        
        
        var commonCurrs = ExchangeManager.shared.commonCurrencies
        
        commonCurrs?[selectedIndex] =  model.code!
        ExchangeManager.shared.commonCurrencies = commonCurrs
        ExchangeManager.shared.calculateIndex =  ExchangeManager.shared.calculateIndex 

        _ = self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name.init(kShouldCalculateNotificationKey), object: nil)

        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
