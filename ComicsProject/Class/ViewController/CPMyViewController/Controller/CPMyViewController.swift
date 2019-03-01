//
//  CPMyViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/18.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class CPMyViewController: CPBaseViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.background
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        self.tableView.parallaxHeader.view = headerView
        self.tableView.parallaxHeader.height = 200
        self.tableView.parallaxHeader.minimumHeight = navigationBarY
        self.tableView.parallaxHeader.mode = .fill
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
        
    }
    
    override func confignavigationBar() {
        super.confignavigationBar()
        navigationController?.barStyle(.clear)
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.parallaxHeader.height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let sectionArr = dataSource[section]
         return sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL")!
        if cell.isEqual(nil) {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CELL")
        }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        let sectionArr = dataSource[indexPath.section]
        let dic:[String:String] = sectionArr[indexPath.row]
        cell.imageView?.image = UIImage(named: dic["icon"] ?? "")
        cell.textLabel?.text = dic["title"]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    private lazy var tableView :UITableView = {
        let tb = UITableView()
        tb.backgroundColor = UIColor.background
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    private lazy var headerView : CPMYHeaderView = {
        return CPMYHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
    }()
    
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -(scrollView.parallaxHeader.minimumHeight) {
            navigationController?.barStyle(.theme)
            navigationItem.title = "我的"
        } else {
            navigationController?.barStyle(.clear)
            navigationItem.title = ""
        }
    }
    
    private lazy var dataSource : Array = {
        return [
            [["icon":"mine_vip", "title": "我的VIP"],
             ["icon":"mine_coin", "title": "充值妖气币"]],
            
            [["icon":"mine_accout", "title": "消费记录"],
             ["icon":"mine_subscript", "title": "我的订阅"],
             ["icon":"mine_seal", "title": "我的封印图"]],
            
            [["icon":"mine_message", "title": "我的消息/优惠券"],
             ["icon":"mine_cashew", "title": "妖果商城"],
             ["icon":"mine_freed", "title": "在线阅读免流量"]],
                
            [["icon":"mine_feedBack", "title": "帮助中心"],
             ["icon":"mine_mail", "title": "我要反馈"],
             ["icon":"mine_judge", "title": "给我们评分"],
             ["icon":"mine_author", "title": "成为作者"],
             ["icon":"mine_setting", "title": "设置"]]
        ]
    }()
    
}

