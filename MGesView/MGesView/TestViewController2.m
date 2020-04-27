//
//  TestViewController2.m
//  MGesView
//
//  Created by mal on 2020/3/6.
//  Copyright © 2020 mal. All rights reserved.
//

#import "TestViewController2.h"

@interface TestViewController2 ()

@end

@implementation TestViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
    self.block();
}

@end
