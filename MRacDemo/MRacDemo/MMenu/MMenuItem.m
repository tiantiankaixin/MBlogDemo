//
//  MMenuItem.m
//  MRacDemo
//
//  Created by mal on 2019/9/28.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MMenuItem.h"

@implementation MMenuItem

+ (MMenuItem *)itemWithClass:(Class)aClass title:(NSString *)title turnType:(MTurnType)type
{
    MMenuItem *item = [[MMenuItem alloc] init];
    item.itemClass = aClass;
    item.itemTitle = title;
    item.turnType = type;
    return item;
}

@end
