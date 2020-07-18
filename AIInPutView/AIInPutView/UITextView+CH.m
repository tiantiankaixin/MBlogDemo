//
//  UITextView+CH.m
//  Chic
//
//  Created by ss on 2016/10/19.
//  Copyright © 2016年 haowai. All rights reserved.
//

#import "UITextView+CH.h"
#import "AIInputView-Swift.h"

@implementation UITextView (CH)

- (BOOL)checkWithMaxinputNum:(NSInteger)maxInputNum
{
    UITextView *sender = self;
    NSString *toBeString = sender.text;
    //获取高亮部分
    UITextRange *selectedRange = [sender markedTextRange];
    UITextPosition *position = [sender positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > maxInputNum)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxInputNum];
            if (rangeIndex.length == 1)
            {
                sender.text = [toBeString substringToIndex:maxInputNum];
                return YES;
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxInputNum)];
                sender.text = [toBeString substringWithRange:rangeRange];
                return YES;
            }
        }
    }
    return NO;
}


@end
