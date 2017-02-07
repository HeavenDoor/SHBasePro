//
//  GDMapService.m
//  CTNetworking
//
//  Created by casa on 16/4/12.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "GDMapService.h"
#import "CTAppContext.h"

@implementation GDMapService

#pragma mark - CTServiceProtocal
- (BOOL)isOnline
{
    return [CTAppContext sharedInstance].isOnline;
}

- (NSString *)offlineApiBaseUrl
{
    return @"http://app.vmoiver.com/apiv3/post/getPostByTab";
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://app.vmoiver.com/apiv3/post/getPostByTab";
}

- (NSString *)offlineApiVersion
{
    return @"";
}

- (NSString *)onlineApiVersion
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlinePublicKey
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)offlinePrivateKey
{
    return @"";
}

@end
