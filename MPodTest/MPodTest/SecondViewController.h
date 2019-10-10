//
//  SecondViewController.h
//  MPodTest
//
//  Created by mal on 2019/10/10.
//  Copyright © 2019 mal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNGNotificationProxy.h"

@protocol MTestProtocol <NSObject>
@optional
- (void)mt_testfunc;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
