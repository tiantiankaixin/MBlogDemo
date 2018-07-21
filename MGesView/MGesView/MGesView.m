//
//  MGesView.m
//  MGesView
//
//  Created by mal on 2018/1/18.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MGesView.h"

@implementation MGesView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self])
    {
        return nil;
    }
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    /*
     if(point在红色按钮的范围内)
     {
         return NO;
     }
     */
    return YES;
}

@end
