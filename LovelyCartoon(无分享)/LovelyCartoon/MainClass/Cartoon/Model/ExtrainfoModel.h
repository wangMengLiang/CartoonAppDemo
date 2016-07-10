//
//  ExtrainfoModel.h
//  __PRODUCTNAME__
//
//  Created by qianfeng on 16/03/29
//  Copyright (c) qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ExtrainfoModel : JSONModel

@property (nonatomic, copy) NSString *countTotal;

@property (nonatomic, copy) NSString *totalChapterSize;

@property (nonatomic, copy) NSString *nextChapterId;

@property (nonatomic, copy) NSString *lastChapterId;

@property (nonatomic, copy) NSString *currentAlbumId;

@property (nonatomic, copy) NSString *otherTitle;

@property (nonatomic, assign) NSInteger otherType;

@end