//
//  CPRecommendVIewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import LLCycleScrollView
import Reusable


class CPRecommendVIewController: CPBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UCollectionViewSectionBackgroundLayoutDelegateLayout {

    var galleryItems = Array<AnyObject>()
    var comicLists : NSMutableArray?
    
     private lazy var banner: LLCycleScrollView = {
        let banner = LLCycleScrollView()
        banner.backgroundColor = UIColor.background
        banner.autoScrollTimeInterval = 6
        banner.placeHolderImage = UIImage(named: "normal")
        banner.coverImage = UIImage()
        banner.pageControlBottom = 20
        banner.pageControlPosition = .right
        banner.titleBackgroundColor = UIColor.red
        banner.lldidSelectItemAtIndex = didSelectBanner(index:)
        return banner
    }()
    
    private lazy var  collectionView: UICollectionView = {
        let layout = UCollectionViewSectionBackgroundLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cw.backgroundColor = UIColor.background
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.contentInset = UIEdgeInsets(top: SCREEN_WIDTH * 0.467, left: 0, bottom: 0, right: 0)
        cw.scrollIndicatorInsets = cw.contentInset
        cw.register(CPRecommedTopCell.self , forCellWithReuseIdentifier: "TOPCELL")
        cw.register(CPRecommedCell.self, forCellWithReuseIdentifier: "CELL")
        
        cw.register(CPRecommedHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier")
         cw.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footIdentifier")
        cw.cpempty = CPEmPtyView(verticalOffset: -(cw.contentInset.top)) { self.initData() }
        return cw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.view.backgroundColor = UIColor.yellow
        comicLists = NSMutableArray.init()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(banner)
        banner.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(collectionView.contentInset.top)
        }
        
        initData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.comicLists!.count>0{
            return self.comicLists!.count
        }else{
            return 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dic = self.comicLists![section] as AnyObject
        let comics = dic["comics"] as AnyObject
        if comics.count>0{
            return comics.count
        }else{
            return 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dic = self.comicLists![indexPath.section] as AnyObject
        let comics = dic["comics"] as AnyObject
        let comicType = dic["comicType"] as! NSNumber
        if comicType == 11 {
        
            let cell : CPRecommedTopCell = collectionView.dequeueReusableCell(withReuseIdentifier:"TOPCELL", for: indexPath)as!CPRecommedTopCell
            cell.setValueCell(dic: comics[indexPath.row])
           return cell
        }
        
        let cell : CPRecommedCell = collectionView.dequeueReusableCell(withReuseIdentifier:"CELL", for: indexPath)as!CPRecommedCell
        cell.setValueCell(dict: comics[indexPath.row],comicType:comicType)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let dic = self.comicLists![indexPath.section] as AnyObject
        
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView : CPRecommedHeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerIdentifier", for: indexPath) as! CPRecommedHeaderReusableView
            headerView.setValue(dict: dic)
            return headerView
        
        }else{
            let footView : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footIdentifier", for: indexPath)
           footView.backgroundColor = UIColor.background
            return footView
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor {
        return UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dic = self.comicLists![indexPath.section] as AnyObject
        let comicType = dic["comicType"] as! NSNumber
        let comics = dic["comics"] as AnyObject
        let dict = comics[indexPath.row] as AnyObject
        guard let name = dict["name"] else { return CGSize(width: floor((ScreenWidth-5) / 2.0), height:100) }
        if comicType == 11 {
            let width = floor((ScreenWidth-15) / 4.0)
            return CGSize(width: width, height: 80)
         }else{
            if name == nil{
                if  comicType == 7 || comicType == 13{
                    return CGSize(width: floor((ScreenWidth-10) / 3.0), height:200)
                }else{
                   return CGSize(width: floor((ScreenWidth-5) / 2.0), height:155)
                }
                
            }else{
                if  comicType == 7 || comicType == 13{
                    return CGSize(width: floor((ScreenWidth-10) / 3.0), height:250)
                }else{
                    return CGSize(width: floor((ScreenWidth-5) / 2.0), height:155)
                }
            
            }
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       let dict = self.comicLists![section] as AnyObject
        guard let name = dict["itemTitle"] else { return CGSize(width: 0, height: 0) }
        if name == nil{
            return CGSize(width: 0, height: 0)
        }else{
            return CGSize(width: ScreenWidth, height: 50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: 10)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            banner.snp.updateConstraints{ $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))) }
        }
    }
    
    func initData(){
        PublicClass.netWorking(path: .recommend(sexType: 1))
        PublicClass.getSuccessBlock { (data) in
           
            let allData:AnyObject = data as AnyObject
            //            print("all==",allData)
            let code:NSNumber = allData["code"] as! NSNumber
            if code  == 1 {
                let All:AnyObject = (allData["data"]) as AnyObject
                let returnData:AnyObject = All["returnData"] as AnyObject
                //周榜 VIP榜 畅销榜 排行榜
                let  comicLists:AnyObject = returnData["comicLists"] as AnyObject
                for i in 0..<comicLists.count{
//                    print("comicLists===",comicLists[i] as AnyObject)
                    let model = comicLists[i] as AnyObject
                    self.comicLists?.add(model)
                    
                }
                /**************Banner********************/
                self.galleryItems = ((returnData["galleryItems"] as AnyObject) as! [AnyObject])
                let gallerArr = NSMutableArray.init()
                for index in 0..<self.galleryItems.count{
                    let cover = (self.galleryItems[index] as AnyObject)["cover"]
                    gallerArr .add(cover as Any)
                }
                self.banner.imagePaths = gallerArr as! Array<String>
                 /**************Banner********************/
            }else{
                self.collectionView.cpempty?.allowShow = true
            }
            self.collectionView.reloadData()
        }
        PublicClass.getFilureBlock { (error) in
            print("error==",error)
            //请求失败添加t空白页
            self.collectionView.cpempty?.allowShow = true
            self.collectionView.reloadData()
        }
    }
    
    
     private func didSelectBanner(index:NSInteger){
        let dic = self.galleryItems[index]
        let linkType:NSNumber = dic["linkType"] as! NSNumber
        let  ext = dic["ext"] as AnyObject
        let item = ext[0] as AnyObject
//        let key:String = item["key"] as! String
        let val:String = item["val"] as! String
        if linkType == 2 {
//            let web = CPWebViewController(url:key)
//            self.navigationController?.pushViewController(web, animated: true)
        }else{
            let detail = CPBannerDetailViewController(comicid: val)
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
    }

}
