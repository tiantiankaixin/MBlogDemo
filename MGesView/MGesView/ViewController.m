//
//  ViewController.m
//  MGesView
//
//  Created by mal on 2018/1/18.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import "MGesView.h"
#import "MLClickTimeBtn.h"

@interface ViewController ()

@property (nonatomic, strong) MGesView *gesView1;
@property (nonatomic, strong) MGesView *gesView2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *redBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [redBtn setBackgroundColor:[UIColor redColor]];
    [redBtn addTarget:self action:@selector(redBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.gesView1 = [[MGesView alloc] initWithFrame:self.view.bounds];
    [self.gesView1 setBackgroundColor:[UIColor clearColor]];
    [self.gesView1 addSubview:redBtn];
    self.gesView1.str = @"gesView1";
    [self.view addSubview:self.gesView1];
    
    UIButton *blueBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 50, 50)];
    [blueBtn setBackgroundColor:[UIColor blueColor]];
    [blueBtn addTarget:self action:@selector(blueBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    self.gesView2 = [[MGesView alloc] initWithFrame:self.view.bounds];
    [self.gesView2 addSubview:blueBtn];
    self.gesView2.str = @"gesView2";
    [self.view addSubview:self.gesView2];
    
    MLClickTimeBtn *clikTimeBtn = [[MLClickTimeBtn alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    clikTimeBtn.backgroundColor = [UIColor grayColor];
    [clikTimeBtn addTarget:self action:@selector(testClickWithSender:) forControlEvents:(UIControlEventTouchUpInside)];
    clikTimeBtn.clickInterVal = 2;
    [self.view addSubview:clikTimeBtn];
}

- (void)testClickWithSender:(MLClickTimeBtn *)btn
{
    if ([btn clickCheck])
    {
       NSLog(@"按钮被点击了");
    }
}

- (void)redBtnClick
{
    NSLog(@"red btn click");
}

- (void)blueBtnClick
{
    NSLog(@"blue btn click");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
