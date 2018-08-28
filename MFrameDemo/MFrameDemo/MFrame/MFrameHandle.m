//
//  MFrameHandle.m
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MFrameHandle.h"
#import "UIView+mframe.h"

@implementation MFrameHandle

- (MFrameHandle *)left
{
    return [self.m_delegate m_addHandleWithType:MH_LEFT];
}

- (MFrameHandle *)right
{
    return [self.m_delegate m_addHandleWithType:MH_RIGHT];
}

- (MFrameHandle *)top
{
    return [self.m_delegate m_addHandleWithType:MH_TOP];
}

- (MFrameHandle *)bottom
{
    return [self.m_delegate m_addHandleWithType:MH_BOTTOM];
}

- (MFrameHandle *)width
{
    return [self.m_delegate m_addHandleWithType:MH_WIDTH];
}

- (MFrameHandle *)height
{
    return [self.m_delegate m_addHandleWithType:MH_HEIGHT];
}

- (void (^)(NSArray *))m_equal
{
    return [self.m_delegate m_equal];
}

- (void)m_setValue:(NSNumber *)value
{
    CGFloat floatValue = value.floatValue;
    switch (self.type)
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

@end
