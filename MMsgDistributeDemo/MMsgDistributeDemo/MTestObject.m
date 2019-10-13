//
//  MTestObject.m
//  MMsgDistributeDemo
//
//  Created by mal on 2019/9/16.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MTestObject.h"

@implementation MTestObject

- (void)test1
{
    NSLog(@"%@ test1", NSStringFromClass(self.class));
}

- (void)test2
{
    NSLog(@"%@ test2", NSStringFromClass(self.class));
}

@end
