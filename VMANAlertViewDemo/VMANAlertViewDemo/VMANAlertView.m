//
//  VMANAlertView.m
//  VMANAlertViewDemo
//
//  Created by mal on 8/12/24.
//

#import "VMANAlertView.h"

@interface VMANAlertView () {
    UIView *alertView;
    UIView *overlayView;
}
@end

@implementation VMANAlertView

+ (nullable UIWindow *)keyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                    }
                }
            }
        }
    } else {
        //return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title
                  buttonTitles:(NSArray<NSString *> *)buttonTitles {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _titleText = title;
        [self setupOverlay];
        [self setupAlertViewWithButtonTitles:buttonTitles];
    }
    return self;
}

- (void)setupOverlay {
    overlayView = [[UIView alloc] initWithFrame:self.bounds];
    overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:overlayView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [overlayView addGestureRecognizer:tap];
}

- (void)setupAlertViewWithButtonTitles:(NSArray<NSString *> *)buttonTitles {
    alertView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, self.frame.size.width - 80, 150)];
    alertView.center = self.center;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 10;
    alertView.clipsToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, alertView.frame.size.width - 40, 40)];
    titleLabel.text = self.titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [alertView addSubview:titleLabel];
    
    CGFloat buttonHeight = 44;
    CGFloat buttonY = CGRectGetMaxY(titleLabel.frame) + 10;
    CGFloat buttonMargin = 20;
    
    UIButton *lastBtn = nil;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, buttonY + i * (buttonHeight + buttonMargin), alertView.frame.size.width, buttonHeight);
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        button.backgroundColor = (buttonTitles.count == 1) ? [UIColor systemBlueColor] : (i == 0 ? [UIColor lightGrayColor] : [UIColor systemBlueColor]);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:button];
    }
    
    CGRect alertFrame = alertView.frame;
    alertFrame.size.height = buttonY + buttonTitles.count * (buttonHeight + buttonMargin);
    alertView.frame = alertFrame;
    
    [self addSubview:alertView];
}

- (void)show {
    UIWindow *keyWindow = [VMANAlertView keyWindow];
    [keyWindow addSubview:self];
    
    alertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    alertView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self->alertView.transform = CGAffineTransformIdentity;
        self->alertView.alpha = 1;
    }];
}

- (void)dismiss {
    [self dismissWithComplete:nil];
}

- (void)dismissWithComplete:(nullable void(^)(void))complete {
    [UIView animateWithDuration:0.3 animations:^{
        self->alertView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self->alertView.alpha = 0;
        self->overlayView.alpha = 0;
    } completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
        [self removeFromSuperview];
    }];
}

- (void)buttonTapped:(UIButton *)sender {
    __weak typeof(self) ws = self;
    [self dismissWithComplete:^{
        if (ws.buttonActionHandler) {
            ws.buttonActionHandler(sender.tag);
        }
    }];
}

- (void)dealloc {
    NSLog(@"VMANAlertView dealloc");
}

@end
