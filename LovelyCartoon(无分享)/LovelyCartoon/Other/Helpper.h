//
//  Helpper.h
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OpenTimes @"kOpenAppTimes"
@interface Helpper : NSObject

+(void)recoredUserOpenAppTimes;

+(BOOL)isFirstOpen;

+(NSInteger)openTimes;


@end
