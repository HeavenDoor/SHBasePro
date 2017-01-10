//
//  AppDelegate+Push.h
//  DDGoodRoom
//
//  Created by haofangtong on 27/4/16.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "AppDelegate.h"
#import "GeTuiSdk.h"

@interface AppDelegate(Push)<GeTuiSdkDelegate>

- (void)pushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
#pragma mark - 启动GeTuiSdk
- (void)startGeTuiSDK;
@end
