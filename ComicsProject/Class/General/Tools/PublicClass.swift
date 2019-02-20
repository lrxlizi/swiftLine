//
//  PublicClass.swift
//  SnakitDemo
//
//  Created by 栗子 on 2019/2/16.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyJSONMappable
import Moya
import MBProgressHUD

typealias successBlock = (Any) -> ()
var succBlock: successBlock?

typealias filureStrBlock = (Any) -> ()
var filureBlock: filureStrBlock?


//数据请求时的loading加载
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}
//请求时间
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<UAPI>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

class PublicClass: NSObject {

    class func netWorking(path:UAPI){
        // requestClosure请求时间 plugins插件 
        MoyaProvider<UAPI>(requestClosure: timeoutClosure,plugins: [LoadingPlugin]).request(path) { (result) in
            switch result {
            case let .success(response):
                do {
                    let httpBin = (try! response.mapJSON()) as AnyObject
                    if let block = succBlock {
                        block(httpBin)
                    }
                }
            case let .failure(error):
                print(error)
                if let block = filureBlock {
                    block(error)
                }
            }
        }
    }
    
  
    class  func getSuccessBlock(block: successBlock?) {
        succBlock = block
    }
    
    class  func getFilureBlock(block: filureStrBlock?) {
        filureBlock = block
    }
    
    //字典转字符串
    class  func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
    //字符串转data
    class func getStringFromData(str:String) ->Data{
        return str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
    }
    
    
}
/*
 
 MoyaProvider<UAPI>().request(.homePage) { (result) in
 switch result {
 case let .success(response):
 do {
 let httpBin = (try! response.mapJSON()) as AnyObject
 
 print("\n\n--------------- 网络示例Moya -------------------")
 //                    print("网络例子==",httpBin) 所有数据
 
 //列表数据
 let hotItems:AnyObject = (((httpBin["data"] as AnyObject)["returnData"]) as AnyObject)["hotItems"] as AnyObject
 print("hotItems==",hotItems)
 
 let dic1:AnyObject = hotItems[0] as AnyObject
 print("dic----",dic1["comic_id"]as AnyObject)//带as AnyObject/Any 是具体的value  不加是 Optional(Optional(value))
 
 } catch {
 print(error)
 }
 case let .failure(error):
 print(error)
 }
 }
 
 */

/*
 class func netWorking(path:UAPI){
 
 MoyaProvider<UAPI>().request(path) { (result) in
 switch result {
 case let .success(response):
 do {
 let httpBin = (try! response.mapJSON()) as AnyObject
 //                    print("http===",httpBin)
 //                    print("data===",data)
 let self1 = PublicClass()
 if let block = self1.block {
 block(httpBin)
 }
 } catch {
 print(error)
 }
 case let .failure(error):
 print(error)
 }
 }
 }
 
 */
