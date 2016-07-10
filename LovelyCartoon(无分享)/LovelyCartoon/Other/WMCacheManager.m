//
//  WMCacheManager.m
//  MyApp
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMCacheManager.h"
#import "NSString+Hashing.h" //分类

@implementation WMCacheManager

//保存对象（如果是自定义对象，需要遵守NSCoding协议）如果对象继承自JSONModel就不用遵守协议（它本身已经遵守了）
//保存二进制数据，以url为唯一标识
//data就是需要保存的数据
//url 是唯一标识
+(void)saveData:(id)data url:(NSString*)url{
//    [data writeto];
    //url需要一次加密
    //文件保存路径
    NSString *savePath = [WMCacheManager fullPathWithUrl:url];
//    [data writetofile];
    //把id转化为二进制数据
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:data];
    BOOL res = [saveData writeToFile:savePath atomically:YES];
    if (res) {
        NSLog(@"写入成功");
    }else{
        NSLog(@"写入失败");
    }

}

//根据url生成一个最终的文件保存路径
+(NSString*)fullPathWithUrl:(NSString*)url{
    //url加密  md5加密
    NSString *md5Str = [url MD5Hash];
    NSString *cacheDir = [WMCacheManager cacheDir];
    //返回最终的文件保存路径
    return [cacheDir stringByAppendingPathComponent:md5Str];
}

//文件缓存的目录
+(NSString*)cacheDir{
    //一般情况下 沙盒里面提供了一个缓存的目录 Library/caches/wmcache
    //获取沙盒cache的路径
    NSString *cacheTemp = [NSString stringWithFormat:@"%@/Library/caches/wmcache", NSHomeDirectory()];
    //如果不存在就会去创建，不会覆盖
    BOOL res = [[NSFileManager defaultManager] createDirectoryAtPath:cacheTemp withIntermediateDirectories:YES attributes:nil error:nil];
    if (res == NO) {
        return nil;
    }
    return cacheTemp;
}


//读取二进制数据，url是唯一标识 返回二进制数据
+(id)readDataWithUrl:(NSString*)url{

//    url  转为 最终的地址
    NSString *path = [WMCacheManager fullPathWithUrl:url];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data == nil) {
        NSLog(@"读取数据失败");
        return nil;
    }else{
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

@end
