//
//  PublicModel.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/19.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyJSONMappable

class PublicModel: NSObject {

}


/*
 带as AnyObject/Any 是具体的value  不加是 Optional(Optional(value))
 */



class ListModel : JSONMappable{
    var  comicType : NSNumber
    var  argName   : String
    var  argType   : String
    var  argValue  : String
    var  canedit   : String
    var  comics    : [Comics]?
    
    required init(json: JSON) {
        comicType = json["comicType"].numberValue
        argName = json["argName"].stringValue
        argType = json["argType"].stringValue
        argValue = json["argValue"].stringValue
        canedit = json["canedit"].stringValue
        comics = json["comics"].arrayValue.map({ (json) -> Comics in
            Comics(json: json)
        })
    }
}

class Comics : JSONMappable {
    var cover : String
    
    required init(json: JSON) {
        cover = json["cover"].stringValue
    }

}


class recommedMoreListModel : JSONMappable{
    
    var  author            : String
    var  comicId           : NSNumber
    var  conTag            : NSNumber
    var  cover             : String
    var  description       : String
    var  flag              : NSNumber
    var  is_vip            : NSNumber
    var  name              : String
    var  short_description : String
    var  tags              : Array<Any>
    required init(json: JSON) {
        author = json["author"].stringValue
        comicId = json["comicId"].numberValue
        conTag = json["conTag"].numberValue
        cover = json["cover"].stringValue
        description = json["description"].stringValue
        flag = json["flag"].numberValue
        is_vip = json["is_vip"].numberValue
        name = json["name"].stringValue
        short_description = json["short_description"].stringValue
        tags = json["tags"].arrayObject!
    }
    
    
    
}
