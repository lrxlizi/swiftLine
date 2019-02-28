//
//  CPRecommendMoreList.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/28.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import SwiftyJSON

class CPRecommendMoreList: CPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var dataSource:NSMutableArray?
    
    private var argCon: Int = 0
    private var argName: String?
    private var argValue: Int = 0
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.dataSource = NSMutableArray.init()
       
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.dataSource?.count)!>0 {
            return (self.dataSource?.count)!
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model:recommedMoreListModel = self.dataSource![indexPath.row] as! recommedMoreListModel
        var cell:CPRecommendMoreListCell = tableView.dequeueReusableCell(withIdentifier: "MORECELL") as! CPRecommendMoreListCell
        if  cell.isEqual(nil) {
            cell =  CPRecommendMoreListCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "MORECELL")
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.model = model
//        cell.cellForModel(dict: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 180
        
    }
    private lazy var tableView:UITableView = {
        let tb = UITableView()
        tb.backgroundColor = UIColor.background
        tb.delegate = self
        tb.dataSource = self
        tb.register(CPRecommendMoreListCell.self, forCellReuseIdentifier: "MORECELL")
        tb.tableFooterView = UIView.init()
        return tb
    }()
    
    //接收参数
    convenience init(param: AnyObject) {
        self.init()
            guard let argConI = param["argCon"] else {return}
            if argConI == nil {
                self.argCon = 0
            }else{
                self.argCon = argConI as! Int
            }
    
            guard let argValue = param["argValue"] else {return}
            if argValue == nil {
                self.argValue = 0
            }else{
                self.argValue  = argValue as! Int
            }
    
            guard let argName = param["argName"] else { return}
            if argName == nil{
                self.argName = ""
            }else{
                self.argName = ((argName as AnyObject) as! String)
            }
        
        PublicClass.lzNetWorkingPath(path: .comicList(argCon:self.argCon, argName: self.argName ?? "", argValue: self.argValue, page: self.page), successBlock: { (data) in
            
            let allData:AnyObject = data as AnyObject
            let code:NSNumber = allData["code"] as! NSNumber
            if code  == 1 {
                print("data==",allData)
                let All:AnyObject = (allData["data"]) as AnyObject
                let returnData:AnyObject = All["returnData"] as AnyObject
                let  comicLists = returnData["comics"] as AnyObject
                for i in 0..<comicLists.count{
                    let dic = comicLists[i] as AnyObject
                    let dicJson = PublicClass.getJSONStringFromDictionary(dictionary: dic as! NSDictionary)
                    let da = PublicClass.getStringtoData(str: dicJson) //字符串转data
                    let json = JSON(data: da)//转成JSON
                    let model = recommedMoreListModel(json: json)
                    self.dataSource?.add(model)
                    self.tableView.reloadData()
                }
            }
        }) { (error) in
            
        }
        
    }
    

}
