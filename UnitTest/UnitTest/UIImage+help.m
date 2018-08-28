//
//  UIImage+help.m
//  UnitTest
//
//  Created by mal on 2018/8/17.
//  Copyright © 2018年 mal. All rights reserved.
//

#import "UIImage+help.h"

@implementation UIImage (help)

- (UIImage *)m_resizeableImage
{
    CGFloat w = self.size.width * 0.5;
    CGFloat h = self.size.height * 0.5;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(w, h, w, h) resizingMode:UIImageResizingModeStretch];
}

@end
