//
//  UIView+m.m
//  iOS面试
//
//  Created by mal on 2019/4/11.
//  Copyright © 2019 mal. All rights reserved.
//

#import "UIView+m.h"

@implementation UIView (m)

- (void)m_addCornerWithTL:(CGFloat)tl tr:(CGFloat)tr bl:(CGFloat)bl br:(CGFloat)br
{
    CGSize size = self.frame.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(width - br, height - br) radius:br startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(bl, height - bl) radius:bl startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addArcWithCenter:CGPointMake(tl, tl) radius:tl startAngle:M_PI endAngle:3.0 * M_PI_2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(width - tr, tr) radius:tr startAngle:3.0 * M_PI_2 endAngle:2.0 * M_PI clockwise:YES];
    [path closePath];
    [path addClip];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.path = path.CGPath;
    self.layer.mask = masklayer;
}

@end
