//
//  MRouter.h
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef DEBUG
#define MRouterLog(format, ...) NSLog((@"MRouterLog: " format), ##__VA_ARGS__)
#else
#endif

typedef NS_ENUM(NSInteger, MRouterOpenType) {
    MRouter_push,
    MRouter_present
};

@protocol MRouterProtocol <NSObject>

+ (id<MRouterProtocol>)createWithParam:(NSDictionary *)param;
- (MRouterOpenType)openType;
- (BOOL)needLogin;

@end

@interface MRouter : NSObject

+ (MRouter *)share;

/// 绑定跳转目标
/// - Parameters:
///   - targetClassStr: 跳转目标类字符串（目标类需遵循MRouterProtocol）
///   - key: 跳转目标对应的key（host + path拼接）
+ (void)bindTarget:(NSString *)targetClassStr withKey:(NSString *)key;

/// 获取跳转目标
/// - Parameter urlString: 跳转链接url
+ (id<MRouterProtocol>)targetWithUrl:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END


@interface MRouterEmptyTarget : NSObject <MRouterProtocol>

@end
