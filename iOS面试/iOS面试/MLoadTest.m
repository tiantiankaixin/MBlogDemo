//
//  MLoadTest.m
//  iOS面试
//
//  Created by mal on 2019/9/10.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MLoadTest.h"

@implementation MLoadTest

+ (instancetype)loadTest
{
    MLoadTest *obj = [[MLoadTest alloc] init];
    return obj;
}

+ (id)m_loadTest
{
    MLoadTest *obj = [[MLoadTest alloc] init];
    return obj;
}

+ (void)load
{
    NSLog(@"MloadTest");
}

+ (void)initialize
{
    NSLog(@"MloadTest initialize");
}

- (void)test
{
    NSLog(@"MLoadTest test");
}

@end
