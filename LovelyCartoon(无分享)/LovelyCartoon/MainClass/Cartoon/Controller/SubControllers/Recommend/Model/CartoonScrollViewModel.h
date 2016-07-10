//
//  CartoonScrollViewModel.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/03/28
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartooninfoModel,UserModel;

@interface CartoonScrollViewModel : JSONModel

@property (nonatomic, copy) NSString *versionAD;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *adminID;

@property (nonatomic, strong) CartooninfoModel *cartooninfo;

@property (nonatomic, copy) NSString *clientType;

@property (nonatomic, copy) NSString *customValue;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *minVersionAD;

@property (nonatomic, copy) NSString *minVersionIOS;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *shortNum;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *customType;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *versionIOS;

@property (nonatomic, copy) NSString *customPosition;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *adImageLogCount;

@property (nonatomic, copy) NSString *beginTime;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSString *messageID;


@end