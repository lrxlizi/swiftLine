//
//  CPVipViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SwiftyJSON
import SwiftyJSONMappable

/**

 SwiftyJSON 使用
 
*/

class CPVipViewController: CPBaseViewController {
 var dataSource : NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
        dataSource = NSMutableArray.init()
        initData()
    }
    

    
    func initData(){
        PublicClass.netWorking(path: .recommend(sexType: 1))
        PublicClass.getSuccessBlock { (data) in
            let allData:AnyObject = data as AnyObject
            print("all==",allData)
            let code:NSNumber = allData["code"] as! NSNumber
            if code  == 1 {
        
                let All:AnyObject = (allData["data"]) as AnyObject
                let returnData:AnyObject = All["returnData"] as AnyObject
                
                let  comicLists = returnData["comicLists"] as AnyObject
                for i in 0..<comicLists.count{
                    let dic = comicLists[i] as AnyObject
                    let dicJson = PublicClass.getJSONStringFromDictionary(dictionary: dic as! NSDictionary)
                    let da = PublicClass.getStringFromData(str: dicJson) //字符串转data
                    let json = JSON(data: da)//转成JSON
                    let model = ListModel(json: json)
                    self.dataSource?.add(model)
                }
                
                for j in 0..<self.dataSource!.count{
                    let model:ListModel = self.dataSource![j] as! ListModel
                    print("model.argName===",model.comics)
                }
                
                
               
            }
        }
        PublicClass.getFilureBlock { (error) in
            print("error==",error)
            
        }
    }
 
    
}
