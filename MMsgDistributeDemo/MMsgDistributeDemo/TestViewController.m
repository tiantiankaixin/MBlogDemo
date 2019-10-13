//
//  TestViewController.m
//  MMsgDistributeDemo
//
//  Created by mal on 2019/9/16.
//  Copyright © 2019 mal. All rights reserved.
//

#import "TestViewController.h"
#import "MMsgDistributeProxy.h"
#import "MScrollViewDelegate.h"
#import "LYWeakObject.h"
#import "YYWeakProxy.h"

@interface TestViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) MMsgDistributeProxy<UIScrollViewDelegate> *scrollViewProxy;

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollViewProxy = (MMsgDistributeProxy<UIScrollViewDelegate> *)m_distributeProxy([YYWeakProxy proxyWithTarget:self], [MScrollViewDelegate new]);
    self.scrollView.contentSize = CGSizeMake(0, 1200);
    self.scrollView.delegate = self.scrollViewProxy;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@ scrollViewDidScroll", NSStringFromClass(self.class));
}

- (void)dealloc
{
    NSLog(@"TestViewController dealloc");
}

@end
