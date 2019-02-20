//
//  CPTabBarViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/18.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class CPTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBar.isTranslucent = false
        
        let homePage = CPHomePageViewController(titles: ["推荐","VIP","订阅","排行"], vcs: [CPRecommendVIewController(),CPVipViewController(),CPSubscribeViewController(),CPRankViewController()], pageStyle: CPPageStyle.navgationBarSegment)
        addChildViewController(homePage, title: "首页", image:UIImage(named: "tab_home"), selectedImage:UIImage(named: "tab_home_S"))
        
        let category = CPCategoryViewController()
        addChildViewController(category, title: "分类", image:UIImage(named: "tab_class"), selectedImage:UIImage(named: "tab_class_S"))
        
        let bookrack = CPBookrackViewController()
        addChildViewController(bookrack, title: "书架", image:UIImage(named: "tab_book"), selectedImage:UIImage(named: "tab_book_S"))
        
        let my = CPMyViewController()
        addChildViewController(my, title: "我的", image:UIImage(named: "tab_mine"), selectedImage:UIImage(named: "tab_mine_S"))
        
        
    }
    func addChildViewController(_ childController:UIViewController,title:String?,image:UIImage?,selectedImage:UIImage?){
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(CPNavigationController(rootViewController: childController))
    }


}
