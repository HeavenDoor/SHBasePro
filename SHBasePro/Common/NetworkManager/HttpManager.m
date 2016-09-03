//
//  HttpManager.m
//  UUHaoFang
//
//  Created by 符其彬 on 16/4/5.
//  Copyright © 2016年 Haofangtong Inc. All rights reserved.
//

#import "HttpManager.h"
#import "Reachability.h"
//#import "DataCacheManager.h"


// HTTP网络请求默认超时时间
#define kHttpRequestTimeoutInterval 20.0f

@implementation HttpManager

#pragma mark - 单例
+ (HttpManager *)instance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _backGroundUploadManager = [AFHTTPSessionManager manager];
        _backGroundUploadManager.operationQueue.maxConcurrentOperationCount = 1;
        // 设置超时时间
        [_backGroundUploadManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _backGroundUploadManager.requestSerializer.timeoutInterval = kHttpRequestTimeoutInterval;
        [_backGroundUploadManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return self;
}

#pragma mark - 重置响应转换器并设置超时
- (void)resetResponseSerializerWithTimeoutInterval:(NSInteger)timeoutInterval {
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    // 设置超时时间
    _manager.requestSerializer.timeoutInterval = timeoutInterval;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

#pragma mark - 检测是否有网络
- (BOOL)internetStatus {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    switch (internetStatus) {
        case ReachableViaWiFi:
        case ReachableViaWWAN:
            return YES;
        case NotReachable:
        default:
            return NO;
    }
}

#pragma mark - [GET]请求文本数据(仅进行网络请求)
- (void)get:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 调用请求
    [self get:url Params:params WithTimeoutInterval:kHttpRequestTimeoutInterval SuccessfulBlock:successBlock FailBlock:errorBlock];
}

#pragma mark - [GET]请求文本数据(可设置超时)(仅进行网络请求)
- (void)get:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 设置超时
    [self resetResponseSerializerWithTimeoutInterval:timeoutInterval];
    
    // 网络请求
    [_manager GET:url parameters:[self appendBaseParams:params] progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"http-get-progress: %f", downloadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        SAFETY_EXE_BLOCK(successBlock, [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http-get-error: %ld %@", (long)error.code, error.localizedDescription);
        if (errorBlock) {
            // 检测网络
            if ([self internetStatus]) {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", ServerException, (long)error.code]);
            } else {
                //errorBlock([NSString stringWithFormat:@"%@(%ld)", NetworkException, (long)error.code]);
                errorBlock([NSString stringWithFormat:@"%@(%ld)", ServerException , (long)error.code]);
            }
        }
    }];
}

#pragma mark - [GET]请求文本数据(查询缓存数据并进行网络请求)
- (void)get:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock CacheBlock:(CacheBlock)cacheBlock {
    // 获取缓存数据
//    if (cacheBlock) {
//        NSString *data = [[DataCacheManager sharedInstance] getCacheDate:url Params:[self appendBaseParams:params]];
//        if (data.length > 0) {
//            cacheBlock(data);
//        }
//    }
    
    // 调用请求
    [self get:url Params:params SuccessfulBlock:^(id model) {
        SAFETY_EXE_BLOCK(successBlock, model);
//        if (cacheBlock) {
//            // 更新缓存
//            [[DataCacheManager sharedInstance]updateCacheData:url Params:[self appendBaseParams:params] Json:model];
//        }
    } FailBlock:errorBlock];
}

#pragma mark - [GET]请求文本数据(查询缓存数据并进行网络请求)
- (void)post:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 调用请求
    [self post:url Params:params WithTimeoutInterval:kHttpRequestTimeoutInterval SuccessfulBlock:successBlock FailBlock:errorBlock];
}

#pragma mark - [GET]请求文本数据(查询缓存数据并进行网络请求)
- (void)post:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 设置超时
    [self resetResponseSerializerWithTimeoutInterval:timeoutInterval];
    
    // 网络请求
    [_manager POST:url parameters:[self appendBaseParams:params] progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"http-post-progress: %f", uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        SAFETY_EXE_BLOCK(successBlock, [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http-post-error: %ld %@", (long)error.code, error.localizedDescription);
        if (errorBlock) {
            // 检测网络
            if ([self internetStatus]) {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", ServerException, (long)error.code]);
            } else {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", NetworkException, (long)error.code]);
            }
        }
    }];
}

#pragma mark - [POST]提交文本数据(查询缓存数据并进行网络请求)
- (void)post:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock CacheBlock:(CacheBlock)cacheBlock {
    // 获取缓存数据
//    if (cacheBlock) {
//        NSString *data = [[DataCacheManager sharedInstance] getCacheDate:url Params:[self appendBaseParams:params]];
//        if (data.length > 0) {
//            cacheBlock(data);
//        }
//    }
    
    // 调用请求
    [self post:url Params:params SuccessfulBlock:^(id model) {
        SAFETY_EXE_BLOCK(successBlock, model);
//        if (cacheBlock) {
//            // 更新缓存
//            [[DataCacheManager sharedInstance]updateCacheData:url Params:[self appendBaseParams:params] Json:model];
//        }
    } FailBlock:errorBlock];
}

#pragma mark - [POST]提交二进制数据(从磁盘读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params FileName:(NSString*)fileName FilePath:(NSURL*)filePath SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock{
    // 调用请求
    [self postData:url Params:params WithTimeoutInterval:kHttpRequestTimeoutInterval FileName:fileName FilePath:filePath SuccessfulBlock:successBlock FailBlock:errorBlock];
}

#pragma mark - [POST]提交二进制数据(可设置超时)(从磁盘读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval FileName:(NSString*)fileName FilePath:(NSURL*)filePath  SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 设置超时
    [self resetResponseSerializerWithTimeoutInterval:timeoutInterval];
    
    // 网络请求
    [_manager POST:url parameters:[self appendBaseParams:params] constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileURL:filePath name:fileName error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"http-post-file-progress: %f", uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        SAFETY_EXE_BLOCK(successBlock, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            // 检测网络
            if ([self internetStatus]) {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", ServerException, (long)error.code]);
            } else {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", NetworkException, (long)error.code]);
            }
        }
    }];
}

#pragma mark - [POST]提交二进制数据(从内存读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params FileName:(NSString*)fileName FileData:(NSData *)fileData SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 调用请求
    [self postData:url Params:params WithTimeoutInterval:kHttpRequestTimeoutInterval FileName:fileName FileData:fileData SuccessfulBlock:successBlock FailBlock:errorBlock];
}

#pragma mark - [POST]提交二进制数据(可设置超时)(从内存读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval FileName:(NSString*)fileName FileData:(NSData *)fileData SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock {
    // 设置超时
    [self resetResponseSerializerWithTimeoutInterval:timeoutInterval];
    
    // 网络请求
    [_manager POST:url parameters:[self appendBaseParams:params] constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:fileName fileName:fileName mimeType:@"image/jpeg"];
        //[formData appendPartWithFileData:fileData name:@"headimgurl" fileName:fileName mimeType:@"text/plain"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"http-post-file-progress: %f", uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        SAFETY_EXE_BLOCK(successBlock, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            // 检测网络
            if ([self internetStatus]) {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", ServerException, (long)error.code]);
            } else {
                errorBlock([NSString stringWithFormat:@"%@(%ld)", NetworkException, (long)error.code]);
            }
        }
    }];
}

#pragma mark -- 添加基础参数 （设备类型和版本号）
- (NSDictionary *)appendBaseParams:(NSDictionary *)oldParams {
    return oldParams;
//    if (oldParams) {
//        NSArray *keyArray = [oldParams allKeys];
//        NSMutableDictionary *newParamDic = [NSMutableDictionary dictionaryWithDictionary:oldParams];
//        BOOL isVersionIos = [keyArray containsObject:@"versionNo"];
//        BOOL isDevicetype = [keyArray containsObject:@"devicetype"];
//        if (!isVersionIos) {
//            [newParamDic setValue:[SaveEngine getCurrentVersion] forKey:@"versionNo"];
//        }
//        if (!isDevicetype) {
//            [newParamDic setValue:DEVICETYPE forKey:@"devicetype"];
//        }
//        return newParamDic;
//    } else{
//        return @{@"versionNo":[SaveEngine getCurrentVersion],@"devicetype":DEVICETYPE};
//    }
}
@end
