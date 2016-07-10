//
//  ContentModel.m
//  一点抓包
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel


+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"userIDInfo.signature":@"signature", @"userIDInfo.images":@"userIcon"}];

}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}


@end
