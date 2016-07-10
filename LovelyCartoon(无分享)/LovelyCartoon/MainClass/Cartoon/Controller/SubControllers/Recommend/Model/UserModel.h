//
//  UserModel.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/03/28
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserModel : JSONModel

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *genre;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *name;

@end