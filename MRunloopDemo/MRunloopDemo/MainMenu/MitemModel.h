//
//  MitemModel.h
//  MRunloopDemo
//
//  Created by mal on 2018/7/21.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MitemModel : NSObject

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *itemTitle;

+ (MitemModel *)modelWithClassName:(NSString *)className itemTitle:(NSString *)itemTitle;

@end
