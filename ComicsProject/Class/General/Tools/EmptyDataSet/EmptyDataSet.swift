//
//  EmptyDataSet.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/18.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

/**
 空白页
 第三方 EmptyDataSet_Swift
 
 */

import Foundation
import EmptyDataSet_Swift


extension UIScrollView{
    
    private struct AssciatedKeys {
        static var cpemptyKey : Void?
    
    }
   
    var cpempty : CPEmPtyView?{
        get{
            return objc_getAssociatedObject(self, &AssciatedKeys.cpemptyKey) as? CPEmPtyView
        }
        set{
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
            objc_setAssociatedObject(self, &AssciatedKeys.cpemptyKey,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


class CPEmPtyView: EmptyDataSetSource,EmptyDataSetDelegate {
    var image : UIImage?
    var allowShow :Bool = false
    var verticalOffset:CGFloat = 0
    
    private var tapClosure : (() ->Void)?
    
    init(image:UIImage? = UIImage(named: "nodata"),verticalOffset:CGFloat = 0 , tapClosure:(() ->Void)?){
        self.image = image
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
    
    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
    
    
    
    
}
