//
//  VMANVoicePopListView.h
//  VMANPreloaderDemo
//
//  Created by mal on 8/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMANVoicePopListView : UIView

@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) void (^itemSelectedBlock)(NSString *selectedItem);

+ (void)showWithBelowView:(UIView *)belowView dataSource:(NSArray *)dataSource selectBlock:(void(^)(NSString *))selectBlock;

NS_ASSUME_NONNULL_END

@end
