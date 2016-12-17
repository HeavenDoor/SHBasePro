//
//  HttpManager.h
//  UUHaoFang
//
//  Created by 符其彬 on 16/4/5.
//  Copyright © 2016年 Haofangtong Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit+AFNetworking.h"
#define ServerException            @"网络异常，请检查您的网络设置" // 网络通，但网络层报错
#define NetworkException           @"没有网络，请检查您的网络设置" // 网络不通
#define ResponseDataException      @"服务器开了个小差，请稍后重试" // 服务器有返回数据，但数据无法解析

#define SAFETY_EXE_BLOCK(A,...) if(A){A(__VA_ARGS__);}
#define EXECUTE_BLOCK(A,...) if(A){A(__VA_ARGS__);}
typedef void (^SuccessfulBlock)(id model);
typedef void (^SuccessfulListBlock)(id model, id param);  
typedef void (^FalieBlock)(id model);
typedef void (^CacheBlock)(id model);

#pragma mark -《HTTP请求封装类》
@interface HttpManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager; // 网络会话管理对象
@property (nonatomic, strong) AFHTTPSessionManager *backGroundUploadManager; // 后台网络会话管理对象

#pragma mark - 单例
+ (HttpManager *)instance;

#pragma mark - 检测是否有网络
- (BOOL)internetStatus;

#pragma mark - [GET]请求文本数据(仅进行网络请求)
- (void)get:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [GET]请求文本数据(可设置超时)(仅进行网络请求)
- (void)get:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [GET]请求文本数据(查询缓存数据并进行网络请求)
- (void)get:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock CacheBlock:(CacheBlock)cacheBlock;

#pragma mark - [GET]请求文本数据(查询缓存数据并进行网络请求)
- (void)post:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [GET]请求文本数据(查询缓存数据并进行网络请求)
- (void)post:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [POST]提交文本数据(查询缓存数据并进行网络请求)
- (void)post:(NSString*)url Params:(NSDictionary*)params SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock CacheBlock:(CacheBlock)cacheBlock;

#pragma mark - [POST]提交二进制数据(从磁盘读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params FileName:(NSString*)fileName FilePath:(NSURL*)filePath  SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [POST]提交二进制数据(可设置超时)(从磁盘读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval FileName:(NSString*)fileName FilePath:(NSURL*)filePath  SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [POST]提交二进制数据(从内存读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params FileName:(NSString*)fileName FileData:(NSData *)fileData SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

#pragma mark - [POST]提交二进制数据(可设置超时)(从内存读取)
- (void)postData:(NSString*)url Params:(NSDictionary*)params WithTimeoutInterval:(NSInteger)timeoutInterval FileName:(NSString*)fileName FileData:(NSData *)fileData SuccessfulBlock:(SuccessfulBlock)successBlock FailBlock:(FalieBlock)errorBlock;

@end