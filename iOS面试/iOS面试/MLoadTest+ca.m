//
//  MLoadTest+ca.m
//  iOS面试
//
//  Created by mal on 2019/9/10.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MLoadTest+ca.h"

@implementation MLoadTest (ca)

+ (void)load
{
    NSLog(@"MLoadTest+ca.h");
}

+ (void)initialize
{
    NSLog(@"MLoadTest+ca initialize");
}

/*
load super self ca main前 启动时调用
 initialize 第一次使用的时候 类方法/实例方法
 
 
*/

@end
