//
//  MRouterManager.h
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "MRouter+help.h"

NS_ASSUME_NONNULL_BEGIN

@interface MRouterManager : NSObject

/// 应用启动完成后再进行路由跳转
///（eg：比如有开屏广告，要等开屏结束进入主页后才可以跳转）
/// 调用路由后如果appLaunchFinish=NO，会将链接保存，等appLaunchFinish为YES后自动打开链接
@property (nonatomic, assign) BOOL appLaunchFinish;

+ (MRouterManager *)share;

/// 绑定跳转对象和url
- (void)bindTargetWithUrls;

/// 打开目标链接
+ (void)openWithUrlStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
