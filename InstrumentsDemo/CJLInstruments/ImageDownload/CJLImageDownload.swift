//
//  CJLImageDownload.swift
//  CJLCustomInstruments
//
//  Created  by CJL on 2022/8/3.
//  Copyright © 2022 CoderCJL. All rights reserved.
//

import UIKit
import os.signpost

class CJLMockData {
    /// 图片名
    var name:String?
    
    /// 图片下载的时间
    var needTime:Int?
    
    init() {
        //  随机数字
        needTime = (Int)(arc4random() % 4) + 1
    }
}

/// 下载状态
///
/// - CJLImageLoadStatusUnkown: 未知
/// - CJLImageLoadStatusIng: 开始
/// - CJLImageLoadStatusFinish: 完成
/// - CJLImageLoadStatusCancel: 取消
enum CJLImageLoadStatus {
    case CJLImageLoadStatusUnkown
    case CJLImageLoadStatusIng
    case CJLImageLoadStatusFinish
    case CJLImageLoadStatusCancel
}


class CJLImageDownload {
    /// mock 数据
    var mockData:CJLMockData? {
        didSet {
            name = mockData?.name
            needTime = mockData?.needTime
        }
    }
    
    /// 图片名
    var name:String?
    
    /// 图片下载的时间
    var needTime:Int?
    
    /// 定时器
    var timer:DispatchSourceTimer?
    
    weak var obj:AnyObject?
    
    /// 下载状态
    var loadStatus:CJLImageLoadStatus? {
        didSet {
            // 未知
            if loadStatus == .CJLImageLoadStatusUnkown {
                return
            }
            
            // ID
            let signpostID = OSSignpostID(log: CJLSignpostLog.imageLoadLog, object: self.obj!)
            let address = unsafeBitCast(self.mockData!, to: UInt.self)
            
            // 开始
            if loadStatus == .CJLImageLoadStatusIng {
                os_signpost(.begin, log: CJLSignpostLog.imageLoadLog, name: "Background Image", signpostID: signpostID, "Image name:%{public}@, Caller:%lu", name!, address)
                return
            }
            
            var status = "finish"
            // 完成
            if loadStatus == .CJLImageLoadStatusFinish {
                
            }
            
            // 取消
            if loadStatus == .CJLImageLoadStatusCancel {
                status = "cancel"
            }
            
            os_signpost(.end, log: CJLSignpostLog.imageLoadLog, name: "Background Image", signpostID: signpostID, "Status:%{public}@, Size:%lu", status, needTime!)
        }
    }
    
    /// init
    init() {
        loadStatus = .CJLImageLoadStatusUnkown
    }
    
    // 开始下载 (模拟)
    func start(obj:AnyObject) -> Void {
        
        clearTime();
        
        self.obj = obj
        loadStatus = .CJLImageLoadStatusIng
        
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        let timerInterval = (Double)(needTime!)
        timer?.schedule(wallDeadline: .now()+timerInterval, repeating: 9999999999)
        timer?.setEventHandler {
            [weak self] in
            self?.loadStatus = .CJLImageLoadStatusFinish
            
            self?.timer?.setEventHandler(handler: {
                
            })
            self?.timer?.setCancelHandler(handler: {
                
            })
        }
        
        timer?.resume()
    }
    
    // 取消
    func cancel(obj:AnyObject) -> Void {
        self.obj = obj
        if loadStatus != .CJLImageLoadStatusFinish {
            if timer != nil {
                self.loadStatus = .CJLImageLoadStatusCancel
                clearTime();
            }
        }
    }
    
    // 清空定时器
    private func clearTime() {
        // 清空之前的操作
        if let t = timer {
            
            t.setEventHandler {}
            
            timer = nil
        }
    }
}
