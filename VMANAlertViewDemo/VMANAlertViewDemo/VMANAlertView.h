//
//  VMANAlertView.h
//  VMANAlertViewDemo
//
//  Created by mal on 8/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMANAlertView : UIView

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, copy) void (^buttonActionHandler)(NSInteger buttonIndex);

- (instancetype)initWithTitle:(NSString *)title
                  buttonTitles:(NSArray<NSString *> *)buttonTitles;

- (void)show;

@end

NS_ASSUME_NONNULL_END
