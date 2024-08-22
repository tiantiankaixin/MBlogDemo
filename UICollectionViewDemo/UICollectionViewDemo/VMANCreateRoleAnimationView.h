//
//  VMANCreateRoleAnimationView.h
//  UICollectionViewDemo
//
//  Created by mal on 8/22/24.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define Cell_Width floor((SCREEN_WIDTH - 16 - (12 * 1.5)) / 2.5)
#define Cell_Height floor(Cell_Width * (5 / 3.0))
#define VMANCreateIndex_CellSideMargin 16
#define VMANCreateIndex_CellHMargin 12

NS_ASSUME_NONNULL_BEGIN

@interface VMANCreateRoleAnimationView : UIView

+ (void)showWithOldDatas:(NSArray *)oldDatas newDatas:(NSArray *)newDatas parentView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
