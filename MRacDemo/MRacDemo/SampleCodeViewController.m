//
//  SampleCodeViewController.m
//  MRacDemo
//
//  Created by mal on 2019/9/28.
//  Copyright © 2019 mal. All rights reserved.
//

#import "SampleCodeViewController.h"

typedef NSString *(^finishBlock)(int);

@interface SampleCodeViewController ()

@property (nonatomic, copy) NSString *testStr;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, copy) RACGenericReduceBlock racblock;

@end

@implementation SampleCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self _racobserver];
    [self _bindProperty];
    [self _racCommand];
    // Do any additional setup after loading the view.
}

//MARK: RACObserver
- (void)_racobserver
{
    [RACObserve(self, testStr) subscribeNext:^(NSString *newStr) {
        
        NSLog(@"testStr改变了 %@", newStr);
    }];
    
    [[RACObserve(self, testStr) filter:^BOOL(NSString *newStr) {
        
        return newStr.length > 6;
        
    }] subscribeNext:^(NSString *newStr) {
        
        NSLog(@"testStr大于6位了 %@", newStr);
    }];
    
    self.testStr = @"123";
    self.testStr = @"1234567";
}

//MARK: 属性绑定
- (void)_bindProperty
{
    RAC(self.loginBtn, enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal, self.passWordTF.rac_textSignal] reduce:^(NSString *username, NSString *pwd){
        
        return @(username.length > 3 && pwd.length > 3);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        
        NSLog(@"login btn click");
    }];
}

- (void)_racCommand
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
