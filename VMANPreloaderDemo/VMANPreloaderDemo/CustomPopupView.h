//
//  CustomPopupView.h
//  VMANPreloaderDemo
//
//  Created by maliang on 2024/7/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomPopupView : UIView

@property (nonatomic, strong) UIButton *item1Button;
@property (nonatomic, strong) UIButton *item2Button;

- (void)showInView:(UIView *)view belowButton:(UIButton *)button withOffset:(CGFloat)offset;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
