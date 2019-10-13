//
//  MScrollViewDelegate.m
//  MMsgDistributeDemo
//
//  Created by mal on 2019/9/16.
//  Copyright © 2019 mal. All rights reserved.
//

#import "MScrollViewDelegate.h"

@implementation MScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@ scrollViewDidScroll", NSStringFromClass(self.class));
}

@end
