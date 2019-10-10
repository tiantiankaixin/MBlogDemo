//
//  MMenuViewController.m
//  MRacDemo
//
//  Created by mal on 2019/9/28.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MMenuViewController.h"

#define MCellIdentifier @"MCellIdentifier"

@interface MMenuViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MMenuViewController

//MARK: - get & set
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

//- (UITableView *)tableView
//{
//    if (_tableView) {
//        <#statements#>
//    }
//}

//MARK: - public method
- (void)addItemWithClass:(Class)aClass title:(NSString *)title turnType:(MTurnType)type
{
    [self.dataSource addObject:[MMenuItem itemWithClass:aClass title:title turnType:type]];
}

- (void)addItemWithClass:(Class)aClass title:(NSString *)title
{
    [self addItemWithClass:aClass title:title turnType:M_Push];
}

- (void)addItems:(NSArray<MMenuItem *> *)items
{
    [self.dataSource addObjectsFromArray:items];
}

//MARK: - system method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
}

//MARK: - UI
- (void)setUpView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MCellIdentifier];
}

//MARK: - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MCellIdentifier];
    cell.textLabel.text = [self.dataSource[indexPath.row] itemTitle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMenuItem *item = self.dataSource[indexPath.row];
    id obj = [[item.itemClass alloc] init];
    if ([obj isKindOfClass:[UIViewController class]])
    {
        UIViewController *vc = (UIViewController *)obj;
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.title = item.itemTitle;
        if (item.turnType == M_Push)
        {
            if (self.navigationController)
            {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else if (item.turnType == M_Present)
        {
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

@end
