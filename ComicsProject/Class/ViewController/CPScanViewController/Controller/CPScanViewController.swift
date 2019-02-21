//
//  CPScanViewController.swift
//  ComicsProject
//
//  Created by 栗子 on 2019/2/21.
//  Copyright © 2019年 http://www.cnblogs.com/Lrx-lizi/    https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

import UIKit
import AVFoundation

public class CPScanViewController: UIViewController {
    
    public lazy var cameraViewController:CameraVC = .init()
    /// 动画样式
    public var animationStyle:ScanAnimationStyle = .default{
        didSet{
            cameraViewController.animationStyle = animationStyle
        }
    }
    
    // 扫描框颜色
    public var scannerColor:UIColor = .red{
        didSet{
            cameraViewController.scannerColor = scannerColor
        }
    }
    
    /// `AVCaptureMetadataOutput` metadata object types.
    public var metadata = AVMetadataObject.ObjectType.metadata {
        didSet{
            cameraViewController.metadata = metadata
        }
    }
    
    public var successBlock:((String)->())?
    public var errorBlock:((Error)->())?
    
    /// 设置标题
    public override var title: String?{
        didSet{
            
            if navigationController == nil {
                self.navigationController?.title = title
            }
        }
    }
   
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraViewController.startCapturing()
    }
}

// MARK: - CustomMethod
extension CPScanViewController{
    
    func setupUI() {
        
        if title == nil {
            title = "扫一扫"
        }
        view.backgroundColor = .black

        cameraViewController.metadata = metadata
        cameraViewController.animationStyle = animationStyle
        cameraViewController.delegate = self
        add(cameraViewController)
        
    }
    
    public func setupScanner(_ title:String? = nil, _ color:UIColor? = nil, _ style:ScanAnimationStyle? = nil,_ success:@escaping ((String)->())){
        
        if title != nil {
            self.title = title
        }
        if color != nil {
            scannerColor = color!
        }
        if style != nil {
            animationStyle = style!
        }
        successBlock = success
        
    }
}

extension CPScanViewController:CameraViewControllerDelegate{
    
    func didOutput(_ code: String) {
        successBlock?(code)
    }
    
    func didReceiveError(_ error: Error) {
        errorBlock?(error)
    }
    
}
