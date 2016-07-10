//
//  NSDictionary+MMAddition.m
//  Mami
//
//  Created by lijiarui on 15/4/11.
//  Copyright (c) 2015年 lijiarui. All rights reserved.
//

#import "NSDictionary+MMAddition.h"

@implementation NSDictionary (MMAddition)


- (NSString *)parseStringForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }else if ([object isKindOfClass:[NSNumber class]]){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        object = [formatter stringFromNumber:object];
        return object;
    }
    return nil;
}

- (BOOL)parseBooleanForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object boolValue];
    }
    return NO;
}

- (NSNumber *)parseNumberForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }else if([object isKindOfClass:[NSString class]]){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        object = [formatter numberFromString:object];
        return object;
    }
    return nil;
}

- (NSArray *)parseArrayForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
    return nil;
}

- (NSDictionary *)parseDictionaryForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    return nil;
}

@end

@implementation NSDictionary (YMJSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data
{
    NSError *error;
    if (data == nil) return [[NSDictionary alloc] init];
    if ([data length] <= 0) return [[NSDictionary alloc] init];
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers
                                             error:&error];
    
}

- (NSString *)toJSONString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
}

@end
