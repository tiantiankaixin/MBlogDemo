//
//  MFrameHandle.h
//  UnitTest
//
//  Created by mal on 2018/8/28.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MFrameHandle;

typedef NS_ENUM(NSInteger, MHandleType){
    
    MH_LEFT = 1000,
    MH_RIGHT = 1001,
    MH_TOP = 1002,
    MH_BOTTOM = 1003,
    MH_WIDTH = 1004,
    MH_HEIGHT = 1005,
};

@protocol MFrameHandleDelegate<NSObject>

- (MFrameHandle *)m_addHandleWithType:(MHandleType)type;
- (void(^)(NSArray *))m_equal;

@end

@interface MFrameHandle : NSObject

@property (nonatomic, assign) MHandleType type;
@property (nonatomic, weak) id<MFrameHandleDelegate> m_delegate;
@property (nonatomic, weak) UIView *view;

- (MFrameHandle *)left;
- (MFrameHandle *)right;
- (MFrameHandle *)top;
- (MFrameHandle *)bottom;
- (MFrameHandle *)width;
- (MFrameHandle *)height;
- (void(^)(NSArray *))m_equal;

- (void)m_setValue:(NSNumber *)value;

@end
