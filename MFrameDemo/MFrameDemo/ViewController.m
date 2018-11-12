//
//  ViewController.m
//  MFrameDemo
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import "UIView+masframe.h"
#import "UIView+frame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.left.top.width.height.m_equal(@[@10,@20,@100,@100]);
    redView.width.height.m_equal(@[@200,@100]);
    redView.mset.width.m_equal(@[@300]);
    [self.view addSubview:redView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
