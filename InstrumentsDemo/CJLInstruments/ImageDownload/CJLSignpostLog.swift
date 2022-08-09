//
//  CJLSignpostLog.swift
//  CJLCustomInstruments
//
//  Created  by CJL on 2022/8/3.
//  Copyright © 2022 CoderCJL. All rights reserved.
//

import os.signpost

final class CJLSignpostLog {
    
    /// log Object
    static let imageLoadLog = OSLog(subsystem: "com.cjl.imageload", category: "ImageLoad")
    
    /// pointsOfInterst log Object
    static let pointsOfInterst = OSLog(subsystem: "com.cjl.imageload", category: OSLog.Category.pointsOfInterest)
}
