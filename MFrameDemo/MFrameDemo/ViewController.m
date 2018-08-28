//
//  ViewController.m
//  MFrameDemo
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import "UIView+frame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    NSArray *array = @[@50,@70,@100,@100];
    redView.mset.left.top.width.height.m_equal(array);
    redView.mset.width.height.m_equal(@[@200,@100]);
    [self.view addSubview:redView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
