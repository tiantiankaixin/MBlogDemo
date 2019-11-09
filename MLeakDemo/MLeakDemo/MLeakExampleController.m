//
//  MLeakExampleController.m
//  MLeakDemo
//
//  Created by mal on 2019/10/17.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MLeakExampleController.h"

@interface MLeakExampleController ()

@property (nonatomic, copy) void(^testBlock)(void);
@property (nonatomic, copy) NSString *testStr;
@property (nonatomic, weak) NSMutableArray *weakArray;
@property (nonatomic, strong) dispatch_source_t source_t;

@end

@implementation MLeakExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    //1、block
//    [self setTestBlock:^{
//
//        NSLog(@"%@", self.testStr);
//    }];
//
//    //2、perform
//    [self performSelector:@selector(testFunc) withObject:nil afterDelay:5];
    //3、
    self.source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.source_t, DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.source_t, ^{
        
        //dispatch_source_cancel(timer);
        NSLog(@"test");
    });
    dispatch_resume(self.source_t);
    NSLog(@"....");
    // Do any additional setup after loading the view from its nib.
}

- (void)testFunc
{
    
}

- (void)_closeTimer
{
    if (_source_t) {
        dispatch_source_cancel(_source_t);
        _source_t = nil;
    }
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
    [self _closeTimer];
}

@end
