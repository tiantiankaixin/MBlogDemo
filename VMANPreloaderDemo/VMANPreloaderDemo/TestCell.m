//
//  TestCell.m
//  VMANPreloaderDemo
//
//  Created by mal on 8/20/24.
//

#import "TestCell.h"

@implementation TestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (IBAction)testBtnClick {
    NSLog(@"testBtnClick");
}

@end
