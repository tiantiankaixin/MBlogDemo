//
//  MTableViewController.m
//  MRunloopDemo
//
//  Created by mal on 2018/7/21.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MTableViewController.h"

@interface MTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpDataSource];
    [self setUpView];
    [self setUpRunloop];
}

- (void)setUpView
{
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setUpRunloop
{
    [self addRunloopObserver];
}

- (void)setUpDataSource
{
    
}

//MARK: UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

//MARK: runloop
- (void)addRunloopObserver
{
    CFRunLoopRef runloopRef = CFRunLoopGetCurrent();
    CFRunLoopActivity activity = kCFRunLoopBeforeWaiting;
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), activity, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSLog(@"kkkk");
    });
    CFRunLoopAddObserver(runloopRef, observerRef, kCFRunLoopDefaultMode);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
