//
//  MitemModel.m
//  MRunloopDemo
//
//  Created by mal on 2018/7/21.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "MitemModel.h"

@implementation MitemModel

+ (MitemModel *)modelWithClassName:(NSString *)className itemTitle:(NSString *)itemTitle
{
    MitemModel *model = [[MitemModel alloc] init];
    
    model.className = className;
    model.itemTitle = itemTitle;
    
    return model;
}

@end
