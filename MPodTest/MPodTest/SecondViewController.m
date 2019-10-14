//
//  SecondViewController.m
//  MPodTest
//
//  Created by mal on 2019/10/10.
//  Copyright © 2019 mal. All rights reserved.
//

#import "SecondViewController.h"
#import "YYWeakProxy.h"

@interface SecondViewController ()<MTestProtocol>

@property (nonatomic, weak) XNGNotificationProxy<MTestProtocol> *proxy;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.proxy = (XNGNotificationProxy<MTestProtocol> *)[XNGNotificationProxy sharedProxy];
    // Do any additional setup after loading the view.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(test) userInfo:nil repeats:YES];
}

- (void)test
{
    NSLog(@"test");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.proxy mt_testfunc];
//    YYWeakProxy<MTestProtocol> *proxy = (YYWeakProxy<MTestProtocol> *)[YYWeakProxy proxyWithTarget:self];
//    [proxy mt_testfunc];
}

- (void)dealloc
{
    [self.timer invalidate];
    _timer = nil;
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

@end
