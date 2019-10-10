//
//  ViewController.m
//  MGCDDemo
//
//  Created by mal on 2019/9/25.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    dispatch_semaphore_t _sem;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _sem = dispatch_semaphore_create(1);
}


@end
