//
//  AILogManager.swift
//  AILogManagerDemo
//
//  Created by mal on 2020/5/21.
//  Copyright © 2020 mal. All rights reserved.
//

import Foundation
import CocoaLumberjack

class AILogManager {
    static let share: AILogManager = {
        let manager = AILogManager()
        manager.configue()
        return manager
    }()
    
    func configue() {
        configueWith(logger: AIDefaultLogger.self)
        configueWith(logger: AIDownloadLogger.self)
        #if DEBUG
        DDLog.add(DDOSLogger.sharedInstance)
        #endif
    }
    
    func configueWith(logger: AILoggerProtocol.Type) {
        let fileDirectory = logger.directoryPath()
        let logFileManager = DDLogFileManagerDefault(logsDirectory: fileDirectory)
        
        let filter = AILogFormatter()
        filter.add(toWhitelist: logger.context())
        
        let fileLogger: DDFileLogger = DDFileLogger(logFileManager: logFileManager) // File Logger
        fileLogger.rollingFrequency = logger.logFileSaveTime()
        fileLogger.logFileManager.maximumNumberOfLogFiles = logger.logFilesCount()
        fileLogger.maximumFileSize = logger.logFileSize()
        
        fileLogger.logFormatter = filter
        print(fileLogger.currentLogFileInfo ?? "")
        DDLog.add(fileLogger)
    }
}

fileprivate class AILogFormatter: DDContextWhitelistFilterLogFormatter {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    override func format(message logMessage: DDLogMessage) -> String? {
        let isOnWhiteList = `is`(onWhitelist: logMessage.context)
        if isOnWhiteList {
            let datestr = dateFormatter.string(from: logMessage.timestamp)
            let filename = logMessage.fileName
            let line = logMessage.line
            let message = logMessage.message
            let logStr = "[\(datestr)] \(filename) \(line) \(message)"
            return logStr
        }
        return nil
    }
}


