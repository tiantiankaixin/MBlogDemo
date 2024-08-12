//
//  ViewController.m
//  VMANAlertViewDemo
//
//  Created by mal on 8/12/24.
//

#import "ViewController.h"
#import "VMANAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    VMANAlertView *alertView = [[VMANAlertView alloc] initWithTitle:@"Alert Title 放松放松党风建设斐林试剂拉法基手打飞机了四大刘金发失蜡法fsdfdsfsdfsfsdf" buttonTitles:@[@"Cancel", @"OK", @"Test"]];
    alertView.buttonActionHandler = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSLog(@"Cancel button tapped");
        } else if (buttonIndex == 1) {
            NSLog(@"OK button tapped");
        }
    };
    [alertView show];
}

@end
