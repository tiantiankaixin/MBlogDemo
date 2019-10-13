//
//  ViewController.m
//  MMsgDistributeDemo
//
//  Created by mal on 2019/9/16.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"
#import "MTestObject.h"
#import "MMsgDistributeProxy.h"
#import "TestViewController.h"

@interface ViewController ()<MTestPorotocol>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MMsgDistributeProxy<MTestPorotocol> *proxy = (MMsgDistributeProxy<MTestPorotocol> *)m_distributeProxy(self, [MTestObject new]);
    [proxy test1];
    [proxy test2];
}

- (void)test1
{
    NSLog(@"%@ test1", NSStringFromClass(self.class));
}

- (void)test2
{
    NSLog(@"%@ test2", NSStringFromClass(self.class));
}

 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
