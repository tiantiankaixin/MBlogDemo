//
//  ViewController.m
//  MRacDemo
//
//  Created by mal on 2019/9/28.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"
#import "SampleCodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"主页";
    [self addItemWithClass:[SampleCodeViewController class] title:@"示例代码"];
    // Do any additional setup after loading the view.
}


@end
