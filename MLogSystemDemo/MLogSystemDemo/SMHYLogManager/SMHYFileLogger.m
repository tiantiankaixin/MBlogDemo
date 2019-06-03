//
//  SMHYFileLogger.m
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "SMHYFileLogger.h"

@implementation SMHYFileLogger

//MARK: - init
+ (SMHYFileLogger *)sm_fileLoggerWithFileManager:(SMHYLogFileManager *)fileManager logFormatter:(nonnull SMHYLogFormatter *)formatter
{
    SMHYFileLogger *customFileLogger = [[SMHYFileLogger alloc] initWithLogFileManager:fileManager];
    customFileLogger.logFormatter = formatter;
    return customFileLogger;
}

//MARK: - config func
+ (NSTimeInterval)sm_logSaveTime
{
    return 3600 * 24;
}

+ (NSUInteger)sm_logFileNum
{
    return 1;
}

+ (unsigned long long)sm_logMaxFileSize
{
    return 5 * 1024 * 1024;
}

@end
