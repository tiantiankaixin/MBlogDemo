//
//  SMHYLogFormatter.h
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "DDContextFilterLogFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMHYLogFormatter : DDContextWhitelistFilterLogFormatter

+ (SMHYLogFormatter *)sm_logFormatterWithContext:(NSUInteger)logContext;

@end

NS_ASSUME_NONNULL_END
