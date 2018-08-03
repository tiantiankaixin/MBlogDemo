//
//  SMKtvMsgQueue.m
//  MRunloopDemo
//
//  Created by mal on 2018/8/3.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "SMKtvMsgQueue.h"

static dispatch_queue_t ioQueue = nil;
static const NSTimeInterval KPopMsgInterval = 0.5;
static const NSInteger KPopMaxNo = 10;

@interface SMKtvMsgQueue()

@property (nonatomic, strong) NSMutableArray *msgQueue;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SMKtvMsgQueue

//MARK: - -----------------get & set
- (NSMutableArray *)msgQueue
{
    if (_msgQueue == nil)
    {
        _msgQueue = [NSMutableArray array];
    }
    return _msgQueue;
}

//MARK: - -----------------public func
//MARK: init queue
+ (SMKtvMsgQueue *)queueWithDelegate:(id<SMKtvMsgQueueDelegate>)delegate
{
    SMKtvMsgQueue *queue = [[SMKtvMsgQueue alloc] init];
    queue.m_delegate = delegate;
    [queue startTimer];
    return queue;
}

//MARK: release queue
- (void)releaseQueue
{
    [self endTimer];
    ioQueue = nil;
}

//MARK: insert msgs
- (void)sm_insertMsgs:(NSArray *)msgs
{
    sm_runInIoQueue(^{
       
        [self.msgQueue addObjectsFromArray:msgs];
    });
}

//MARK: - -----------------private func
//MARK: pop msgs
- (void)startTimer
{
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:KPopMsgInterval target:self selector:@selector(popMsgs) userInfo:nil repeats:YES];
    }
}

- (void)endTimer
{
    if ([self.timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (NSArray *)popMsgsWithNo:(NSInteger)no
{
    NSArray *popMsgs = nil;
    if (self.msgQueue.count < no)
    {
        popMsgs = [NSArray arrayWithArray:self.msgQueue];
        [self.msgQueue removeAllObjects];
    }
    else
    {
        popMsgs = [self.msgQueue subarrayWithRange:NSMakeRange(0, no)];
        [self.msgQueue removeObjectsInArray:popMsgs];
    }
    return popMsgs;
}

- (void)popMsgs
{
    sm_runInIoQueue(^{
        
        if ([self.m_delegate respondsToSelector:@selector(sm_popMsgs:)])
        {
            [self.m_delegate sm_popMsgs:[self popMsgsWithNo:KPopMaxNo]];
        }
    });
}

//MARK: - help
void sm_runInIoQueue(dispatch_block_t block)
{
    if (!ioQueue)
    {
        ioQueue = dispatch_queue_create("com.starMaker.SMKtvMessagePool", DISPATCH_QUEUE_SERIAL);
    }
    dispatch_async(ioQueue, block);
    //dispatch_async(dispatch_get_main_queue(), block);
}

@end
