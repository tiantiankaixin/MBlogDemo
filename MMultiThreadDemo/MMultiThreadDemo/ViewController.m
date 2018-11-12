//
//  ViewController.m
//  MMultiThreadDemo
//
//  Created by mal on 2018/9/5.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_queue_t serialqueue = dispatch_queue_create("com.mal.serial", DISPATCH_QUEUE_SERIAL);
    //dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(serialqueue, ^{
    
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"1");
    });
    NSLog(@"2");
//    dispatch_async(serialqueue, ^{
//
//        NSLog(@"%@",[NSThread currentThread]);
//        NSLog(@"3");
//    });
//    NSLog(@"4");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
