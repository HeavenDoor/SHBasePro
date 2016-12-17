//
//  ApiServicePassthrouth.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/17.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiService.h"

@interface ApiServicePassthrouth : NSObject

@property (nonatomic, strong) NSURL* ulr;
@property (nonatomic, strong) NSDictionary* param;

- (instancetype) initWithApiService: (id<ApiService>) apiService;
- (void) execNetRequest;

@end
