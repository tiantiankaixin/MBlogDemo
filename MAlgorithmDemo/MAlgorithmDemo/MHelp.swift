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


/*
 递归的思想：分而治之
 1、终止条件（事件最小切片 到这里事情就结束了）
 2、递归迭代条件（要求不断减小事件的规模像终止条件靠拢）
 */
