//
//  NSString+Extension.m
//  Mami
//
//  Created by lijiarui on 15/4/9.
//  Copyright (c) 2015年 lijiarui. All rights reserved.
//

#import "NSString+Extension.h"
#import <UIKit/UIKit.h>

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine;
    return [self boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
}


@end
