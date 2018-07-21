//
//  MLClickTimeBtn.h
//  MGesView
//
//  Created by mal on 2018/7/11.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLClickTimeBtn : UIButton

/**
 按钮点击间隔时长
 */
@property (nonatomic, assign) NSTimeInterval clickInterVal;

/**
 点击检测 YES可以点击

 @return Bool
 */
- (BOOL)clickCheck;

@end
