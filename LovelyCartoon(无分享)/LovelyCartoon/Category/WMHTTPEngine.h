//
//  WMHTTPEngine.h
//  Demo6_MyHttpEngine
//
//  Created by qianfeng on 16/3/3.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Success)(id responseObject);

typedef void(^Failure)(NSError *error);
@interface WMHTTPEngine : NSObject

//获取 单例 的对象

+(instancetype)shareManager;

//发起get请求的方法
- (void)GET:(NSString *)url params:(NSDictionary*)params success:(Success)success failure:(Failure)failure;

//发起普通post请求的方法
- (void)POST:(NSString *)url params:(NSDictionary*)params success:(Success)success failure:(Failure)failure;

@end
