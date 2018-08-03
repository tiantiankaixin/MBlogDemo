//
//  MTableViewController.m
//  MRunloopDemo
//
//  Created by mal on 2018/7/21.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MTableViewController.h"
#import "SMKtvMsgQueue.h"

@interface MTableViewController ()<UITableViewDataSource,UITableViewDelegate,SMKtvMsgQueueDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSTimer *createMsgTimer;
@property (nonatomic, strong) SMKtvMsgQueue *msgQueue;
@property (nonatomic, assign) BOOL currentIsInBottom;

@end

@implementation MTableViewController

//MARK: - -----------------get & set
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (SMKtvMsgQueue *)msgQueue
{
    if (_msgQueue == nil)
    {
        _msgQueue = [SMKtvMsgQueue queueWithDelegate:self];
    }
    return _msgQueue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    [self startCreateMsgs];
    //[self addRunloopObserver];
}

- (void)setUpView
{
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)startCreateMsgs
{
    self.createMsgTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(createMsgs) userInfo:nil repeats:YES];
}

- (void)createMsgs
{
    sm_runInMainQueue(^{
        
        static NSInteger loc = 0;
        for (int i = 0; i < 50; i++)
        {
            loc++;
            NSString *str = [NSString stringWithFormat:@"%ld",(long)loc];
            [self.msgQueue sm_insertMsgs:@[str]];
        }
    });
}

//MARK: UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *text = self.dataSource[indexPath.row];
    cell.textLabel.text = text;
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height)
    {
        //在最底部
        self.currentIsInBottom = YES;
    }
    else
    {
        self.currentIsInBottom = NO;
    }
}


 - (void)sm_popMsgs:(NSArray *)msgs
{
    sm_runInMainQueue(^{

        if ([msgs count] > 0)
        {
            NSInteger loc = self.dataSource.count;
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (int i = 0; i < msgs.count; i++)
            {
                NSIndexPath *path = [NSIndexPath indexPathForRow:loc + i inSection:0];
                [indexPaths addObject:path];
            }
            [self.dataSource addObjectsFromArray:msgs];
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [self.tableview insertRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationNone)];
            [CATransaction commit];
            if ([self currentIsInBottom])
            {
                 [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
            }
        }
    });
}

- (void)addRunloopObserver
{
    CFRunLoopRef runloopRef = CFRunLoopGetCurrent();
    CFRunLoopActivity activity = kCFRunLoopBeforeWaiting;
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), activity, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {

        if (activity == kCFRunLoopBeforeWaiting)
        {
            NSLog(@"kCFRunLoopBeforeWaiting");
        }
    });
    CFRunLoopAddObserver(runloopRef, observerRef, kCFRunLoopDefaultMode);
}

- (void)dealloc
{
    [self.msgQueue releaseQueue];
}

void sm_runInMainQueue(dispatch_block_t block)
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@end


