//
//  PublicModel.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit

class PublicModel: NSObject {

}

//struct recommendBannerModel {
//    var content:String?
//    var cover : String?
//    var  ext : [Array<Any>]
//    var  id : String?
//    var  linkType : String?
//    var title  : String?
//
//    init(jsonData:AnyObject){
//        content = jsonData["content"] as? String
//        cover = jsonData["cover"] as? String
//        ext = (jsonData["ext"] as? Array)!
//        id = jsonData["id"] as? String
//        linkType = jsonData["linkType"] as? String
//        title = jsonData["title"] as? String
//    }
//}

struct recommendComicsListModel {
    var  comicType : String?
    var  argName   : String?
    var  argType   : String?
    var  argValue  : String?
    var  canedit   : String?
    var  comics    : [Array<Any>]?
    
    init(jsonData:AnyObject){
        comicType   = jsonData["comicType"] as? String
        argName     = jsonData["argName"] as? String
        argType     = jsonData["argType"] as? String
        argValue    = jsonData["argValue"] as? String
        canedit     = jsonData["canedit"] as? String
        comics      = (jsonData["comics"] as? Array)
    }
    
    
}
