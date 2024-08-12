//
//  ViewController.m
//  VMANPreloaderDemo
//
//  Created by maliang on 2024/7/5.
//

#import "ViewController.h"
#import "VMANVoicePopListView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionHeaderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    if (@available(iOS 15.0, *)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.tableView];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    tableHeaderView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = tableHeaderView;
    
    // 创建sectionHeaderView
    self.sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60)];
    self.sectionHeaderView.backgroundColor = [UIColor greenColor];
    UIButton *languageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [languageButton setTitle:@"语言" forState:UIControlStateNormal];
    languageButton.frame = CGRectMake(20, 10, 80, 40); // 调整按钮位置和大小
    [languageButton addTarget:self action:@selector(languageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionHeaderView addSubview:languageButton];
    
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [voiceButton setTitle:@"声音" forState:UIControlStateNormal];
    voiceButton.frame = CGRectMake(CGRectGetMaxX(languageButton.frame) + 20, 10, 80, 40); // 调整按钮位置和大小
    [voiceButton addTarget:self action:@selector(voiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionHeaderView addSubview:voiceButton];
}

- (void)languageButtonClicked:(UIButton *)sender {
    [VMANVoicePopListView showWithBelowView:self.sectionHeaderView dataSource:@[@"English", @"Chinese", @"Japnese", @"French"] selectBlock:^(NSString *item) {
        NSLog(@"%@", item);
    }];
}

- (void)voiceButtonClicked:(UIButton *)sender {
    [VMANVoicePopListView showWithBelowView:self.sectionHeaderView dataSource:@[@"Voice1", @"Voice2", @"Voice3", @"Voice4"] selectBlock:^(NSString *item) {
        NSLog(@"%@", item);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10; // 假设有10个cell
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 随机生成内容
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row + 1];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

@end
