//
//  ScrollImageModel.m
//  一点抓包
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ScrollImageModel.h"

@implementation ScrollImageModel

+(JSONKeyMapper *)keyMapper{

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"messageinfo.id":@"messageID"}];

}

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
