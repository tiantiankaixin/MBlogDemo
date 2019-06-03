//
//  SMHYLogFileManager.m
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "SMHYLogFileManager.h"

@implementation SMHYLogFileManager

//MARK: - init
+ (SMHYLogFileManager *)sm_logfileManager
{
    SMHYLogFileManager *logFileManager =
    [[SMHYLogFileManager alloc] initWithLogsDirectory:[self sm_logDirectory]];
    return logFileManager;
}

//MARK: - config func
+ (NSString *)sm_logRootDirectory
{
    NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    return cacheFilePath;
}

+ (NSString *)sm_logDirectoryName
{
    return @"HYLog";
}

//MARK: - override super method
- (NSString *)newLogFileName
{
    return @"test";
}

//MARK: - -----------------private method
//MARK: log文件目录
+ (NSString *)sm_logDirectory
{
    NSString *rootPath = [self sm_logRootDirectory];
    NSString *directoryName = [self sm_logDirectoryName];
    return [NSString stringWithFormat:@"%@/%@", rootPath, directoryName];
}

@end
