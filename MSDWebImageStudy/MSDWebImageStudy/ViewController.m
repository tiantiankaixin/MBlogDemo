//
//  ViewController.m
//  MSDWebImageStudy
//
//  Created by mal on 2018/1/29.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import "MyImageView.h"

#define url1  @"http://img.taopic.com/uploads/allimg/120727/201995-120HG1030762.jpg"

#define url2  @"http://img.taopic.com/uploads/allimg/140729/240450-140HZP45790.jpg"

@interface ViewController ()

@property (nonatomic, strong) MyImageView *im;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MyImageView *im = [[MyImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _im = im;
    im.backgroundColor = [UIColor redColor];
    
    [im sd_setImageWithURL:[NSURL URLWithString:url1]];
    
    [im sd_setImageWithURL:[NSURL URLWithString:url2]];
    
    [self.view addSubview:im];
    NSInteger n = 1;
    NSLog(@"%ld",++n * 2);
    n = 1;
    NSLog(@"%ld", 2 * ++n);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.im sd_setImageWithURL:[NSURL URLWithString:url1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
