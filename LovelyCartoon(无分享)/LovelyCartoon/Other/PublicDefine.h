//
//  PublicDefine.h
//  LovelyCartoon
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 王梦良. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

//高
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
//宽
#define WIDTH [[UIScreen mainScreen] bounds].size.width

#define GlobalScale [APPGlobalScale myAppSizeScale]

#define GlobalHeightScale [APPGlobalScale iPhone4HeightScale]

#define MainColor [UIColor colorWithRed:252/255.0 green:69/255.0 blue:96/255.0 alpha:1.0]


//服务器地址开头
#define PUBLIC_SERVER_IP  @""


//文档路径
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]
//大文件存放路径
#define LIBRARY_PATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0]
//缓存文件路径
#define CACHES_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0]



//===================系统颜色定义.Start===============//
#define APPBackgroundColor @"f2f2f2"  //背景
//===================系统颜色定义.End===============//


//切换打印方法，可以不占资源
//=============重置DEBUG.Start===============//
#define CC_DEBUG
#ifdef CC_DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#endif
//=============重置DEBUG.End===============//


//友盟KEY    56fe546b67e58e97500004d3
#define UmengAppkey @"53290df956240b6b4a0084b3"



#endif /* PublicDefine_h */
