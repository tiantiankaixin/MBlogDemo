//
//  MSetFrame.m
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MSetFrame.h"

@implementation MSetFrame

//MARK: - -----------------get & set
- (NSMutableArray *)handleArray
{
    if (_handleArray == nil)
    {
        _handleArray = [NSMutableArray arrayWithCapacity:4];
    }
    return _handleArray;
}

//MARK: - public function
- (MFrameHandle *)left
{
    return [self m_addHandleWithType:MH_LEFT];
}

- (MFrameHandle *)right
{
    return [self m_addHandleWithType:MH_RIGHT];
}

- (MFrameHandle *)top
{
    return [self m_addHandleWithType:MH_TOP];
}

- (MFrameHandle *)bottom
{
    return [self m_addHandleWithType:MH_BOTTOM];
}

- (MFrameHandle *)width
{
    return [self m_addHandleWithType:MH_WIDTH];
}

- (MFrameHandle *)height
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
            for (int i = 0; i < pa.count; i++)
            {
                MFrameHandle *handel = [self.handleArray objectAtIndex:i];
                [handel m_setValue:pa[i]];
            }
        }
    };
}

//MARK: - MFrameHandleDelegate
- (MFrameHandle *)m_addHandleWithType:(MHandleType)type
{
    MFrameHandle *handle = [[MFrameHandle alloc] init];
    handle.type = type;
    handle.m_delegate = self;
    handle.view = self.view;
    [self.handleArray addObject:handle];
    return handle;
}

- (void)dealloc
{
    NSLog(@"MSetFrame dealloc");
}

@end
