//
//  CellModel.h
//  Cathbag
//
//  Created by qianfeng on 16/3/6.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "JSONModel.h"
#import "CellItemModel.h"

@protocol CellItemModel <NSObject>



@end

@interface CellModel : JSONModel


@property (nonatomic, strong) NSArray <CellItemModel> *results;


@end
