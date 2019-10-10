//
//  EXGlobalSingleton.m
//  Extra
//
//  Created by mal on 16/9/6.
//  Copyright © 2016年 Haowai. All rights reserved.
//

#import "CHGlobalSingleton.h"

static CHGlobalSingleton * globalSharedInstance = nil;

@interface CHGlobalSingleton()

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation CHGlobalSingleton

#pragma mark - getter
/**
 *  全局单例
 *
 *  @return 全局单例对象
 */
+ (CHGlobalSingleton *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalSharedInstance = [[CHGlobalSingleton alloc] init];
        globalSharedInstance.netStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    });
    return globalSharedInstance;
}

#pragma mark - 网络监控
- (Reachability *)reachability
{
    if (_reachability == nil)
    {
        _reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    }
    return _reachability;
}

+ (void)startNetMonitoring
{
    //添加一个系统通知
    [[NSNotificationCenter defaultCenter] addObserver:CHSingle selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //通知添加到Run Loop
    [CHSingle.reachability startNotifier];
}

+ (void)stopNetMonitoring
{
    [CHSingle.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    self.netStatus = [curReach currentReachabilityStatus];
    switch (self.netStatus)
    {
        case NotReachable:
        {
            NSLog(@"断网了");
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"现在连接的是wifi");
            break;
        }
        case kReachableVia2G:
        {
            NSLog(@"现在连接的是2G");
            break;
        }
        case kReachableVia3G:
        {
            NSLog(@"现在连接的是3G");
            break;
        }
        case kReachableVia4G:
        {
            NSLog(@"现在连接的是4G");
            break;
        }
            
        default:
            NSLog(@"未知网络连接");
            break;
    }
}

+ (BOOL)isMobileNetWork
{
    NetworkStatus status = CHSingle.netStatus;
    if(status == ReachableViaWiFi || status == NotReachable){
        
        return NO;
    }
    return YES;
}

@end
