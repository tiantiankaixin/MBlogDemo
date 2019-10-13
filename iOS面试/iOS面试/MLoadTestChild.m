//
//  MLoadTestChild.m
//  iOS面试
//
//  Created by mal on 2019/9/10.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MLoadTestChild.h"

@implementation MLoadTestChild

+ (void)load
{
    NSLog(@"MLoadTestChild");
}

+ (void)initialize
{
    NSLog(@"MLoadTestChild initialize");
}

@end
