//
//  ViewController.m
//  VMANAlertViewDemo
//
//  Created by mal on 8/12/24.
//

#import "ViewController.h"
#import "VMANAlertView.h"
#import "UIView+DottedBorder.h"
#import "VMANGradientButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (strong, nonatomic) UIImageView *animationIM;

@end

@implementation ViewController

- (UIImageView *)animationIM {
    if (_animationIM == nil) {
        _animationIM = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _animationIM.backgroundColor = [UIColor greenColor];
    }
    return _animationIM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.testBtn addDottedBorderWithColor:[UIColor blueColor] lineWidth:2 dashPattern:@[@6, @2] cornerRadius:20];
    self.testBtn.layer.cornerRadius = 20;
    [self.testBtn.layer masksToBounds];
    
    VMANGradientButton *gradientBtn = [VMANGradientButton themeGreenBtn];
    
    [gradientBtn setTitle:@"测试" forState:UIControlStateNormal];
    gradientBtn.frame = CGRectMake(100, 100, 200, 48);
    gradientBtn.layer.cornerRadius = 24;
    [gradientBtn.layer masksToBounds];
    [self.view addSubview:gradientBtn];
    [gradientBtn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)testBtnClick:(VMANGradientButton *)sender {
    [sender startLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender stopLoading];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
}

@end
