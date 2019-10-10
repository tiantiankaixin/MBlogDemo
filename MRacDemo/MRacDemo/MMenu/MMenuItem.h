//
//  MMenuItem.h
//  MRacDemo
//
//  Created by mal on 2019/9/28.
//  Copyright © 2019 mal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MTurnType) {
    
    M_Push,
    M_Present
};

NS_ASSUME_NONNULL_BEGIN

@interface MMenuItem : NSObject

@property (nonatomic, strong) Class itemClass;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, assign) MTurnType turnType;

+ (MMenuItem *)itemWithClass:(Class)aClass title:(NSString *)title turnType:(MTurnType)type;

@end

NS_ASSUME_NONNULL_END
