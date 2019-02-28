//
//  CPRankViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import Alamofire

class CPRankViewController: CPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         self.view.backgroundColor = UIColor.cyan
        
        
        
       
        
        PublicClass.lzNetWorkingPath(path: .recommend(sexType: 1), successBlock: { (data) in
            print("data==1==",data)
        }) { (error) in
            print("error==",error)
        }
        
    }
    
//    func loadData(completetion: @escaping (_ result : String)->(), faulure: @escaping (_ result : String)->()) -> () {
//        completetion("这是啥")
//        faulure("失败")
//    }

    /*
     不带参数
     func loadData(completetion: ()->()) -> () {
     completetion()
     }
     //样式
     */
}
