//
//  NSDictionary+MMAddition.h
//  Mami
//
//  Created by lijiarui on 15/4/11.
//  Copyright (c) 2015年 lijiarui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MMAddition)

- (NSString *)    parseStringForKey    :(NSString *)key;
- (NSArray  *)    parseArrayForKey     :(NSString *)key;
- (NSNumber *)    parseNumberForKey    :(NSString *)key;
- (BOOL)          parseBooleanForKey   :(NSString *)key;
- (NSDictionary *)parseDictionaryForKey:(NSString *)key;

@end

@interface NSDictionary (YMJSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data;
- (NSString *)toJSONString;


@end
