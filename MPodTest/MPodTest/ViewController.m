//
//  ViewController.m
//  MPodTest
//
//  Created by mal on 2019/10/10.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<MTestProtocol>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[XNGNotificationProxy sharedProxy] registerProtocol:@protocol(MTestProtocol) forObject:self];
}

- (void)mt_testfunc
{
    NSLog(@"ViewController mt_testfunc");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *sec = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:sec animated:YES];
}

@end
