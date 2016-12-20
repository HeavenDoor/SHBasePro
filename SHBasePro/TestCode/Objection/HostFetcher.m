//
//  HostFetcher.m
//  SHBasePro
//
//  Created by shenghai on 2016/12/18.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "HostFetcher.h"

@interface HostFetcher()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

@end

@implementation HostFetcher

- (instancetype) initWithURLSession:(NSURLSession *)session notificationCenter:(NSNotificationCenter *)center {
    if (self = [super init]) {
        self.session = session;
        self.notificationCenter = center;
    }
    return self;
}

- (instancetype) init {
    return [self initWithURLSession:[self session] notificationCenter:[self notificationCenter]];
}

- (NSURLSession *)session
{
    return [NSURLSession sharedSession];
}

- (NSNotificationCenter *)notificationCenter
{
    return [NSNotificationCenter defaultCenter];
}


- (void)fetchGithubHome
{
    NSURLSession *session = [self session];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.github.com"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *userInfo = @{ @"data": data,
                                    @"response": response,
                                    @"error": error };
        [[self notificationCenter] postNotificationName:@"BNRGithubFetchCompletedNotification" object:self userInfo:userInfo];
    }];
    [task resume];
}

- (void)fetchBitbucketHome
{
    NSURLSession *session = [self session];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://www.bitbucket.org"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *userInfo = @{ @"data": data,
                                    @"response": response,
                                    @"error": error };
        [[self notificationCenter]  postNotificationName:@"BNRBitbucketFetchCompletedNotification" object:self userInfo:userInfo];
    }];
    [task resume];
}

@end
