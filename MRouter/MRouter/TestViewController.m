//
//  TestViewController.m
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"test");
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (id<MRouterProtocol>)createWithParam:(NSDictionary *)param {
    TestViewController *vc = [[TestViewController alloc] init];
    NSLog(@"接收到的参数是%@", param);
    return vc;
}

- (BOOL)needLogin {
    return NO;
}

- (MRouterOpenType)openType {
    return MRouter_present;
}

@end
