//
//  CPRecommedCell.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class CPRecommedCell: UICollectionViewCell {

    
    override init (frame : CGRect){
        super.init(frame:frame)
         configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
       
    }
    
    
    private lazy var iconVIew:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.red
        return iv
        
    }()
    
    private lazy var nameLB : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    private lazy var subNameLB : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.textColor = UIColor.gray
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    func configUI(){
        
        self.contentView .addSubview(iconVIew)
        iconVIew.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(5)
            make.height.equalTo(100)
        }
        
        self.contentView.addSubview(nameLB)
        nameLB.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(iconVIew.snp.bottom).offset(5)
            make.right.equalTo(-2)
            make.height.equalTo(14)
        }
        
        self.contentView .addSubview(subNameLB)
        subNameLB.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(nameLB.snp.bottom).offset(10)
            make.right.equalTo(-2)
            make.height.equalTo(12)
        }
    }
    func setValueCell(dict:AnyObject ,comicType:NSNumber){
       
        if comicType == 5 {
            nameLB.snp.updateConstraints { (make) in
                make.top.equalTo(iconVIew.snp.bottom).offset(0)
                make.height.equalTo(0)
            }
            
            subNameLB.snp.updateConstraints { (make) in
                make.top.equalTo(nameLB.snp.bottom).offset(0)
                make.height.equalTo(0)
            }
        }else{
            nameLB.snp.updateConstraints { (make) in
                make.top.equalTo(iconVIew.snp.bottom).offset(10)
                make.height.equalTo(16)
            }
            subNameLB.snp.updateConstraints { (make) in
                make.top.equalTo(nameLB.snp.bottom).offset(7)
                make.height.equalTo(12)
            }
           
        }
        iconVIew.kf.setImage(urlString: (dict["cover"] as! String))
 
        
        guard let name = dict["name"] else {return}
        if name == nil{
            self.nameLB.text = ""
        }else{
            self.nameLB.text = (dict["name"] as! String)
        }
        
        guard let subTitle = dict["subTitle"] else {return}
        if subTitle == nil{
            self.subNameLB.text = ""
        }else{
            self.subNameLB.text = (dict["subTitle"] as! String)
        }

    }
    
}
