//
//  TestCell.h
//  UICollectionViewDemo
//
//  Created by mal on 8/22/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *testLB;
@property (weak, nonatomic) IBOutlet UIView *cView;

+ (nullable TestCell *)nibCell;

@end

NS_ASSUME_NONNULL_END
