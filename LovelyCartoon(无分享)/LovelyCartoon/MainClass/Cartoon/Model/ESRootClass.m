//
//  ESRootClass.m
//  __PRODUCTNAME__
//
//  Created by qianfeng on 16/03/29
//  Copyright (c) qianfeng. All rights reserved.
//

#import "ESRootClass.h"
#import "CartoonPictureModel.h"

@implementation ESRootClass

+ (NSDictionary *)objectClassInArray{
    return @{@"results" : [CartoonPictureModel class]};
}

+(BOOL)propertyIsOptional:(NSString *)propertyName{

    return YES;
}

@end
