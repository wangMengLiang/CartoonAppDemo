//
//  ItemModel.m
//  一点抓包
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"userIDInfo.name":@"userName"}];

}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
