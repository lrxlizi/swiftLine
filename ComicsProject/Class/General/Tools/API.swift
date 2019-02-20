//
//  API.swift
//  SnakitDemo
//
//  Created by 栗子 on 2019/2/16.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import SwiftyJSONMappable

enum UAPI{
    case homePage
    case discover
    case recommend(sexType: Int)//推荐列表
}

extension UAPI: TargetType{
    private struct UApiKey {
        static var key = "fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986:::open"
    }
    
    var sampleData: Data {
         return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters = ["time": Int32(Date().timeIntervalSince1970),
                         "device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "key": UApiKey.key,
                         "target": "U17_3.0",
                         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        switch self {
        
        case .recommend(let sexType):
            parmeters["sexType"] = sexType
            parmeters["v"] = 3320101
            
       
        default: break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
   
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
    }
   
    var path: String {
        switch self {
        case .homePage:
            return "search/hotkeywordsnew"
        case .discover:
            return "discover"
        case .recommend:
           return "comic/boutiqueListNew"
        }
    }
    
    var method: Moya.Method {
        return .get
            
        }
}




