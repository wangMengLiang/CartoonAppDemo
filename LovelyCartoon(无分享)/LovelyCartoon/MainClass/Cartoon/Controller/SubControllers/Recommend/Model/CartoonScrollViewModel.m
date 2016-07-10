//
//  CartoonScrollViewModel.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/03/28
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "CartoonScrollViewModel.h"

@implementation CartoonScrollViewModel

+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"messageinfo.id":@"messageID"}];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
