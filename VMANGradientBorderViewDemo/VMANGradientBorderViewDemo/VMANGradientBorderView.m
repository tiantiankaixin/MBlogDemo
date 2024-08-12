//
//  VMANGradientBorderView.m
//  VMANGradientBorderViewDemo
//
//  Created by mal on 8/12/24.
//

#import "VMANGradientBorderView.h"

@interface VMANGradientBorderView()

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) CAGradientLayer *gradientlayer;

@end

@implementation VMANGradientBorderView

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
    }
    return _coverView;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.coverView.backgroundColor = backgroundColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self layoutSubviews];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.gradientlayer.cornerRadius = cornerRadius;
    self.coverView.layer.cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    [self.layer masksToBounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGradientBorder];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupGradientBorder];
}

- (void)setupGradientBorder {
    [self addSubview:self.coverView];
    
    // 创建CAGradientLayer作为边框
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.colors = @[(id)[UIColor.redColor CGColor], (id)[UIColor.blueColor CGColor]]; // 渐变色数组
    self.gradientlayer = gradientLayer;
    [self.layer insertSublayer:gradientLayer below:self.coverView.layer];
    
    self.borderWidth = 1;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientlayer.frame = self.bounds;
    CGFloat coverViewWidth = CGRectGetWidth(self.bounds) - self.borderWidth * 2;
    CGFloat coverViewHeight = CGRectGetHeight(self.bounds) - self.borderWidth * 2;
    self.coverView.frame = CGRectMake(self.borderWidth, self.borderWidth, coverViewWidth, coverViewHeight);
}

@end
