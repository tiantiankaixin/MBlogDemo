//
//  VMANVoicePopListView.m
//  VMANPreloaderDemo
//
//  Created by mal on 8/12/24.
//

#import "VMANVoicePopListView.h"

#define Cell_Height 44
#define KeyWindow [VMANVoicePopListView keyWindow]
#define kDuration 0.1

@interface VMANVoicePopListView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *popupBackgroundView;
@property (nonatomic, strong) UIView *tableBgView;
@property (nonatomic, strong) UITableView *popupTableView;
@property (nonatomic, weak) UIView *belowView;

@end

@implementation VMANVoicePopListView
+ (nullable UIWindow *)keyWindow {
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                    }
                }
            }
        }
    } else {
        //return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

+ (void)showWithBelowView:(UIView *)belowView dataSource:(NSArray *)dataSource selectBlock:(nonnull void (^)(NSString *))selectBlock {
    VMANVoicePopListView *popView = [[VMANVoicePopListView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    popView.belowView = belowView;
    popView.dataSource = dataSource;
    popView.itemSelectedBlock = selectBlock;
    [popView setupViews];
    [popView show];
}

- (void)show {
    if (KeyWindow) {
        CGRect covertBelowViewRect = [self.belowView.superview convertRect:self.belowView.frame toView:KeyWindow];
        CGFloat margin = 20;
        CGFloat popTableViewY = CGRectGetMaxY(covertBelowViewRect);
        CGFloat popTableViewX = margin;
        CGFloat popTableViewWidth = CGRectGetWidth(self.bounds) - margin * 2;
        CGFloat popTableViewHeight = self.dataSource.count * Cell_Height;
        CGFloat popTableViewMaxHeight = CGRectGetHeight(self.bounds) - popTableViewY - margin;
        if (popTableViewHeight > popTableViewMaxHeight) {
            popTableViewHeight = popTableViewMaxHeight;
        }
        
        self.popupTableView.frame = CGRectMake(popTableViewX, popTableViewY, popTableViewWidth, popTableViewHeight);
        self.popupTableView.alpha = 0.0;
        self.tableBgView.frame = CGRectMake(0, popTableViewY, self.bounds.size.width, popTableViewMaxHeight + margin);
        self.tableBgView.alpha = 0.0;
        [KeyWindow addSubview:self];
        
        [UIView animateWithDuration:kDuration animations:^{
            self.tableBgView.alpha = 1.0;
            //self.popupTableView.frame = CGRectMake(popTableViewX, popTableViewY, popTableViewWidth, popTableViewHeight);
            self.popupTableView.alpha = 1.0;
        }];
    }
}

- (void)dismiss {
    [self dismissWithComplete:nil];
}

- (void)dismissWithComplete:(nullable void(^)(void))complete {
    [UIView animateWithDuration:kDuration animations:^{
        CGRect frame = self.popupTableView.frame;
        frame.size.height = 0;
        self.popupTableView.frame = frame;
        self.tableBgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
        [self removeFromSuperview];
    }];
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    self.popupBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.popupBackgroundView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delegate = self;
    [self.popupBackgroundView addGestureRecognizer:tapGesture];
    
    // 设置弹出tableView的背景视图
    self.tableBgView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.tableBgView.userInteractionEnabled = NO;
    [self.popupBackgroundView addSubview:self.tableBgView];
    
    // 设置popupTableView
    self.popupTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.popupTableView.dataSource = self;
    self.popupTableView.delegate = self;
    self.popupTableView.backgroundColor = [UIColor whiteColor];
    [self.popupBackgroundView addSubview:self.popupTableView];
    
    [self addSubview:self.popupBackgroundView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Cell_Height;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *selectedItem = self.dataSource[indexPath.row];
    __weak typeof(self) ws = self;
    [self dismissWithComplete:^{
        if (ws.itemSelectedBlock) {
            ws.itemSelectedBlock(selectedItem);
        }
    }];
}

// 添加手势识别器的代理方法，确保手势不拦截 UITableView 的点击事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.popupTableView]) {
        return NO; // 如果点击的是 UITableView 的 cell，则不拦截手势
    }
    return YES; // 否则允许手势继续处理
}

@end
