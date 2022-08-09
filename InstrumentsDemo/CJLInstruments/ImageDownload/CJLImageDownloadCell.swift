//
//  CJLImageDownloadCell.swift
//  CJLCustomInstruments
//
//  Created  by CJL on 2022/8/3.
//  Copyright © 2022 CoderCJL. All rights reserved.
//

import UIKit

class CJLImageDownloadCell: UITableViewCell {

    var imageData:CJLImageDownload? {
        
        didSet {
            textLabel?.text = imageData?.name
            detailTextLabel?.text = "所需时间 \(imageData?.needTime ?? 0)"
            
            // 取消之前下载
            if let value = oldValue {
                if let l = value.loadStatus {
                    if l != .CJLImageLoadStatusFinish {
                        value.cancel(obj: self)
                    }
                }
            }
            
            // 开始当前下载
            if let value = imageData {
                if let l = value.loadStatus {
                    if l != .CJLImageLoadStatusFinish {
                        value.start(obj: self)
                    }
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
