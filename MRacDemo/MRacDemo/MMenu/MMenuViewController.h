//
//  MMenuViewController.h
//  MRacDemo
//
//  Created by mal on 2019/9/28.
//  Copyright © 2019 mal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMenuViewController : UITableViewController

- (void)addItems:(NSArray<MMenuItem *> *)items;
- (void)addItemWithClass:(Class)aClass title:(NSString *)title turnType:(MTurnType)type;
- (void)addItemWithClass:(Class)aClass title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
