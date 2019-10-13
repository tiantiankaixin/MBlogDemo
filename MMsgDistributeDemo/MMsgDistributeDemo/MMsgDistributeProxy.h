//
//  MMsgDistributeProxy.h
//  MMsgDistributeDemo
//
//  Created by mal on 2019/9/16.
//  Copyright © 2019 mal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMsgDistributeProxy;

NS_ASSUME_NONNULL_BEGIN

/**
 创建消息转发proxy 注意循环引用

 @param firstObj obj
 @param ... obj
 @return proxy
 */
extern MMsgDistributeProxy *m_distributeProxy(id firstObj, ...);

@interface MMsgDistributeProxy : NSProxy

@property (nonatomic, strong, readonly) NSMutableArray *proxyQueue;

- (instancetype)initWith:(NSArray *)targets;
- (void)m_addMsgProxy:(id)proxy;

@end

NS_ASSUME_NONNULL_END
