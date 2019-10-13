//
//  MProperty.h
//  iOS面试
//
//  Created by mal on 2019/3/9.
//  Copyright © 2019 mal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTestDelegate <NSObject>

- (void)m_test;

@end


@interface MProperty : NSObject
{
    NSString *_m_key;
}


@property (nonatomic, copy) NSString *testStr;

@end

NS_ASSUME_NONNULL_END
