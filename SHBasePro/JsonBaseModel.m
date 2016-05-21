//
//  JsonBaseModel.m
//  OldErp4iOS
//
//  Created by ZTY on 14-4-3.
//  Copyright (c) 2014年 HFT_SOFT. All rights reserved.
//

#import "JsonBaseModel.h"
#include <objc/runtime.h>

@implementation JsonBaseModel

- (id)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super init];
    
    if (self != nil)
    {
        [self setValuesForKeysWithDictionary:jsonDic];
    }
    
    return self;
}

- (id)initWithCacheKey:(NSString *)cacheKey
{
    self = [super init];
    
    if (self != nil)
    {
        [self setValuesForKeysWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:cacheKey]];
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"\n\nUndefined Key : %@\n\n", key);
}


- (NSDictionary *)convertToDictionary
{
    int i;
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    NSMutableDictionary *returnDic = [NSMutableDictionary dictionary];
    
    for ( i=0; i < propertyCount; i++ )
    {
        objc_property_t *thisProperty = propertyList + i;
        const char* propertyName = property_getName(*thisProperty);
        NSString *propertyKeyName = [NSString stringWithUTF8String:propertyName];
        [returnDic setValue:[self valueForKey:propertyKeyName]?[self valueForKey:propertyKeyName] : @""
                     forKey:propertyKeyName];
//        NSLog(@"%@",propertyKeyName);
    }
    return returnDic;
}

@end
