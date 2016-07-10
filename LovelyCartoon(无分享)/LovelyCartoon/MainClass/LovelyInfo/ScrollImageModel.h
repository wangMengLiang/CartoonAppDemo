//
//  ScrollImageModel.h
//  一点抓包
//
//  Created by qianfeng on 16/3/5.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"

@interface ScrollImageModel : JSONModel

@property (nonatomic, copy) NSString *images;


@property (nonatomic, copy) NSString *title;

//需要映射
@property (nonatomic, copy) NSString *messageID;

@end
