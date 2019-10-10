//
//  EXGlobalSingleton.h
//  Extra
//
//  Created by mal on 16/9/6.
//  Copyright © 2016年 Haowai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define CHSingle [CHGlobalSingleton sharedInstance]

@interface CHGlobalSingleton : NSObject

/** 网络状态 */
@property (nonatomic, assign) NetworkStatus netStatus;

/**
 *  全局单例
 *
 *  @return 全局单例对象
 */
+ (CHGlobalSingleton *)sharedInstance;

/**
 开启网络监控
 */
+ (void)startNetMonitoring;
+ (void)stopNetMonitoring;
+ (BOOL)isMobileNetWork;

@end
