//
//  ViewController.m
//  MLogSystemDemo
//
//  Created by mal on 2018/12/14.
//  Copyright © 2018 mal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *im;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"family_icon"];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
    self.im.image = newImage;
    // Do any additional setup after loading the view, typically from a nib.
}


@end
