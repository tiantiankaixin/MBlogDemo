//
//  ViewController.m
//  MALRefreshDemo
//
//  Created by mal on 8/9/24.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据源和页码
    self.dataArray = [NSMutableArray array];
    self.pageIndex = 1;
    
    // 创建 UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
    // 设置上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    // 初始加载数据
    [self loadData];
}

#pragma mark - Load Data

- (void)loadData {
    // 模拟下拉刷新加载数据
    [self.dataArray removeAllObjects];
    for (int i = 1; i <= 10; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"Data %d", i]];
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    self.pageIndex = 1;
}

- (void)refreshData {
    // 模拟下拉刷新加载数据
    [self.dataArray removeAllObjects];
    for (int i = 1; i <= 10; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"Data %d", i]];
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    self.pageIndex = 1;
}

- (void)loadMoreData {
    // 模拟上拉加载更多数据
    NSMutableArray *additionalData = [NSMutableArray array];
    for (int i = 1; i <= 10; i++) {
        [additionalData addObject:[NSString stringWithFormat:@"Data %ld", self.dataArray.count + i]];
    }
    [self.dataArray addObjectsFromArray:additionalData];
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
    self.pageIndex++;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


@end
