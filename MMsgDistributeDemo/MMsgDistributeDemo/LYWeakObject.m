//
//  LYWeakObject.m
//  LYDispatchProxy
//
//  Created by Liya on 2018/7/14.
//  Copyright © 2018年 Liya. All rights reserved.
//

#import "LYWeakObject.h"

LYWeakObject *ly_weakObject(id obj) {
    if (obj == nil) {
        return nil;
    }
    return [LYWeakObject weakObject:obj];
}

@interface LYWeakObject()
@property (nonatomic, weak) id obj;
@end

@implementation LYWeakObject

+ (id)weakObject:(id)obj {
    LYWeakObject *wObj = [[LYWeakObject alloc] init];
    wObj.obj = obj;
    return wObj;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    id obj = self.obj;
    if (obj) {
        return [obj methodSignatureForSelector:sel];
    }
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    id obj = self.obj;
    if (obj) {
        [invocation invokeWithTarget:obj];
    } else {
        [invocation setReturnValue:&obj];
    }
}

- (BOOL)isKindOfClass:(Class)aClass {
    id obj = self.obj;
    if (obj) {
        return [obj isKindOfClass:aClass];
    }
    return NO;
}

- (BOOL)isMemberOfClass:(Class)aClass {
    id obj = self.obj;
    if (obj) {
        return [obj isMemberOfClass:aClass];
    }
    return NO;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    id obj = self.obj;
    if (obj) {
        return [obj respondsToSelector:aSelector];
    }
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    id obj = self.obj;
    if (obj) {
        return [obj conformsToProtocol:aProtocol];
    }
    return NO;
}

- (NSString *)description {
    id obj = self.obj;
    if (obj) {
        return [obj description];
    }
    return @"LYWeakObject";
}

- (NSString *)debugDescription {
    id obj = self.obj;
    if (obj) {
        return [obj debugDescription];
    }
    return @"LYWeakObject";
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.obj;
}

@end


