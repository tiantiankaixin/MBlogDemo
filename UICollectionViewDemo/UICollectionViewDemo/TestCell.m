//
//  TestCell.m
//  UICollectionViewDemo
//
//  Created by mal on 8/22/24.
//

#import "TestCell.h"

@implementation TestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cView.layer.cornerRadius = 12;
    self.cView.layer.masksToBounds = YES;
    // Initialization code
}

+ (nullable TestCell *)nibCell {
    TestCell *cell = (TestCell *)[[NSBundle mainBundle] loadNibNamed:@"TestCell" owner:nil options:nil].firstObject;
    cell.cView.layer.cornerRadius = 12;
    cell.cView.layer.masksToBounds = YES;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


@end
