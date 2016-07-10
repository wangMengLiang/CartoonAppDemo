//
//  Helpper.m
//  JokeText
//
//  Created by qianfeng on 16/3/21.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "Helpper.h"

@implementation Helpper

+(void)recoredUserOpenAppTimes{
    //如果取不出来是0；
    NSInteger times = [[NSUserDefaults standardUserDefaults] integerForKey:OpenTimes];
    times++;
    
    [[NSUserDefaults standardUserDefaults] setInteger:times forKey:OpenTimes];
    

}

+(BOOL)isFirstOpen{
    NSInteger times = [[NSUserDefaults standardUserDefaults] integerForKey:OpenTimes];
    
    if (times == 1) {
        return YES;
    }
    return NO;
}

+(NSInteger)openTimes{
    NSInteger times = [[NSUserDefaults standardUserDefaults] integerForKey:OpenTimes];
    return times;
}


@end
