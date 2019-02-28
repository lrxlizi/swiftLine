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
        iv.backgroundColor = UIColor.white
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
        self.contentView .addSubview(subNameLB)
        subNameLB.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
            make.right.equalTo(-2)
            make.height.equalTo(12)
        }
        
        self.contentView.addSubview(nameLB)
        nameLB.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(subNameLB.snp.top).offset(-10)
            make.right.equalTo(-2)
            make.height.equalTo(14)
        }
        
        self.contentView .addSubview(iconVIew)
        iconVIew.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(5)
            make.bottom.equalTo(self.nameLB.snp.top).offset(-5)
        }
        
        
    }
    func setValueCell(dict:AnyObject ,comicType:NSNumber){
       
        iconVIew.kf.setImage(urlString: (dict["cover"] as! String))
        
        guard let name = dict["name"] else {return}
        if name == nil{
            self.nameLB.text = (dict["title"] as! String)
        }else{
            self.nameLB.text = (dict["name"] as! String)
        }
        
        guard let subTitle = dict["subTitle"] else {return}
        if subTitle == nil{
            self.subNameLB.text = "更新至\(dict["content"] as AnyObject)集"
        }else{
            self.subNameLB.text = (dict["subTitle"] as! String)
        }

    }
    
}
