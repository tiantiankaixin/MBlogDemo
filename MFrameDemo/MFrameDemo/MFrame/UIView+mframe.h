//
//  UIView+mframe.h
//  langrensha
//
//  Created by mal on 2017/7/29.
//  Copyright © 2017年 closure. All rights reserved.
//

#import <UIKit/UIKit.h>

//MARK: - frame布局
@interface UIView (mframe)

@property (nonatomic, assign) CGFloat m_left;
@property (nonatomic, assign) CGFloat m_right;
@property (nonatomic, assign) CGFloat m_top;
@property (nonatomic, assign) CGFloat m_bottom;
@property (nonatomic, assign) CGFloat m_width;
@property (nonatomic, assign) CGFloat m_height;
@property (nonatomic, assign) CGFloat m_centerX;
@property (nonatomic, assign) CGFloat m_centerY;

@end

//MARK: - help
@interface UIView (mhelp)

+ (UIView *)gradientViewWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame;

/**
 设置圆角
 
 @param radius 圆角大小
 */
- (void)m_setCornerRadius:(CGFloat)radius;

/**
 给view添加边框
 
 @param borderWidth 边框线条宽度(先放这里..)
 @param color 边框线条颜色
 */
- (void)m_addBorderWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

/**
 添加subview
 
 @param subViews 要添加的view数组
 */
- (void)m_addSubViews:(NSArray<UIView*> *)subViews;

@end

//MARK: - 形变
@interface UIView (mtransform)

/**
 取消view的形变属性，恢复原样
 */
- (void)m_resetTransform;

/**
 颠倒view的竖直方向
 */
- (void)m_upsidedown;

@end

//MARK: - 阴影
@interface UIView (mShadow)

@property (nonatomic, strong) UIView *m_shadowView;

- (void)m_addShadow;

@end
