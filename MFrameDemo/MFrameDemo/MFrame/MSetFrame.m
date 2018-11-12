//
//  MSetFrame.m
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MSetFrame.h"
#import "UIView+mframe.h"

typedef NS_ENUM(NSInteger, MHandleType){
    
    MH_WIDTH = 998,
    MH_HEIGHT = 999,
    MH_LEFT = 1000,
    MH_RIGHT = 1001,
    MH_TOP = 1002,
    MH_BOTTOM = 1003,
};

@implementation MSetFrame

//MARK: - -----------------get & set
- (NSMutableArray *)handleArray
{
    if (_handleArray == nil)
    {
        _handleArray = [NSMutableArray array];
    }
    return _handleArray;
}

//MARK: - public function
- (MSetFrame *)left
{
    return [self m_addHandleWithType:MH_LEFT];
}

- (MSetFrame *)right
{
    return [self m_addHandleWithType:MH_RIGHT];
}

- (MSetFrame *)top
{
    return [self m_addHandleWithType:MH_TOP];
}

- (MSetFrame *)bottom
{
    return [self m_addHandleWithType:MH_BOTTOM];
}

- (MSetFrame *)width
{
    return [self m_addHandleWithType:MH_WIDTH];
}

- (MSetFrame *)height
{
    return [self m_addHandleWithType:MH_HEIGHT];
}

- (void (^)(NSArray *))m_equal
{
    //MSetFrame本身并没有持有这个block，所以在block里访问self没有循环引用。
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

//MARK: - MFrameHandleDelegate
- (MSetFrame *)m_addHandleWithType:(MHandleType)type
{
    NSNumber *typeNum = [NSNumber numberWithInteger:type];
    [self.handleArray addObject:typeNum];
    return self;
}

- (void)m_setValue:(NSNumber *)value type:(MHandleType)type
{
    CGFloat floatValue = value.floatValue;
    switch (type)
    {
        case MH_LEFT:
        {
            self.view.m_left = floatValue;
            break;
        }
        case MH_RIGHT:
        {
            self.view.m_right = floatValue;
            break;
        }
        case MH_TOP:
        {
            self.view.m_top = floatValue;
            break;
        }
        case MH_BOTTOM:
        {
            self.view.m_bottom = floatValue;
            break;
        }
        case MH_WIDTH:
        {
            self.view.m_width = floatValue;
            break;
        }
        case MH_HEIGHT:
        {
            self.view.m_height = floatValue;
            break;
        }
        default:
            break;
    }
}

- (void)dealloc
{
    NSLog(@"MSetFrame dealloc");
}

@end
