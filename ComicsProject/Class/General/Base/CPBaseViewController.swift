//
//  CPBaseViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/18.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import SnapKit
import Reusable
import Kingfisher


class CPBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.background
        
        if  #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
        
    }
    func configUI(){}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confignavigationBar()
    }
    
    func confignavigationBar(){
        
        guard let navi = navigationController else {
            return
        }
        if navi.visibleViewController == self{
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count>1{                
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(pressBack))
            }
        }
    }
    
   @objc func pressBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CPBaseViewController{
    override var preferredStatusBarStyle:UIStatusBarStyle{
        return .lightContent
    }
    
}
