//
//  MLClickTimeBtn.m
//  MGesView
//
//  Created by mal on 2018/7/11.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MLClickTimeBtn.h"

@interface MLClickTimeBtn()

@property (nonatomic, assign) CFAbsoluteTime lastClickTime;

@end

@implementation MLClickTimeBtn

- (instancetype)init
{
    if (self = [super init])
    {
        _clickInterVal = 0;
        _lastClickTime = 0;
    }
    return self;
}

- (BOOL)clickCheck
{
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    if (currentTime - self.lastClickTime <= self.clickInterVal)
    {
        NSLog(@"不能点击");
        return NO;
    }
    self.lastClickTime = currentTime;
    return YES;
}

@end
