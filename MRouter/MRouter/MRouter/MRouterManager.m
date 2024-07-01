//
//  MRouterManager.m
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "MRouterManager.h"
#import "TestViewController.h"

static MRouterManager *manager = nil;

@interface MRouterManager ()

/// 存储延迟打开的链接
@property (nonatomic, copy) NSString *delayOpenUrl;

@end

@implementation MRouterManager

- (void)setAppLaunchFinish:(BOOL)appLaunchFinish {
    _appLaunchFinish = appLaunchFinish;
    if (appLaunchFinish && _delayOpenUrl.length > 0) {
        [MRouterManager openWithUrlStr:_delayOpenUrl];
        _delayOpenUrl = nil;
    }
}

+ (MRouterManager *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MRouterManager alloc] init];
        manager.appLaunchFinish = NO;
    });
    return manager;
}

//MARK: 绑定url(host+path)和跳转目标
- (void)bindTargetWithUrls {
    [MRouter bindTarget:NSStringFromClass([TestViewController class]) withKey:@"testHost/testPath"];
    MRouterLog(@"路由绑定完成");
}

+ (void)openWithUrlStr:(NSString *)urlStr {
    if (!urlStr || urlStr.length == 0) {
        MRouterLog(@"openWithUrlStr为空");
        return;
    }
    if ([self share].appLaunchFinish == NO) {
        MRouterLog(@"应用尚未启动完成，延迟打开 %@", urlStr);
        [self share].delayOpenUrl = urlStr;
        return;
    }
    
    id<MRouterProtocol> target = [MRouter targetWithUrl:urlStr];
    if (target != nil) {
        BOOL needLogin = [target needLogin];
        MRouterOpenType openType = [target openType];
        UIViewController *page = (UIViewController *)target;
        if ([page isKindOfClass:[UIViewController class]]) {
            BOOL isSuccess = [self openVC:page needLogin:needLogin openType:openType];
            if (isSuccess) {
                MRouterLog(@"打开 %@ 成功", urlStr);
            } else {
                MRouterLog(@"打开 %@ 失败", urlStr);
            }
        } else {
            //...
        }
    }
}

+ (BOOL)openVC:(UIViewController *)page needLogin:(BOOL)needLogin openType:(MRouterOpenType)openType {
    NSString *openTypeStr = (openType == MRouter_push) ? @"push" : @"present";
    MRouterLog(@"%@ 打开%@ needLogin=%d", openTypeStr, NSStringFromClass(page.class), needLogin);
    UIViewController *currentVC = [MRouter currentViewController];
    if (currentVC == nil) {
        MRouterLog(@"打开页面失败，无法获得当前控制器");
        return NO;
    }
    if (needLogin) {
        //处理登录逻辑
    } else {
        if (openType == MRouter_push) {
            UINavigationController *navi = currentVC.navigationController;
            if (navi == nil) {
                MRouterLog(@"打开页面失败，无法获得导航控制器，当前vc=%@", NSStringFromClass(currentVC.class));
                return NO;
            }
            [navi pushViewController:page animated:YES];
        } else {
            page.modalPresentationStyle = UIModalPresentationFullScreen;
            [currentVC presentViewController:page animated:YES completion:nil];
        }
    }
    return YES;
}

@end
