//
//  TestViewController1.m
//  MGesView
//
//  Created by mal on 2020/3/6.
//  Copyright © 2020 mal. All rights reserved.
//

#import "TestViewController1.h"
#import "TestViewController2.h"

@interface TestViewController1 ()

@end

@implementation TestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController2 *vc = [TestViewController2 new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc setBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
