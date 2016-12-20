//
//  HostFetcher.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/18.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostFetcher : NSObject



- (instancetype)initWithURLSession:(NSURLSession *)session notificationCenter:(NSNotificationCenter *)center;

- (void)fetchGithubHome;
- (void)fetchBitbucketHome;

@end
