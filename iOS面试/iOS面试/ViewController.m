//
//  ViewController.m
//  iOS面试
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"
#import "MProperty.h"
#import "UIView+m.h"
#import "TestViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *str;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [redView m_addCornerWithTL:8 tr:20 bl:30 br:40];
    [self.view addSubview:redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *test = [[TestViewController alloc] init];
    [self presentViewController:test animated:YES completion:nil];
}

@end
