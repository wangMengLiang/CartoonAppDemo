//
//  NSString+NSStringExt.m
//  Mami
//
//  Created by lijiarui on 15/4/9.
//  Copyright (c) 2015年 lijiarui. All rights reserved.
//

#import "NSString+NSStringExt.h"

@implementation NSString (NSStringExt)

- (int)calculateSubStringCount:(NSString *)str
{
   
    int count = 0;
    
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound)
    {
        return count;
    }
    

    NSString * subStr = self;
    
    while (range.location != NSNotFound) {
        

        count++;


        subStr = [subStr substringFromIndex:range.location + range.length];
        

        range = [subStr rangeOfString:str];
        
      
        
    }
    return count;
}
    



@end
