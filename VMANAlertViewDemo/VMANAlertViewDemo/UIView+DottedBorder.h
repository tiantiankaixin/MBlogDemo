//
//  UIView+DottedBorder.h
//  VMANAlertViewDemo
//
//  Created by mal on 8/14/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DottedBorder)

- (void)addDottedBorderWithColor:(UIColor *)color
                       lineWidth:(CGFloat)lineWidth
                     dashPattern:(NSArray<NSNumber *> *)dashPattern
                    cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
