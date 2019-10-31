//
//  MHelp.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/31.
//  Copyright © 2019 mal. All rights reserved.
//

import Foundation

class MHelp {

    static var startTime : Double = 0.0
    class func m_startTime() {
        
        startTime = CFAbsoluteTimeGetCurrent()
    }
    class func m_costTime() -> Double {
        
        return CFAbsoluteTimeGetCurrent() - startTime
    }
    class func m_printCostTime() {
        
        let time = self.m_costTime() * 1000
        print(String.init(format: "耗时：%.8f毫秒", time))
    }
}

