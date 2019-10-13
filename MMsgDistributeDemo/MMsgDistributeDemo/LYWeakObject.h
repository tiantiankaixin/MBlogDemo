//
//  LYWeakObject.h
//  LYDispatchProxy
//
//  Created by Liya on 2018/7/14.
//  Copyright © 2018年 Liya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYWeakObject;

extern LYWeakObject *ly_weakObject(id obj);

@interface LYWeakObject : NSObject
+ (id)weakObject:(id)obj;
@property (nonatomic, weak, readonly) id obj;
@end
