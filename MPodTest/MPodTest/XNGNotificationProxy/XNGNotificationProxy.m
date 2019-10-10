//
//  XNGNotificationProxy.m
//  XNGNotificationProxy
//
//  Created by XuNing on 2019/1/22.
//  Copyright © 2019 xuning. All rights reserved.
//

#import "XNGNotificationProxy.h"
#import <objc/runtime.h>

@interface XNGNotificationProxy ()
// { method1: [obj1, obj2], method2: [obj3, obj4], ... }
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSHashTable *> *methodDictionary;
// for self.methodDictionary thread safty
@property(nonatomic, strong) dispatch_queue_t modificationQueue;
@end

@implementation XNGNotificationProxy

+ (instancetype)sharedProxy {
    static XNGNotificationProxy *proxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxy = [XNGNotificationProxy alloc];
        proxy.methodDictionary = [NSMutableDictionary dictionary];
        proxy.modificationQueue = dispatch_queue_create("com.notificationProxy.modification", DISPATCH_QUEUE_SERIAL);
    });
    return proxy;
}

- (void)registerProtocol:(Protocol *)protocol forObject:(id)obj {
    NSParameterAssert(protocol);
    NSParameterAssert(obj);
    NSAssert([obj conformsToProtocol:protocol], @"object %@ does not conform to protocol: %@", obj, protocol);
    NSArray *methodNames = [XNGNotificationProxy getAllMethodNamesInProtocol:protocol];
    for (NSString *name in methodNames) {
        dispatch_sync(self.modificationQueue, ^{
            NSHashTable *hashTable = self.methodDictionary[name];
            if (!hashTable.anyObject) {
                hashTable = [NSHashTable weakObjectsHashTable];
            }
            [hashTable addObject:obj];
            self.methodDictionary[name] = hashTable;
        });
    }
}

#pragma mark - Override Method
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    for (id obj in [self objectsInHashTableForSelector:sel]) {
        if ([obj respondsToSelector:sel]) {
            return [obj methodSignatureForSelector:sel];
        }
    }
    // if this method returns nil, a selector not found exception is raised.
    // https://github.com/facebookarchive/AsyncDisplayKit/pull/1562
    return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    for (id obj in [self objectsInHashTableForSelector:invocation.selector]) {
        if ([obj respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:obj];
        }
    }
}

#pragma mark - Private Method
- (NSArray *)objectsInHashTableForSelector:(SEL)sel {
    __block NSArray *objects;
    dispatch_sync(self.modificationQueue, ^{
        objects = self.methodDictionary[NSStringFromSelector(sel)].allObjects;
    });
    return objects;
}

+ (void)enumerateMethodsInProtocol:(Protocol *)protocol
                        isRequired:(BOOL)isRequired
                        usingBlock:(void (^)(struct objc_method_description method))block {
    unsigned int methodsCountInProtocol = 0;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(protocol, isRequired, YES, &methodsCountInProtocol);
    for (unsigned int i = 0; i < methodsCountInProtocol; i++) {
        struct objc_method_description method = methods[i];
        !block ?: block(method);
    }
    free(methods);
}

+ (NSArray *)getAllMethodNamesInProtocol:(Protocol *)protocol {
    NSMutableArray *methodNames = [NSMutableArray array];
    [self enumerateMethodsInProtocol:protocol
                          isRequired:YES
                          usingBlock:^(struct objc_method_description method) {
                              [methodNames addObject:NSStringFromSelector(method.name)];
                          }];
    [self enumerateMethodsInProtocol:protocol
                          isRequired:NO
                          usingBlock:^(struct objc_method_description method) {
                              [methodNames addObject:NSStringFromSelector(method.name)];
                          }];
    return [methodNames copy];
}

@end
