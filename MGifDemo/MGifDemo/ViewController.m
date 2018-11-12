//
//  ViewController.m
//  MGifDemo
//
//  Created by mal on 2018/10/25.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage/FLAnimatedImage.h"

@interface ViewController ()

@property (nonatomic, strong) FLAnimatedImageView *imageView1;
@property (nonatomic, strong) UIImageView *img;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView1 = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.imageView1];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"0 (10)" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.imageView1.animatedImage = animatedImage1;
    [self.imageView1 setLoopCompletionBlock:^(NSUInteger loopCountRemaining) {
        
        NSLog(@"");
    }];
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    self.img.frame = self.imageView1.frame;
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"002" ofType:@"png"];
    self.img.image = [UIImage imageWithContentsOfFile:imgPath];
    [self.view insertSubview:self.img belowSubview:self.imageView1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.imageView1.animatedImage = nil;
    self.imageView1.hidden = YES;
}


@end
