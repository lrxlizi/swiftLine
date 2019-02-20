//
//  CPBannerDetailViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class CPBannerDetailViewController: CPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    convenience init(comicid: String) {
        self.init()
        print("id===",comicid)
    }
    
    

}
