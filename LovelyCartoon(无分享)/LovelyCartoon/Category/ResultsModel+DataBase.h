//
//  ResultsModel+DataBase.h
//  LovelyCartoon
//
//  Created by WangMengLiang on 16/4/1.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "ResultsModel.h"

@interface ResultsModel (DataBase)

//查询保存的全部的app
+(NSArray *)selectAllCartoons;

//保存Model
- (BOOL)saveCartoon;

//查询一个Model是否存在
- (BOOL)selectCartoonIsExist;

//删除app
- (BOOL)removeCartoon;

@end
