//
//  ApiServicePassthrouth.m
//  SHBasePro
//
//  Created by shenghai on 2016/12/17.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "ApiServicePassthrouth.h"

@interface ApiServicePassthrouth ()

@property (nonatomic, strong) id<ApiService> apiService;

@end

@implementation ApiServicePassthrouth

- (void) execNetRequest {
    NSLog(@"开始网络请求了");
    [self.apiService requestNetWithUrl: self.ulr Param: self.param];
}

- (instancetype) initWithApiService: (id<ApiService>) apiService {
    if (self = [super init]) {
        self.apiService = apiService;
    }
    return self;
}

@end
