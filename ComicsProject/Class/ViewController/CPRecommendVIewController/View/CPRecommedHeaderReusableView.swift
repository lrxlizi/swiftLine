//
//  CPRecommedHeaderReusableView.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

typealias CPComicCHeadMoreActionClosure = ()->Void

protocol CPComicCheadDelegate: class {
    func comicChead(_ comicCHead: CPRecommedHeaderReusableView ,moreAcrion button: UIButton)
}

class CPRecommedHeaderReusableView: UICollectionReusableView {
    
    weak var delegate : CPComicCheadDelegate?
    
    private var moreActionClosure: CPComicCHeadMoreActionClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconView : UIImageView = {
        return UIImageView()
    }()
    
    lazy var titleLB : UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.black
        return lb
    }()
    
    lazy var moreBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn .setTitle("•••", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return btn
    }()
    
    
   
    
    @objc func moreAction(button:UIButton){
        delegate?.comicChead(self,moreAcrion: button)
        guard let closure = moreActionClosure else { return}
        closure()
    }
    
    func moreActionClosure(_ closure: CPComicCHeadMoreActionClosure?){
        moreActionClosure = closure
    }
    
    func configUI(){
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        addSubview(titleLB)
        titleLB.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(5)
            $0.centerY.height.equalTo(iconView)
            $0.width.equalTo(200)
        }
        
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(30)
        }
    }
    
    func setValue(dict:AnyObject){
        
       guard let name = dict["itemTitle"] else {return}
        if name == nil{
            self.titleLB.text = ""
        }else{
            self.titleLB.text = (dict["itemTitle"] as! String)
        }
        
        guard let titleIconUrl = dict["titleIconUrl"] else {return}
        if titleIconUrl == nil{
            iconView.image = UIImage(named: " ")
            iconView.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(0)
                make.width.height.equalTo(0)
            }
        }else{
            iconView.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(5)
                make.width.height.equalTo(30)
            }
            
             iconView.kf.setImage(urlString: (dict["titleIconUrl"] as! String))
        }
        
    }
    
    
}
