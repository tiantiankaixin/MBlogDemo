//
//  UIView+mframe.m
//  langrensha
//
//  Created by mal on 2017/7/29.
//  Copyright © 2017年 closure. All rights reserved.
//

#import "UIView+mframe.h"
#import <objc/runtime.h>

//MARK: - frame
@implementation UIView (mframe)

- (CGFloat)m_top
{
    return self.frame.origin.y;
}

- (void)setM_top:(CGFloat)m_top
{
    CGRect frame = self.frame;
    frame.origin.y = m_top;
    self.frame = frame;
}

- (CGFloat)m_bottom
{
    return self.frame.origin.y + self.m_height;
}

- (void)setM_bottom:(CGFloat)m_bottom
{
    [self setM_top:m_bottom - self.m_height];
}

- (CGFloat)m_left
{
    return self.frame.origin.x;
}

- (void)setM_left:(CGFloat)m_left
{
    CGRect frame = self.frame;
    frame.origin.x = m_left;
    self.frame = frame;
}

- (CGFloat)m_right
{
    return self.m_left + self.m_width;
}

- (void)setM_right:(CGFloat)m_right
{
    [self setM_left:m_right - self.m_width];
}

- (CGFloat)m_width
{
    return self.frame.size.width;
}

- (void)setM_width:(CGFloat)m_width
{
    CGRect frame = self.frame;
    frame.size.width = m_width;
    self.frame = frame;
}

- (CGFloat)m_height
{
    return self.frame.size.height;
}

- (void)setM_height:(CGFloat)m_height
{
    CGRect frame = self.frame;
    frame.size.height = m_height;
    self.frame = frame;
}

- (CGFloat)m_centerX
{
    return self.center.x;
}

- (void)setM_centerX:(CGFloat)m_centerX
{
    CGPoint center = self.center;
    center.x = m_centerX;
    self.center = center;
}

- (CGFloat)m_centerY
{
    return self.center.y;
}

- (void)setM_centerY:(CGFloat)m_centerY
{
    CGPoint center = self.center;
    center.y = m_centerY;
    self.center = center;
}

@end

//MARK: - help
@implementation UIView(mhelp)

+ (UIView *)gradientViewWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame
{
    UIView *gradientView = [[UIView alloc] initWithFrame:frame];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    [gradientView.layer addSublayer:gradient];
    gradient.colors = colors;
    gradient.locations = locations;
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    return gradientView;
}

- (void)m_setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)m_addBorderWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.masksToBounds = YES;
}

- (void)m_addSubViews:(NSArray<UIView *> *)subViews
{
    for (UIView *subView in subViews)
    {
        if (![subView isDescendantOfView:self])
        {
            [self addSubview:subView];
        }
    }
}

@end

@implementation UIView(mtransform)

- (void)m_resetTransform
{
    self.transform = CGAffineTransformIdentity;
}

- (void)m_upsidedown
{
    self.transform = CGAffineTransformMakeRotation(M_PI);
}

@end

//MARK: - shadow
#define mRGBToAlpColor(rgb, alp) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 green:((float)((rgb & 0xFF00) >> 8)) / 255.0 blue:((float)(rgb & 0xFF)) / 255.0 alpha:alp]

@implementation UIView (mShadow)

- (void)m_addShadow
{
    UIView *superView = self.superview;
    if (superView && !self.m_shadowView)
    {
        UIView *shadowView = [self shadowViewWithFrame:self.frame shadowColor:mRGBToAlpColor(0x000000, 0.07) shadowOffset:CGSizeMake(0, 1) shadowOpacity:0.7 shadowRadius:3.0];
        [superView insertSubview:shadowView belowSubview:self];
        [self setM_shadowView:shadowView];
    }
    self.m_shadowView.frame = self.frame;
}

- (UIView *)shadowViewWithFrame:(CGRect)rect shadowColor:(UIColor *)color shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius
{
    UIView *shadowView = [[UIView alloc] initWithFrame:rect];
    shadowView.layer.shadowColor = color.CGColor;
    shadowView.layer.shadowOffset = shadowOffset;
    shadowView.layer.shadowOpacity =opacity;
    shadowView.layer.shadowRadius = radius;
    shadowView.backgroundColor = [UIColor whiteColor];
    return shadowView;
}

//MARK: - -----------------get & set
- (UIView *)m_shadowView
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setM_shadowView:(UIView *)m_shadowView
{
    objc_setAssociatedObject(self, @selector(m_shadowView), m_shadowView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

