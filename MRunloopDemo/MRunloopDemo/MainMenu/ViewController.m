//
//  ViewController.m
//  MRunloopDemo
//
//  Created by mal on 2018/7/19.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import "MitemModel.h"
#import "MTableViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <MitemModel*>*dataSource;

@end

@implementation ViewController

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
    [self addItems];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)addItems
{
    [self.dataSource addObject:[MitemModel modelWithClassName:NSStringFromClass([MTableViewController class]) itemTitle:@"table"]];
}

//MARK: UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    MitemModel *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.itemTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MitemModel *item = self.dataSource[indexPath.row];
    Class vcClass = NSClassFromString(item.className);
    UIViewController *vc = [[vcClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
