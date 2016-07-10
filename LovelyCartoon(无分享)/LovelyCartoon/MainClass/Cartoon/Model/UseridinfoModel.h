//
//  UseridinfoModel.h
//  RDVTabBarController
//
//  Created by qianfeng on 16/03/26
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UseridinfoModel : JSONModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, assign) NSInteger informCount;

@end