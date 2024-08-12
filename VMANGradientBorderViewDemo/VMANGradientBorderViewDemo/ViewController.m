//
//  ViewController.m
//  VMANGradientBorderViewDemo
//
//  Created by mal on 8/12/24.
//

#import "ViewController.h"
#import "VMANGradientBorderView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet VMANGradientBorderView *borderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.borderView.borderWidth = 3;
    self.borderView.cornerRadius = 8;
    // Do any additional setup after loading the view.
}


@end
