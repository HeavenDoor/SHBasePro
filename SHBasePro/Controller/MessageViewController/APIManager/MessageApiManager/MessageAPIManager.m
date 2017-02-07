//
//  MessageAPIManager.m
//  SHBasePro
//
//  Created by shenghai on 2017/2/6.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "MessageAPIManager.h"
#import "MovieModel.h"

@interface MessageAPIManager() <CTAPIManagerValidator>

@end

@implementation MessageAPIManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)methodName {
    return @"apiv3/post/getPostByTab";
}

- (NSString *)serviceType {
    return kCTServiceGDMapV3;
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypeGet;
}

- (BOOL)shouldCache {
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    [resultParams setObject:@"1" forKey:@"p"];
    [resultParams setObject:@"latest" forKey:@"tab"];
    return resultParams;
}

#pragma mark - CTAPIManagerValidator
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    if (![data[@"status"] isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}

#pragma mark CTAPIManagerDataReformer protocol
- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    MovieDatasModel *models = [MovieDatasModel mj_objectWithKeyValues:data];
    return models.data;
}

@end
