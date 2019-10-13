//
//  ViewController.m
//  iOS面试
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import "ViewController.h"
#import "MProperty.h"
#import "UIView+m.h"
#import "TestViewController.h"
#import "MLoadTestChild.h"
#import "MLoadTest+ca.h"

#define isiPhonex ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
    isPhoneX = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0;\
}\
isPhoneX;\
})

BOOL hadBands(){
    
    if (@available(iOS 11.0, *))
    {
        return [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0;\
    }
    return NO;
}

#define HadBands hadBands()

@interface ViewController ()

@property (nonatomic, strong) NSMutableString *str;

@end

@implementation ViewController

void MPrintRetainCount(id obj)
{
//    printf("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(obj)));
    NSLog(@"retain count = %d\n", [[obj valueForKey:@"retainCount"] intValue]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    redView.backgroundColor = [UIColor redColor];
//    [redView m_addCornerWithTL:8 tr:20 bl:30 br:40];
//    [self.view addSubview:redView];
//    NSMutableString *str = [[NSMutableString alloc] initWithString:@"11"];
//    NSLog(@"++++%p", str);
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setValue:@"test" forKey:str];
//    for (NSString *str in dic.allKeys)
//    {
//        NSLog(@"----%p", str);
//    }
//
//    NSArray *testArray = @[@"12", @"1234", @"12345"];
//    id a = [testArray valueForKey:@"length"];
//    NSLog(@"%@", a);
    self.str = [[NSMutableString alloc] init];
    MPrintRetainCount(self.str);
    NSObject *obj = [[NSObject alloc] init];
    MPrintRetainCount(obj);
//    if (HadBands)
//    {
//        NSLog(@"..isIphoneX.");
//    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"log1");
    });
    sleep(1);
    NSLog(@"log2");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *test = [[TestViewController alloc] init];
    [self presentViewController:test animated:YES completion:nil];
    
    //目标：让多个obj都可以监听delegate的方法
    //示例：让多个对象可以监控tableview的delegate
    //思路：NSProxy作为tableview的delegate 在里面实现消息转发
}

@end
