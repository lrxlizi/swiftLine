//
//  MacroTool.swift
//  SnakitDemo
//
//  Created by 栗子 on 2019/2/16.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import Foundation

import UIKit

import SnapKit

//网络
import Moya
import RxSwift
import SwiftyJSON
import SwiftyJSONMappable
import Kingfisher

let  SCREEN_WIDTH = UIScreen.main.bounds.width

let  SCREEN_HEIGH = UIScreen.main.bounds.height

let bundle = Bundle(path: Bundle.main.path(forResource: "ComicsProject.bundle", ofType: nil) ?? "")

public func imageNamed(_ name:String)-> UIImage{
    
    guard let image = UIImage(named: name, in: bundle, compatibleWith: nil) else{
        return UIImage()
    }
    
    return image
    
}
