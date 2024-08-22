//
//  VMANCreateRoleAnimationView.m
//  UICollectionViewDemo
//
//  Created by mal on 8/22/24.
//

#import "VMANCreateRoleAnimationView.h"
#import "TestCell.h"

#define kAnimationDuration 0.3

@interface VMANCreateRoleAnimationView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *subViewsArray;
@property (nonatomic, strong) TestCell *animationCell;

@end

@implementation VMANCreateRoleAnimationView

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NSMutableArray *)subViewsArray {
    if (_subViewsArray == nil) {
        _subViewsArray = [NSMutableArray array];
    }
    return _subViewsArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
}

+ (void)showWithOldDatas:(NSArray *)oldDatas newDatas:(NSArray *)newDatas parentView:(UIView *)view {
    VMANCreateRoleAnimationView *animationView = [[VMANCreateRoleAnimationView alloc] initWithFrame:view.bounds];
    [view addSubview:animationView];
    
    animationView.backgroundColor = [UIColor whiteColor];
    
    TestCell *cell = [TestCell nibCell];
    cell.testLB.text = newDatas.firstObject;
    cell.frame = CGRectMake(VMANCreateIndex_CellSideMargin, 0, Cell_Width, Cell_Height);
    [animationView.scrollView addSubview:cell];
    animationView.animationCell = cell;
    
    if (newDatas.count > 1) {
        TestCell *lastCell = nil;
        for (NSString *content in oldDatas) {
            TestCell *cell = [TestCell nibCell];
            cell.testLB.text = content;
            if (lastCell == nil) {
                cell.frame = CGRectMake(VMANCreateIndex_CellSideMargin, 0, Cell_Width, Cell_Height);
            } else {
                CGRect frame = lastCell.frame;
                frame.origin.x = frame.origin.x + VMANCreateIndex_CellHMargin + Cell_Width;
                cell.frame = frame;
            }
            [animationView addSubview:cell];
            [animationView.subViewsArray addObject:cell];
            lastCell = cell;
        }
    }
    
    [animationView showAnimation];
}

- (void)showAnimation {
    if (_animationCell) {
        self.animationCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.animationCell.alpha = 0.0;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.animationCell.alpha = 1.0;
            self.animationCell.transform = CGAffineTransformIdentity;
            for (TestCell *cell in self.subViewsArray) {
                CGRect frame = cell.frame;
                frame.origin.x = frame.origin.x + Cell_Width + VMANCreateIndex_CellHMargin;
                cell.frame = frame;
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
