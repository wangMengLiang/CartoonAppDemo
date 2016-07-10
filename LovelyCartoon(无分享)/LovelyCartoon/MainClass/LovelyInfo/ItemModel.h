//
//  ItemModel.h
//  一点抓包
//
//  Created by qianfeng on 16/3/4.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"

@interface ItemModel : JSONModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *createTimeValue;

//用户名需要跨级映射
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *id;



@end
