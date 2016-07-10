//
//  APPGlobalScale.m
//  LovelyCartoon
//
//  Created by WangMengLiang on 16/3/30.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "APPGlobalScale.h"

@implementation APPGlobalScale

- (CGFloat)initWithmyAppSizeScale{
    CGFloat scale;
    if (WIDTH == 414) {
        scale = 1.0;
    }else if (WIDTH == 375){
        scale = 0.906;
    }else if (WIDTH == 320){
        scale = 0.773;
    }
    return scale;
}

+ (CGFloat)myAppSizeScale{

    return [[APPGlobalScale alloc] initWithmyAppSizeScale];
}


- (CGFloat)initWithiPhone4HeightScale{
    CGFloat heightScale;
    if (HEIGHT <= 480) {
        heightScale = 0.855;
    }else{
        heightScale = 1;
    }
    
    return heightScale;
}

+ (CGFloat)iPhone4HeightScale{
    
    return [[APPGlobalScale alloc] initWithiPhone4HeightScale];

}





@end
