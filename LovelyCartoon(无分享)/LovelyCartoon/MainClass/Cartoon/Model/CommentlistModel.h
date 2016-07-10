//
//  CommentlistModel.h
//  RDVTabBarController
//
//  Created by qianfeng on 16/03/26
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UseridinfoModel;

@class UserModel;



@interface CommentlistModel : JSONModel

@property (nonatomic, copy) NSString *createTimeValue;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *id;

//@property (nonatomic, strong) UseridinfoModel *userIDInfo;

@property (nonatomic, strong) UserModel *userIDInfo;

@property (nonatomic, copy) NSString *valueType;

@property (nonatomic, copy) NSString *valueID;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *contentValue;

@property (nonatomic, copy) NSString *createTime;

@end