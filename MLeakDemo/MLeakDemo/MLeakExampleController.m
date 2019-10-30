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

@end

@implementation MLeakExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTestBlock:^{

        NSLog(@"%@", self.testStr);
    }];
   
    [self performSelector:@selector(testFunc) withObject:nil afterDelay:5];
    // Do any additional setup after loading the view from its nib.
}

- (void)testFunc
{
    
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

@end
