//
//  MRouter+help.h
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "MRouter.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRouter (help)

+ (UIWindow *)keyWindow;
+ (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
