//
//  SMHYFileLogger.h
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "DDFileLogger.h"
#import "SMHYLogFileManager.h"
#import "SMHYLogFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMHYFileLogger : DDFileLogger

//MARK: - init
+ (SMHYFileLogger *)sm_fileLoggerWithFileManager:(SMHYLogFileManager *)fileManager logFormatter:(SMHYLogFormatter *)formatter;

//MARK: - config func
/**
 log存放时间

 @return NSTimeInterval(默认1天)
 */
+ (NSTimeInterval)sm_logSaveTime;

/**
 单个log文件大小(默认5M)

 @return bytes
 */
+ (unsigned long long)sm_logMaxFileSize;

/**
 log文件个数

 @return NSUInteger(默认1个)
 */
+ (NSUInteger)sm_logFileNum;

@end

NS_ASSUME_NONNULL_END
