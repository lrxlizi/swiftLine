//
//  CPRecommedTopCell.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class CPRecommedTopCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    private lazy var iconView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var nameLB : UILabel = {
       let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    }()
    
    
     func configUI(){
        
        self.backgroundColor = UIColor.white
        
        clipsToBounds = true
        contentView.addSubview(iconView)
        contentView.addSubview(nameLB)
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.height.equalTo(40)
        }
        
        nameLB.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(2)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }
    }
    
    func setValueCell(dic:AnyObject){
        self.iconView.kf.setImage(urlString: (dic["cover"] as! String))
        self.nameLB.text = (dic["name"] as! String)
        
    }
    
}
