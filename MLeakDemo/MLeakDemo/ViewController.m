//
//  ViewController.m
//  MLeakDemo
//
//  Created by mal on 2019/10/17.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"
#import "MLeakExampleController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MLeakExampleController *exampleVC = [[MLeakExampleController alloc] init];
    [self.navigationController pushViewController:exampleVC animated:YES];
}


@end
