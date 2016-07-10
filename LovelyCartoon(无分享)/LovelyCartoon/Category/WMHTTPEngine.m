//
//  WMHTTPEngine.m
//  Demo6_MyHttpEngine
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import "WMHTTPEngine.h"
#import "AFNetworking.h"

@interface WMHTTPEngine ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation WMHTTPEngine

//获取 单例 的对象

+(instancetype)shareManager{
    static WMHTTPEngine *httpEngine = nil;
//    GCD 语法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        把对象初始化了
        NSLog(@"只会调用一次");
        httpEngine = [[WMHTTPEngine alloc] init];
    });
    
    return httpEngine;
}

- (instancetype)init{
    if (self = [super init]) {
//        初始化AFNetworking
        _manager = [AFHTTPSessionManager manager];
        //响应解析器就可以不设置，用默认的json
//        消除服务器返回的数据类型  根content- type字段不一致的影响
        NSMutableSet *set = [NSMutableSet setWithSet:_manager.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        _manager.responseSerializer.acceptableContentTypes = set;
        
    }
    return self;
}


//发起get请求的方法
- (void)GET:(NSString *)url params:(NSDictionary*)params success:(Success)success failure:(Failure)failure{
    
    [_manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        说明数据请求成功
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            
            failure(error);
        }
        
    }];
    

}

//发起普通post请求的方法
- (void)POST:(NSString *)url params:(NSDictionary*)params success:(Success)success failure:(Failure)failure{

    [_manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
        //        说明数据请求成功
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            
            failure(error);
        }
        
    }];
    
    
}

@end
