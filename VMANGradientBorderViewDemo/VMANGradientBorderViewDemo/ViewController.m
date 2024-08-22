//
//  ViewController.m
//  VMANGradientBorderViewDemo
//
//  Created by mal on 8/12/24.
//

#import "ViewController.h"
#import "VMANGradientBorderView.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet VMANGradientBorderView *borderView;
@property (weak, nonatomic) IBOutlet UITextField *testTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.borderView.borderWidth = 3;
    self.borderView.cornerRadius = 8;
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 30)];
    clearBtn.backgroundColor = [UIColor redColor];
    [clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.testTF.rightView = clearBtn;
    self.testTF.rightViewMode = UITextFieldViewModeNever;
    self.testTF.delegate = self;
    [self.testTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textFieldDidChange:(UITextField *)textfield {
    if (textfield.text.length > 0) {
        self.testTF.rightViewMode = UITextFieldViewModeWhileEditing;
    } else {
        self.testTF.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)clearBtnClick {
    self.testTF.text = @"";
    self.testTF.rightViewMode = UITextFieldViewModeNever;
}


@end
