//
//  UIView+masframe.m
//  MFrameDemo
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "UIView+masframe.h"
#import "UIView+mframe.h"

typedef NS_ENUM(NSInteger, MHandleType){
    
    MH_WIDTH = 998,
    MH_HEIGHT = 999,
    MH_LEFT = 1000,
    MH_RIGHT = 1001,
    MH_TOP = 1002,
    MH_BOTTOM = 1003,
};

@implementation UIView (masframe)

//MARK: - -----------------get & set
- (NSMutableArray *)handleArray
{
    static NSMutableArray *array = nil;
    if (array == nil)
    {
        array = [NSMutableArray array];
    }
    return array;
}

//MARK: -
- (UIView *)left
{
    return [self m_addHandleWithType:MH_LEFT];
}

- (UIView *)right
{
    return [self m_addHandleWithType:MH_RIGHT];
}

- (UIView *)top
{
    return [self m_addHandleWithType:MH_TOP];
}

- (UIView *)bottom
{
    return [self m_addHandleWithType:MH_BOTTOM];
}

- (UIView *)width
{
    return [self m_addHandleWithType:MH_WIDTH];
}

- (UIView *)height
{
    return [self m_addHandleWithType:MH_HEIGHT];
}

//MARK: -
- (UIView *)m_addHandleWithType:(MHandleType)type
{
    NSNumber *typeNum = [NSNumber numberWithInteger:type];
    [self.handleArray addObject:typeNum];
    return self;
}

- (void (^)(NSArray *))m_equal
{
    //self本身并没有持有这个block，所以在block里访问self没有循环引用。
    return ^(NSArray *pa){
        
    #ifdef DEBUG
        NSAssert(pa.count == self.handleArray.count, @"MSetFrame参数个数有问题");
    #endif
        
        if (pa.count == self.handleArray.count)
        {
            [self sortHandle];
            for (int i = 0; i < pa.count; i++)
            {
                MHandleType type = [self.handleArray[i] integerValue];
                [self m_setValue:pa[i] type:type];
            }
        }
        [self.handleArray removeAllObjects];
    };
}

- (void)sortHandle
{
    [self.handleArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        
        if (obj1.integerValue < obj2.integerValue)
        {
            return NSOrderedAscending;
        }
        else if (obj1.integerValue > obj2.integerValue)
        {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}

- (void)m_setValue:(NSNumber *)value type:(MHandleType)type
{
    CGFloat floatValue = value.floatValue;
    switch (type)
    {
        case MH_LEFT:
        {
            self.m_left = floatValue;
            break;
        }
        case MH_RIGHT:
        {
            self.m_right = floatValue;
            break;
        }
        case MH_TOP:
        {
            self.m_top = floatValue;
            break;
        }
        case MH_BOTTOM:
        {
            self.m_bottom = floatValue;
            break;
        }
        case MH_WIDTH:
        {
            self.m_width = floatValue;
            break;
        }
        case MH_HEIGHT:
        {
            self.m_height = floatValue;
            break;
        }
        default:
            break;
    }
}

@end
