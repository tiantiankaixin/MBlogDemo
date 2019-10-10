//
//  XNGNotificationProxy.h
//  XNGNotificationProxy
//
//  Created by XuNing on 2019/1/22.
//  Copyright © 2019 xuning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XNGNotificationProxy : NSProxy

+ (instancetype)sharedProxy;

- (void)registerProtocol:(Protocol *)protocol forObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
