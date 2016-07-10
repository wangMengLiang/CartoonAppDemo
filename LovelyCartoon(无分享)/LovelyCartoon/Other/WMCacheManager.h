//
//  WMCacheManager.h
//  MyApp
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMCacheManager : NSObject

//保存二进制数据，以url为唯一标识
//data就是需要保存的数据
//url 是唯一标识
+(void)saveData:(id)data url:(NSString*)url;


//读取二进制数据，url是唯一标识 返回二进制数据
+(id)readDataWithUrl:(NSString*)url;



@end
