//
//  ViewController.m
//  MMultiThreadDemo
//
//  Created by mal on 2018/9/5.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+obj1.h"
//#import "NSObject+obj2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        sleep(3);
//        NSLog(@"1111");
//    });
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        NSLog(@"222");
//    });
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        sleep(2);
//        NSLog(@"333");
//    });
//    NSLog(@"2222");
//    for (int i = 0; i < 10; i++)
//    {
//        dispatch_asyn_limit_3( ^{
//
//            NSLog(@"%@", [NSThread currentThread]);
//            sleep(2);
//        });
//        NSLog(@"%i", i);
//    }
    
//    for (int i = 0; i < 10; i++)
//    {
//        m_dispatch_asyncBlock( ^{
//
//            NSLog(@"%@", [NSThread currentThread]);
//            sleep(3);
//        });
//    }
}

void dispatch_asyn_limit_3(dispatch_block_t block)
{
    static dispatch_semaphore_t limitSemaphore;
    static dispatch_queue_t workQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        limitSemaphore = dispatch_semaphore_create(3);
        workQueue = dispatch_queue_create("receiver", DISPATCH_QUEUE_CONCURRENT);
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        dispatch_semaphore_wait(limitSemaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(workQueue, ^{
            
            if (block)
            {
                block();
            }
            dispatch_semaphore_signal(limitSemaphore);
        });
    });
}

void m_dispatch_asyncBlock(dispatch_block_t block)
{
    static dispatch_queue_t workQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        workQueue = dispatch_queue_create("receiver", DISPATCH_QUEUE_CONCURRENT);
    });
    dispatch_async(workQueue, ^{
       
        if (block)
        {
            block();
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
