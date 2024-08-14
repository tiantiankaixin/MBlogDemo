//
//  VMANGradientButton.h
//  vman
//
//  Created by maliang on 2024/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMANGradientButton : UIButton

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations angle:(CGFloat)angle;

/// 项目里黄绿渐变的按钮
+ (VMANGradientButton *)themeGreenBtn;
+ (CAGradientLayer *)layerWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations angle:(CGFloat)angle;

- (void)startLoading;
- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
