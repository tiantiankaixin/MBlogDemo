//
//  UIView+frame.m
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (MSetFrame *)mset
{
    MSetFrame *set = [[MSetFrame alloc] init];
    set.view = self;
    return set;
}

@end
