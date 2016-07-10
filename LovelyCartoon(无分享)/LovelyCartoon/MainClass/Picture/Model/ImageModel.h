//
//  ImageModel.h
//  Cathbag
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>
@interface ImageModel : JSONModel


@property (nonatomic) NSNumber *height;

@property (nonatomic) NSNumber *width;

@property (nonatomic, copy) NSString *images;

@end
