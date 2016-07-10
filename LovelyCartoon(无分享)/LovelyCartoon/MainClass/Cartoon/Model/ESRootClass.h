//
//  ESRootClass.h
//  __PRODUCTNAME__
//
//  Created by qianfeng on 16/03/29
//  Copyright (c) qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExtrainfoModel,PictureParamsModel,CartoonPictureModel;

@interface ESRootClass : JSONModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CartoonPictureModel *> *results;

@property (nonatomic, strong) ExtrainfoModel *extraInfo;

@property (nonatomic, strong) PictureParamsModel *params;

@property (nonatomic, copy) NSString *error;

@end