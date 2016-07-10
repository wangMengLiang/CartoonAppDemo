//
//  CellImageModel.h
//  Cathbag
//
//  Created by qianfeng on 16/3/6.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"

@interface CellImageModel : JSONModel

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *updateInfo;

@property (nonatomic, copy) NSString *id;
@end
