//
//  JsonBaseModel.h
//  OldErp4iOS
//
//  Created by ZTY on 14-4-3.
//  Copyright (c) 2014年 HFT_SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonBaseModel : NSObject
{
    
}

- (id)initWithDictionary:(NSDictionary *)jsonDic;

- (NSDictionary *)convertToDictionary;

- (id)initWithCacheKey:(NSString *)cacheKey;

@end
