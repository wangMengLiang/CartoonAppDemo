//
//  RootModel.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/03/28
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartoonScrollViewModel,CartooninfoModel,UserModel;

@interface RootModel : NSObject

@property (nonatomic, strong) NSArray<CartoonScrollViewModel *> *results;

@end