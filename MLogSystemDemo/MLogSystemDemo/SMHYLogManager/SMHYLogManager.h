//
//  SMHYLogManager.h
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMHYFileLogger.h"

#define SMHYLogContentext 1000
#define SMHYLog(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo, SMHYLogContentext, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

NS_ASSUME_NONNULL_BEGIN

@interface SMHYLogManager : NSObject

+ (void)sm_setUpManager;
+ (SMHYFileLogger *)sm_fileLogger;

@end

NS_ASSUME_NONNULL_END
