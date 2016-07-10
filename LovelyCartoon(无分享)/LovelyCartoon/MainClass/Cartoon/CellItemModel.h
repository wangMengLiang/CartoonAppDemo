//
//  CellItemModel.h
//  Cathbag
//
//  Created by qianfeng on 16/3/6.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"
#import "CellImageModel.h"

@protocol CellImageModel <NSObject>

@end

@interface CellItemModel : JSONModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<CellImageModel> *cartoonSetList;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *valueID;

@end
