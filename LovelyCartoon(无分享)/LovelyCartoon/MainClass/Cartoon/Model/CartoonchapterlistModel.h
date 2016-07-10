//
//  CartoonchapterlistModel.h
//  RDVTabBarController
//
//  Created by qianfeng on 16/03/26
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CartoonchapterlistModel : JSONModel

@property (nonatomic, assign) NSInteger readStatus;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *totalChapterSize;

@property (nonatomic, copy) NSString *cartoonId;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *cartoonName;

@property (nonatomic, copy) NSString *totalAlbumCount;

@property (nonatomic, copy) NSString *priority;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger downloadStatus;

@end