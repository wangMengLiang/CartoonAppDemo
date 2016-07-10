//
//  WMDataBaseManager.m
//  MyApp
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMDataBaseManager.h"


@interface WMDataBaseManager ()



@end

@implementation WMDataBaseManager

+(instancetype)shareManager{
    static WMDataBaseManager *manager = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        manager = [[WMDataBaseManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.dataBasePath];
        [self createTable];
    }
    return self;
}
//dataBasePath的getter方法
- (NSString *)dataBasePath{
    if (_dataBasePath == nil) {
        NSString *path = [NSString stringWithFormat:@"%@/Library/appData.sqlite", NSHomeDirectory()];
        _dataBasePath = path;
    }
    return _dataBasePath;
}

//applicationId, name, currentPrice, categoryName , downloads, shares, iconUrl, favorites, starCurrent, lastPrice

- (void)createTable{
    //数据库队列，是线程安全
    [_dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"CREATE TABLE IF NOT EXISTS M_Apps(name TEXT, author TEXT, updateValueLabel TEXT, recentUpdateTime TEXT, cartoonChapterCount TEXT, introduction TEXT, id TEXT, images TEXT)";
        if ([db executeUpdate:sql]) {
            NSLog(@"建表成功");
        }
        
    }];

}

- (void)save:(id)dataModel{
    



}


















@end
