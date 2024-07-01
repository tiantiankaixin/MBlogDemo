//
//  MRouter+help.m
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "MRouter+help.h"

@implementation MRouter (help)

+ (UIWindow *)keyWindow {
    UIWindow *keyWindow = nil;
    // 获取当前的应用程序对象
    UIApplication *application = [UIApplication sharedApplication];
    
    // 获取所有连接的场景 (iOS 13 及以上)
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *connectedScenes = application.connectedScenes;
        for (UIScene *scene in connectedScenes) {
            // 找到活跃的前台场景
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                // 如果是 UIWindowScene 类型的场景，找到 key window
                if ([scene isKindOfClass:[UIWindowScene class]]) {
                    UIWindowScene *windowScene = (UIWindowScene *)scene;
                    for (UIWindow *window in windowScene.windows) {
                        if (window.isKeyWindow) {
                            keyWindow = window;
                            break;
                        }
                    }
                }
            }
            if (keyWindow) {
                break;
            }
        }
    } else {
        // iOS 12 及以下版本直接使用 keyWindow 属性
        keyWindow = application.keyWindow;
    }
    
    return keyWindow;
}

+ (UIViewController *)currentViewController {
    UIViewController *viewController = nil;

    // 获取当前窗口的根视图控制器
    UIViewController *rootViewController = [self keyWindow].rootViewController;

    // 找到最顶层的可见视图控制器
    viewController = [self findBestViewController:rootViewController];

    return viewController;
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // 如果存在 presentedViewController，则递归查找其最顶层的可见视图控制器
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // 如果是 UISplitViewController，则返回其最后一个视图控制器
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // 如果是 UINavigationController，则返回其栈顶视图控制器
        UINavigationController *nvc = (UINavigationController *)vc;
        if (nvc.viewControllers.count > 0) {
            return [self findBestViewController:nvc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 如果是 UITabBarController，则返回当前选中的视图控制器
        UITabBarController *tvc = (UITabBarController *)vc;
        if (tvc.viewControllers.count > 0) {
            return [self findBestViewController:tvc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        // 其他情况直接返回当前视图控制器
        return vc;
    }
}

@end
