//
//  CPSubscribeViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class CPSubscribeViewController: CPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         self.view.backgroundColor = UIColor.purple
        
        
        let btn = UIButton(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
        btn.backgroundColor = UIColor.red
        self.view.addSubview(btn)
        btn.setTitle("微信", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(btnAction), for: UIControl.Event.touchUpInside)
        
        
        let btn1 = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        btn1.backgroundColor = UIColor.red
        self.view.addSubview(btn1)
        btn1.setTitle("支付宝", for: UIControl.State.normal)
        btn1.addTarget(self, action: #selector(btn1Action), for: UIControl.Event.touchUpInside)
        
        
    }
    
    @objc func  btnAction(){
    
        let vc = CPScanViewController()
        vc.setupScanner("",.green , .default){(code) in
            print("微信===",code)
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func  btn1Action(){
        
        let vc = CPScanViewController()
        vc.setupScanner("",.blue , .grid){(code) in
            print("支付宝===",code)
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
