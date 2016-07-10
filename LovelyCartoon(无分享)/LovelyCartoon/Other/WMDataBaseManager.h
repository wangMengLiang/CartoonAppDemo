//
//  WMDataBaseManager.h
//  MyApp
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDB.h"
@interface WMDataBaseManager : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;

//数据库队列   多线程
@property (nonatomic, strong) FMDatabaseQueue *dataBaseQueue;


@property (nonatomic, copy) NSString *dataBasePath;


+(instancetype)shareManager;

@end
