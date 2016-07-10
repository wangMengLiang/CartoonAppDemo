//
//  ContentModel.h
//  一点抓包
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"

@interface ContentModel : JSONModel

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *content;


//需要跨级映射  userIDInfo.signature
@property (nonatomic, copy) NSString *signature;
// userIDInfo.images
@property (nonatomic, copy) NSString *userIcon;

@property (nonatomic, copy) NSString *createTimeValue;


@property (nonatomic, copy) NSString *shareUrl;


@end
