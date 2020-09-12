//
//  AILogger.swift
//  AILogManagerDemo
//
//  Created by mal on 2020/5/21.
//  Copyright © 2020 mal. All rights reserved.
//

import Foundation
import CocoaLumberjack

private let kLogPrefix = "AILog"

protocol AILoggerProtocol {
    static func directoryPath() -> String?
    static func logFilesCount() ->  UInt
    static func logFileSize() -> UInt64
    static func context() -> Int
    static func logFileSaveTime() -> TimeInterval
    static func log(_ input: Any...)
}

extension AILoggerProtocol {
    static func logFileSaveTime() -> TimeInterval {
        return 3600 * 24
    }
     
    static func logFilesCount() ->  UInt {
        return 1
    }
    
    static func logFileSize() -> UInt64 {
        return 1024 * 1024 * 3
    }
    
    static func log(_ input: Any...) {
         _DDLogMessage("\(input)", level: DDDefaultLogLevel, flag: .info, context: context(), file: #file, function: #function, line: #line, tag: nil, asynchronous: false, ddlog: DDLog.sharedInstance)
    }
}

class AIDefaultLogger: AILoggerProtocol {
    static func context() -> Int {
        1000
    }
    
    static func directoryPath() -> String? {
        return AIFileManager.createDirectory(dirName: kLogPrefix + "AILog", sandBoxType: .inDocument)
    }
}

class AIDownloadLogger: AILoggerProtocol {
    static func context() -> Int {
        1001
    }
    
    static func directoryPath() -> String? {
        return AIFileManager.createDirectory(dirName: kLogPrefix + "AIDownloadLog", sandBoxType: .inDocument)
    }
}
