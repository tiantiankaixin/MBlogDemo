//
//  MRouter.m
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "MRouter.h"
#import <objc/runtime.h>

static MRouter *router = nil;

@interface MRouter ()

@property (nonatomic, strong) NSMutableDictionary *targetDict;

@end

@implementation MRouter

//MARK: getter/setter
- (NSMutableDictionary *)targetDict {
    if (_targetDict == nil) {
        _targetDict = [NSMutableDictionary dictionary];
    }
    return _targetDict;
}

//MARK: public
+ (MRouter *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[MRouter alloc] init];
    });
    return router;
}

+ (void)bindTarget:(NSString *)targetClassStr withKey:(NSString *)key {
    if (!targetClassStr || targetClassStr.length == 0) {
        NSString *remind = [NSString stringWithFormat:@"MRouter target=nil key = %@", key];
        NSAssert(YES, remind);
        return;
    } else if (!key || key.length == 0) {
        NSString *remind = [NSString stringWithFormat:@"MRouter key=null target = %@", targetClassStr];
        NSAssert(YES, remind);
        return;
    }
    id isExist = MRouter.share.targetDict[key];
    if (isExist) {
        NSString *remind = [NSString stringWithFormat:@"MRouter key = %@ 对应的目标已存在 old = %@ new = %@", key, isExist, targetClassStr];
        NSAssert(YES, remind);
        return;
    }
    [[MRouter share].targetDict setObject:targetClassStr forKey:key];
}

+ (id<MRouterProtocol>)targetWithUrl:(NSString *)urlString {
    if (!urlString || urlString.length == 0) {
        MRouterLog(@"%@", [NSString stringWithFormat:@"url为空"]);
        return  nil;
    }
    id<MRouterProtocol> target = nil;
    MRouterLog(@"要打开的链接是 %@", urlString);
    
    // 创建 NSURL 对象
    NSURL *url = [NSURL URLWithString:urlString];
    if (url == nil) {
        MRouterLog(@"%@ 不符合url规范", urlString);
        return nil;
    }

    // 解析并获取各个部分
    NSString *scheme = url.scheme; // 获取 scheme，例如 "https"
    NSString *host = url.host;     // 获取 host，例如 "www.example.com"
    NSString *path = url.path;     // 获取 path，例如 "/path/to/resource"

    // 获取参数部分
    NSString *query = url.query;   // 获取参数部分，例如 "param1=value1&param2=value2"

    // 将参数部分解析成字典
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count == 2) {
            NSString *key = elements[0];
            NSString *value = elements[1];
            // 解码 URL 编码的值
            NSString *decodedValue = [value stringByRemovingPercentEncoding];
            // 存入字典
            parameters[key] = decodedValue;
        }
    }

    // 打印结果
    MRouterLog(@"Scheme: %@", scheme);
    MRouterLog(@"Host: %@", host);
    MRouterLog(@"Path: %@", path);
    MRouterLog(@"Parameters: %@", parameters);
    
    NSString *key = host;
    if (path.length > 0) {
        key = [NSString stringWithFormat:@"%@%@", host, path];
    }
    NSString *targetClassStr = [MRouter share].targetDict[key];
    Class<MRouterProtocol> targetClass = NSClassFromString(targetClassStr);
    if (class_conformsToProtocol(targetClass, @protocol(MRouterProtocol))) {
        target = [targetClass createWithParam: parameters];
    } else {
        MRouterLog(@"%@没有遵循MRouterProtocol协议", targetClassStr);
        return nil;
    }
    if (target == nil) {
        MRouterLog(@"无法找到%@ 对应的target", urlString);
    } else if ([target isKindOfClass:[MRouterEmptyTarget class]]) {
        MRouterLog(@"%@ 执行自定义操作了", urlString);
        target = nil;
    }
    return target;
}

@end

@implementation MRouterEmptyTarget

+ (id<MRouterProtocol>)createWithParam:(NSDictionary *)param {
    return nil;
}

- (BOOL)needLogin {
    return NO;
}

- (MRouterOpenType)openType {
    return MRouter_push;
}

@end
