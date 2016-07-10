//
//  ResultsModel+DataBase.m
//  LovelyCartoon
//
//  Created by WangMengLiang on 16/4/1.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ResultsModel+DataBase.h"
#import "WMDataBaseManager.h"
@implementation ResultsModel (DataBase)



//查询保存的全部的app
+(NSArray *)selectAllCartoons{
    __block NSMutableArray *resArr = [NSMutableArray new];
    [[WMDataBaseManager shareManager].dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"SELECT * FROM M_Apps";
        FMResultSet *result = [db executeQuery:sql];
        
        while ([result next]) {
            NSDictionary *dic = [result resultDictionary];
            ResultsModel *model = [[ResultsModel alloc] initWithDictionary:dic error:nil];
            [resArr addObject:model];
        }
    }];
    
    return resArr;
}

//name TEXT, author TEXT, updateValueLabel TEXT, recentUpdateTime TEXT, cartoonChapterCount TEXT, introduction TEXT, id TEXT, images TEXT
//保存Model
- (BOOL)saveCartoon{
    __block BOOL res;
    [[WMDataBaseManager shareManager].dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"INSERT INTO M_Apps(name, author, updateValueLabel, recentUpdateTime , cartoonChapterCount, introduction, id, images) VALUES (?,?,?,?,?,?,?,?)";
        res = [db executeUpdate:sql, self.name, self.author, self.updateValueLabel, self.recentUpdateTime, self.cartoonChapterCount, self.introduction, self.id, self.images];
        
    }];
    return res;
}

//查询一个Model是否存在
- (BOOL)selectCartoonIsExist{
    __block BOOL res = NO;
    [[WMDataBaseManager shareManager].dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"SELECT * FROM M_Apps WHERE id = ?";
        FMResultSet *rs = [db executeQuery:sql, self.id];
        while ([rs next]) {
            res = YES;
        }
        // FMResultSet 结果的集合用完需要关闭
        [rs close];
    }];
    
    return res;
}

- (BOOL)removeCartoon{
    __block BOOL res;
    [[WMDataBaseManager shareManager].dataBaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"DELETE FROM M_Apps WHERE id = ?";
        res = [db executeUpdate:sql, self.id];
    }];
    
    return res;
}


@end
