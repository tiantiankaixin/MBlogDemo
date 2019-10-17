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

@end

@implementation MLeakExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTestBlock:^{
        
        NSLog(@"%@", self.testStr);
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

@end
