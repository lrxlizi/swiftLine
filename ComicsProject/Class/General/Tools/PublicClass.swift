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

 func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

class PublicClass: NSObject {

    /*
     一下三种网络请求方式建议使用第二种
     */
    
    /*网络请求方式一*/
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
    
    /*网络请求方式二*/
    class func lzNetWorkingPath(path:UAPI, successBlock: @escaping (_ result : AnyObject)->(), faulureBlock: @escaping (_ result : AnyObject)->()) -> (){
        MoyaProvider<UAPI>(requestClosure: timeoutClosure,plugins: [LoadingPlugin]).request(path) { (result) in
            switch result {
            case let .success(response):
                do {
                    let httpBin = (try! response.mapJSON()) as AnyObject
                    successBlock(httpBin)
                }
            case let .failure(error):
                faulureBlock(error as AnyObject)
            }
        }
    }
    
    /*
     网络请求方式三
     Alamofire.request("http://app.u17.com/v3/appV3_3/ios/phone/comic/boutiqueListNew", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
         if(response.error == nil){
         print("请求成功==",response.result.value as  AnyObject)
         self.loadData(completetion: { (success) in
         print("成功====",success)
         }, faulure: { (failure) in
         print("失败===",failure)
         })
     
         }else{
         print("请求失败\(String(describing: response.error))")
         }
     }
     */
    
    
    class func textFunc(success:(String)->()){
        success("1122")
    }
   class func loadDate(completion: @escaping (_ result : String)->()) -> () {
        completion("ggggg")
    }
    /**
     func loadData(completetion: @escaping (_ result : String)->(), faulure: @escaping (_ result : String)->()) -> () {
     completetion("这是啥")
     faulure("失败")
     }

     
     */
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
    class func getStringtoData(str:String) ->Data{
        return str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
    }
    
    //计算富文本的高度
    class func attributedTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size.height + 5.0
    }
    
    //计算文本的高度
    class func textHeight(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
    
    //计算文本的宽度
    class func textHieght(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
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
