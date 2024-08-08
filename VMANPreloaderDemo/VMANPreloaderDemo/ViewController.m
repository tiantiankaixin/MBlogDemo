//
//  ViewController.m
//  VMANPreloaderDemo
//
//  Created by maliang on 2024/7/5.
//

#import "ViewController.h"
#import "CustomPopupView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *showPopupButton;
@property (nonatomic, strong) CustomPopupView *popupView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create button
    self.showPopupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.showPopupButton setTitle:@"Show Popup" forState:UIControlStateNormal];
    self.showPopupButton.frame = CGRectMake(100, 100, 100, 50);
    [self.showPopupButton addTarget:self action:@selector(showPopup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showPopupButton];
    
    // Create popup viewi
    self.popupView = [[CustomPopupView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    
    // Add tap gesture recognizer to hide popup
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOutside:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)showPopup {
    [self.popupView showInView:self.view belowButton:self.showPopupButton withOffset:20];
}

- (void)handleTapOutside:(UITapGestureRecognizer *)sender {
    CGPoint tapLocation = [sender locationInView:self.view];
    if (!CGRectContainsPoint(self.popupView.frame, tapLocation)) {
        [self.popupView hide];
    }
}


@end
