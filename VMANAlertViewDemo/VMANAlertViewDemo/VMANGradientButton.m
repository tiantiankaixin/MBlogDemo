//
//  VMANGradientButton.m
//  vman
//
//  Created by maliang on 2024/6/30.
//

#import "VMANGradientButton.h"

#define VMANHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                                              green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
                                               blue:((float)(hexValue & 0x0000FF))/255.0 \
                                              alpha:1.0]
@interface VMANGradientButton()

@property (nonatomic, strong) UIImageView *animationImageView;

/// 加载keywindow上，在loading时覆盖屏幕，阻止其它交互
@property (nonatomic, strong) UIView *coverView;

@end


@implementation VMANGradientButton

+ (nullable UIWindow *)keyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                    }
                }
            }
        }
    } else {
        //return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

- (UIImageView *)animationImageView {
    if (_animationImageView == nil) {
        _animationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnloading_22"]];
        _animationImageView.hidden = YES;
    }
    return _animationImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor clearColor];
    }
    return _coverView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self addSubview:self.animationImageView];
    self.clipsToBounds = YES;
}

//MARK: 渐变效果相关
+ (VMANGradientButton *)themeGreenBtn {
  VMANGradientButton *btn = [[VMANGradientButton alloc] init];
  NSArray *colors = @[VMANHexColor(0xD9EB52), VMANHexColor(0x9BEB52)];
  [btn setGradientBackgroundWithColors:colors locations:@[@0.0, @1.0] angle:90.0];
  return btn;
}

- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations angle:(CGFloat)angle {
  [self.gradientLayer removeFromSuperlayer];
  
  CAGradientLayer *gradientLayer = [VMANGradientButton layerWithColors:colors locations:locations angle:angle];
  gradientLayer.frame = self.bounds;
  
  // 添加渐变层
  [self.layer insertSublayer:gradientLayer below:self.imageView.layer];
  
  self.gradientLayer = gradientLayer;
}

+ (CAGradientLayer *)layerWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations angle:(CGFloat)angle {
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  
  // 设置渐变颜色
  NSMutableArray *cgColors = [NSMutableArray array];
  for (UIColor *color in colors) {
    [cgColors addObject:(__bridge id)color.CGColor];
  }
  gradientLayer.colors = cgColors;
  
  // 设置渐变位置
  gradientLayer.locations = locations;
  
  // 设置渐变角度
  CGFloat radians = angle * (M_PI / 180.0);
  CGFloat x = cos(radians);
  CGFloat y = sin(radians);
  gradientLayer.startPoint = CGPointMake(0.5 - 0.5 * x, 0.5 - 0.5 * y);
  gradientLayer.endPoint = CGPointMake(0.5 + 0.5 * x, 0.5 + 0.5 * y);
  
  return gradientLayer;
}

//MARK: - loading animation
- (void)startLoading {
    [self.animationImageView.layer removeAllAnimations];
    self.animationImageView.hidden = NO;
    self.titleLabel.alpha = 0.0;
    UIWindow *window = [VMANGradientButton keyWindow];
    self.coverView.frame = window.bounds;
    [window addSubview:self.coverView];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0); // 360 degrees
    rotationAnimation.duration = 1; // Duration of one complete rotation
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF; // Infinite loop
    [self.animationImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading {
    [self.animationImageView.layer removeAllAnimations];
    self.animationImageView.hidden = YES;
    self.titleLabel.alpha = 1.0;
    
    [self.coverView removeFromSuperview];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (CGRectGetWidth(self.gradientLayer.frame) != CGRectGetWidth(self.bounds)) {
    self.gradientLayer.frame = self.bounds;
  }
    self.animationImageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

@end
