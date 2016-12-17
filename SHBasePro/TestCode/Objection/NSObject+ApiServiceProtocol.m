//
//  NSObject+ApiServiceProtocol.m
//  SHBasePro
//
//  Created by shenghai on 2016/12/17.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "NSObject+ApiServiceProtocol.h"
#import "ObjectionProtocol.h"
#import "GetApiService.h"
#import "PostApiService.h"
#import "ApiServicePassthrouth.h"

@implementation NSObject (ApiServiceProtocol)

- (void) requestGetNetWithUrl: (NSURL*) url Param: (NSDictionary*) param {
    id<ApiService> apiService = [[JSObjection createInjector] getObject:[GetApiService class]];
    ApiServicePassthrouth* apiServicepassthrough = [[ApiServicePassthrouth alloc] initWithApiService:apiService];
    apiServicepassthrough.ulr = url;
    apiServicepassthrough.param = param;
    [apiServicepassthrough execNetRequest];
}

- (void) requestPostNetWithUrl: (NSURL*) url Param: (NSDictionary*) param {
    id<ApiService> apiService = [[JSObjection createInjector] getObject:[PostApiService class]];
    ApiServicePassthrouth* apiServicepassthrough = [[ApiServicePassthrouth alloc] initWithApiService:apiService];
    apiServicepassthrough.ulr = url;
    apiServicepassthrough.param = param;
    [apiServicepassthrough execNetRequest];
}

@end
