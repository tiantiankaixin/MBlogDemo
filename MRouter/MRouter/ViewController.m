//
//  ViewController.m
//  MRouter
//
//  Created by maliang on 2024/7/1.
//

#import "ViewController.h"
#import "MRouter/MRouterManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MRouterManager share].appLaunchFinish = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [MRouterManager openWithUrlStr:@"vman://testHost/testPath?pa1=mal&pa2=20"];
}


@end
