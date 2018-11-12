//
//  MSetFrame.h
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSetFrame : NSObject

@property (nonatomic, strong) NSMutableArray *handleArray;
@property (nonatomic, weak) UIView *view;

- (MSetFrame *)left;
- (MSetFrame *)right;
- (MSetFrame *)top;
- (MSetFrame *)bottom;
- (MSetFrame *)width;
- (MSetFrame *)height;

- (void(^)(NSArray *))m_equal;
- (MSetFrame *(^)(void))m_blockTest;

@end
