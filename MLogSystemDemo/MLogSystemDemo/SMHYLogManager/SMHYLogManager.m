//
//  SMHYLogManager.m
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "SMHYLogManager.h"

@implementation SMHYLogManager

+ (void)sm_setUpManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
         [DDLog addLogger:[self sm_fileLogger]];
    });
}

+ (SMHYFileLogger *)sm_fileLogger
{
    SMHYLogFileManager *fileManager = [SMHYLogFileManager sm_logfileManager];
    SMHYLogFormatter *logFormatter = [SMHYLogFormatter sm_logFormatterWithContext:SMHYLogContentext];
    SMHYFileLogger *logger = [SMHYFileLogger sm_fileLoggerWithFileManager:fileManager logFormatter:logFormatter];
    return logger;
}

@end
