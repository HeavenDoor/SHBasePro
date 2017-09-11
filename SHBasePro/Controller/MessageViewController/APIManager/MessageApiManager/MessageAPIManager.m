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
    return NO;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
//    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
//    [resultParams setObject:@"1" forKey:@"p"];
//    [resultParams setObject:@"latest" forKey:@"tab"];
//    return resultParams;
    return params;
}

#pragma mark - CTAPIManagerValidator 数据校验
- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    if (![data[@"status"] isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}

#pragma mark CTAPIManagerDataReformer protocol 数据转换
- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    // 这里可以实现去Model化  因为Model多了之后很难管理，而且要实现服用必须扯出Model 这里是耦合的，而使用NSDictionary之类的数据就不存在这种耦合
    // 但是呢不用Model查看数据的时候又不直观 目前只有将就着用了
    // 如果要做Model的转换  在这个函数里做  shenghai
    
    // 这里返回类型是(id)也就是说可以产出任意类型的东西 包括 NSDictionary UIview UITableviewCell...
    MovieDatasModel *models = [MovieDatasModel mj_objectWithKeyValues:data];
    return models.data;
}

@end
