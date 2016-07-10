//
//  CartooninfoModel.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/03/28
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface CartooninfoModel : JSONModel

@property (nonatomic, copy) NSString *readMode;

@property (nonatomic, copy) NSString *isOver;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *thirdUpdateTime;

@property (nonatomic, strong) UserModel *userIDInfo;

@property (nonatomic, copy) NSString *thirdID;

@property (nonatomic, copy) NSString *updateType;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *priority;

@property (nonatomic, copy) NSString *updateValue;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *categorys;

@end