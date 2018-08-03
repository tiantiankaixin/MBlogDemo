//
//  SMKtvMsgQueue.h
//  MRunloopDemo
//
//  Created by mal on 2018/8/3.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMKtvMsgQueueDelegate<NSObject>

- (void)sm_popMsgs:(NSArray *)msgs;

@end

@interface SMKtvMsgQueue : NSObject

@property (nonatomic, weak) id<SMKtvMsgQueueDelegate> m_delegate;

+ (SMKtvMsgQueue *)queueWithDelegate:(id<SMKtvMsgQueueDelegate>)delegate;
- (void)releaseQueue;
- (void)sm_insertMsgs:(NSArray *)msgs;

@end
