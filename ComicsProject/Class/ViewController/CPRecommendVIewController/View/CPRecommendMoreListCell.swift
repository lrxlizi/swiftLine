//
//  CPRecommendMoreListCell.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/28.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import SwiftyJSON

class CPRecommendMoreListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private lazy var iconVIew:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.white
        return iv
        
    }()
    
    private lazy var nameLB:UILabel = {
        let name = UILabel()
        name.textColor = UIColor.black
        name.textAlignment = NSTextAlignment.left
        name.font = UIFont.systemFont(ofSize: 15)
        return name
    }()
    
    private lazy var subName:UILabel = {
        let subName = UILabel()
        subName.textColor = RGBA(r: 120, g: 120, b: 120, a: 1)
        subName.textAlignment = NSTextAlignment.left
        subName.font = UIFont.systemFont(ofSize: 13)
        return subName
    }()
    
    private lazy var contentLB:UILabel = {
        let contentLB = UILabel()
        contentLB.textColor = RGBA(r: 120, g: 120, b: 120, a: 1)
        contentLB.textAlignment = NSTextAlignment.left
        contentLB.font = UIFont.systemFont(ofSize: 13)
        contentLB.numberOfLines = 3;
        return contentLB
    }()
    
    private lazy var timeLB:UILabel = {
        let timeLB = UILabel()
        timeLB.textColor = RGBA(r: 240, g: 165, b: 107, a: 1)
        timeLB.textAlignment = NSTextAlignment.left
        timeLB.font = UIFont.systemFont(ofSize: 14)
        timeLB.numberOfLines = 3;
        return timeLB
    }()
    
    private lazy var line:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.background
        return line
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.iconVIew)
        self.iconVIew.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(110)
        }
        
        self.contentView.addSubview(self.nameLB)
        self.nameLB.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconVIew.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.equalTo(15)
            make.height.equalTo(15)
        }
        
        self.contentView.addSubview(self.subName)
        self.subName.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLB.snp.left)
            make.right.equalTo(-10)
            make.top.equalTo(self.nameLB.snp.bottom).offset(10)
            make.height.equalTo(14)
        }
        
        self.contentView.addSubview(self.line)
        self.line.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.height.equalTo(1)
            make.left.right.equalTo(1)
        }
        
        self.contentView.addSubview(self.timeLB)
        self.timeLB.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLB.snp.left)
            make.right.equalTo(-10)
            make.bottom.equalTo(self.line.snp.top).offset(-10)
            make.height.equalTo(10)
        }
        
        self.contentView.addSubview(self.contentLB)
        self.contentLB.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLB.snp.left)
            make.right.equalTo(-10)
            make.bottom.equalTo(self.timeLB.snp.top).offset(-30)
             make.top.equalTo(self.subName.snp.bottom).offset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellForModel(dict:recommedMoreListModel){

        iconVIew.kf.setImage(urlString: (dict.cover))
        self.nameLB.text = dict.name
        self.subName.text = dict.author

        self.contentLB.text = dict.description
        self.timeLB.text = dict.short_description

    }
    
    var model:recommedMoreListModel?{
        didSet {
            guard let model = model else { return }
            iconVIew.kf.setImage(urlString: (model.cover))
            self.nameLB.text = model.name
            let tags:Array = model.tags
            var tag:String = ""
            if(tags.count == 1){
                self.subName.text = (tags[0] as! String)
            }else{
                for i in 0..<tags.count{
                    let str:String =  tags[i] as! String
                    if tag.count>0{
                         tag = tag + "|" + str
                    }else{
                         tag = str
                    }
                }
                self.subName.text  = tag
            }
            self.contentLB.text = model.description
            self.timeLB.text = model.short_description
        }
    }
   
}
