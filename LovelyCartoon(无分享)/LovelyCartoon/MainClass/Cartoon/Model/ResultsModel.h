//
//  ResultsModel.h
//  RDVTabBarController
//
//  Created by qianfeng on 16/03/26
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UseridinfoModel,CommentlistModel,UseridinfoModel,CartoonchapterlistModel;

@interface ResultsModel : JSONModel

@property (nonatomic, copy) NSString *recentUpdateTime;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, strong) NSArray<CommentlistModel *> *commentList;

@property (nonatomic, copy) NSString *thirdUpdateTime;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, strong) NSArray<CartoonchapterlistModel *> *cartoonChapterList;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, strong) UseridinfoModel *userIDInfo;

@property (nonatomic, copy) NSString *updateValue;

@property (nonatomic, copy) NSString *commentCount;

@property (nonatomic, copy) NSString *thirdID;

@property (nonatomic, copy) NSString *isOver;

@property (nonatomic, copy) NSString *currentReadChapterId;

@property (nonatomic, copy) NSString *priority;

@property (nonatomic, copy) NSString *currentReadAlbumId;

@property (nonatomic, copy) NSString *categorys;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *updateInfo;

@property (nonatomic, copy) NSString *collectionStatus;

@property (nonatomic, copy) NSString *contentCount;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *totalCartoonSize;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *cartoonChapterCount;

@property (nonatomic, copy) NSString *readMode;

@property (nonatomic, copy) NSString *updateValueLabel;

@property (nonatomic, copy) NSString *updateType;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *categoryLabel;

@property (nonatomic, copy) NSString *totalChapterCount;

@end