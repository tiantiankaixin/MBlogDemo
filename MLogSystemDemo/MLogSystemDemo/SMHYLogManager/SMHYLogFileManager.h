//
//  SMHYLogFileManager.h
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "DDFileLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMHYLogFileManager : DDLogFileManagerDefault

//MARK: - init
+ (SMHYLogFileManager *)sm_logfileManager;


//MARK: - config func
/**
 log日志存放的根目录（默认在cache文件夹）

 @return 目录地址
 */
+ (NSString *)sm_logRootDirectory;

/**
 次级文件夹名字（日志最终文件夹路径 根目录 + 次级文件夹名字）
 默认HYLog
 @return 文件夹名字
 */
+ (NSString *)sm_logDirectoryName;

@end

NS_ASSUME_NONNULL_END
