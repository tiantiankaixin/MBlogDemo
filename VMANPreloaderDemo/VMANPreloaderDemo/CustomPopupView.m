#import "CustomPopupView.h"

@interface CustomPopupView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation CustomPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        // Create content view
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentView.layer.shadowOpacity = 0.1;
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
        self.contentView.layer.shadowRadius = 10;
        
        // Create item buttons
        self.item1Button = [self createItemButtonWithTitle:@"Item 1"];
        self.item1Button.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, 40);
        [self.contentView addSubview:self.item1Button];
        
        self.item2Button = [self createItemButtonWithTitle:@"Item 2"];
        self.item2Button.frame = CGRectMake(10, 60, self.contentView.frame.size.width - 20, 40);
        [self.contentView addSubview:self.item2Button];
        
        [self addSubview:self.contentView];
        
        // Add tap gesture recognizer to hide popup
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOutside:)];
//        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (UIButton *)createItemButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(itemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor lightGrayColor];
    
    UIView *radioButton = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    radioButton.layer.cornerRadius = 10;
    radioButton.tag = 100; // Tag to identify the radio button view
    radioButton.userInteractionEnabled = NO;
    [button addSubview:radioButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, button.frame.size.width - 40, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    [button addSubview:titleLabel];
    
    return button;
}

- (void)itemButtonTapped:(UIButton *)sender {
    if (self.selectedButton == sender) {
        return; // If the tapped button is already selected, do nothing
    }
    
    [self deselectButton:self.selectedButton];
    [self selectButton:sender];
    self.selectedButton = sender;
}

- (void)selectButton:(UIButton *)button {
    UIView *radioButton = [button viewWithTag:100];
    radioButton.backgroundColor = [UIColor blueColor];
}

- (void)deselectButton:(UIButton *)button {
    if (button) {
        UIView *radioButton = [button viewWithTag:100];
        radioButton.backgroundColor = [UIColor clearColor];
    }
}

- (void)showInView:(UIView *)view belowButton:(UIButton *)button withOffset:(CGFloat)offset {
    self.frame = view.bounds;
    CGRect buttonFrame = [button convertRect:button.bounds toView:view];
    CGFloat contentViewY = CGRectGetMaxY(buttonFrame) + offset;
    CGFloat contentViewX = buttonFrame.origin.x + (buttonFrame.size.width - self.contentView.frame.size.width) / 2;
    self.contentView.frame = CGRectMake(contentViewX, contentViewY, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [view addSubview:self];
    
    self.contentView.alpha = 0.0;
    self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);

    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.contentView.alpha = 1.0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.contentView.alpha = 0.0;
        self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//- (void)handleTapOutside:(UITapGestureRecognizer *)sender {
//    CGPoint tapLocation = [sender locationInView:self.contentView];
//    if (!CGRectContainsPoint(self.contentView.frame, tapLocation)) {
//        [self hide];
//    }
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self]) {
        [self hide];
    }
    return view;
}

@end
