//
//  RootModel.m
//  LovelyCartoon
//
//  Created by qianfeng on 16/03/28
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "RootModel.h"
#import "CartoonScrollViewModel.h"

@implementation RootModel

+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [CartoonScrollViewModel class]};
}

@end
