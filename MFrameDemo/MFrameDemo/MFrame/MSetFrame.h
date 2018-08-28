//
//  MSetFrame.h
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFrameHandle.h"

@interface MSetFrame : NSObject<MFrameHandleDelegate>

@property (nonatomic, strong) NSMutableArray *handleArray;
@property (nonatomic, weak) UIView *view;

- (MFrameHandle *)left;
- (MFrameHandle *)right;
- (MFrameHandle *)top;
- (MFrameHandle *)bottom;
- (MFrameHandle *)width;
- (MFrameHandle *)height;

- (void(^)(NSArray *))m_equal;

@end
