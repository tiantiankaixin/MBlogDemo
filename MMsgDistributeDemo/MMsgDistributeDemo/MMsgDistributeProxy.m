//
//  MMsgDistributeProxy.m
//  MMsgDistributeDemo
//
//  Created by mal on 2019/9/16.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MMsgDistributeProxy.h"

MMsgDistributeProxy *m_distributeProxy(id firstObj, ...)
{
    NSMutableArray *targets = [NSMutableArray array];
    id obj;
    va_list arg_list;
    va_start(arg_list, firstObj);
    if (firstObj)
    {
        [targets addObject:firstObj];
        while ((obj = va_arg(arg_list, id)))
        {
            [targets addObject:obj];
        }
    }
    va_end(arg_list);
    if (targets.count == 0)
    {
        return nil;
    }
    return [[MMsgDistributeProxy alloc] initWith:targets];
}

@implementation MMsgDistributeProxy
@synthesize proxyQueue = _proxyQueue;

- (instancetype)initWith:(NSArray *)targets
{
    _proxyQueue = [NSMutableArray arrayWithArray:targets];
    return self;
}

- (NSMutableArray *)proxyQueue
{
    if (_proxyQueue == nil)
    {
        _proxyQueue = [NSMutableArray array];
    }
    return _proxyQueue;
}

- (void)m_addMsgProxy:(id)proxy
{
    if (proxy)
    {
        [self.proxyQueue addObject:proxy];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    for (id obj in self.proxyQueue)
    {
        if ([obj respondsToSelector:aSelector])
        {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    for (id obj in self.proxyQueue)
    {
        if ([obj respondsToSelector:sel])
        {
            return [obj methodSignatureForSelector:sel];
        }
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    for (id obj in self.proxyQueue)
    {
        if ([obj respondsToSelector:invocation.selector])
        {
            [invocation invokeWithTarget:obj];
        }
    }
}

- (void)dealloc
{
    NSLog(@"MMsgDistrbuteProxy dealloc");
    [self.proxyQueue removeAllObjects];
}

@end
