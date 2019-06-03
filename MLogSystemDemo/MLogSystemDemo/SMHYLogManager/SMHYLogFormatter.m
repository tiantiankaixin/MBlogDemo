//
//  SMHYLogFormatter.m
//  MLogSystemDemo
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "SMHYLogFormatter.h"

@interface SMHYLogFormatter ()

@property (nonatomic, strong) NSDateFormatter *dateformatter;

@end

@implementation SMHYLogFormatter

//MARK: - -----------------get & set
- (NSDateFormatter *)dateformatter
{
    if (_dateformatter == nil)
    {
        _dateformatter = [[NSDateFormatter alloc] init];
        _dateformatter.dateFormat = @"MM-dd HH:mm";
    }
    return _dateformatter;
}

//MARK: - init
 + (SMHYLogFormatter *)sm_logFormatterWithContext:(NSUInteger)logContext
{
    SMHYLogFormatter *logFormatter = [[SMHYLogFormatter alloc] init];
    [logFormatter addToWhitelist:logContext];
    return logFormatter;
}

//MARK: - override super method
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    BOOL isOnWhiteList = [self isOnWhitelist:logMessage->_context];
    if (isOnWhiteList)
    {
        NSString *logStr = [NSString stringWithFormat:@"[%@ %@ %@ %@] %@",
                            [self.dateformatter stringFromDate:(logMessage->_timestamp)],
                            logMessage->_fileName,
                            logMessage->_function,
                            @(logMessage->_line),
                            logMessage->_message
                            ];
        return logStr;
    }
    return nil;
}

@end
