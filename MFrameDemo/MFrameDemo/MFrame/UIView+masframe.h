//
//  UIView+masframe.h
//  MFrameDemo
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (masframe)

- (UIView *)left;
- (UIView *)right;
- (UIView *)top;
- (UIView *)bottom;
- (UIView *)width;
- (UIView *)height;

- (void(^)(NSArray *))m_equal;

@end
