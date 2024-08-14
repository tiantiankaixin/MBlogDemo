//
//  UIView+DottedBorder.m
//  VMANAlertViewDemo
//
//  Created by mal on 8/14/24.
//

#import "UIView+DottedBorder.h"

@implementation UIView (DottedBorder)

- (void)addDottedBorderWithColor:(UIColor *)color
                       lineWidth:(CGFloat)lineWidth
                     dashPattern:(NSArray<NSNumber *> *)dashPattern
                     cornerRadius:(CGFloat)cornerRadius {
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    
    // 设置带圆角的矩形路径作为边框
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.lineWidth = lineWidth;
    borderLayer.lineDashPattern = dashPattern;
    
    // 确保边框图层在视图的边界框内
    borderLayer.frame = self.bounds;
    borderLayer.cornerRadius = cornerRadius;
    
    // 删除已有的虚线边框，防止重复添加
    [self removeDottedBorder];
    
    // 将边框图层添加到视图的图层上
    [self.layer addSublayer:borderLayer];
}

- (void)removeDottedBorder {
    for (CAShapeLayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
}

@end
