//
//  AppDelegate+Push.m
//  UUHaoFang
//
//  Created by haofangtong on 27/4/16.
//  Copyright © 2016年 Mi. All rights reserved.
//

#define kGtAppId     @"bnBfkrYuEc9UTy44Dl4P11"
#define kGtAppKey    @"b2eixkAlQN9bsIIfAyFXD7"
#define kGtAppSecret @"i3mB6QIaIVAcicsmh3FmJ3"

#import "AppDelegate+Push.h"

@implementation AppDelegate(Push)

- (void)pushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 判断是否是从推送进入
    NSDictionary* remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(remoteNotification) {
        //[[DefaultService getInstance] analysisNotify:remoteNotification type:PushType_Init];
    }
    [self startGeTuiSDK];
    [self registerRemoteNotification];
}

- (void)startGeTuiSDK {
    [self startSdkWith:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret];
}

#pragma mark - 启动GeTuiSdk
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
    //该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self];
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    //[1-3]:设置电子围栏功能，开启LBS定位服务 和 是否允许SDK 弹出用户定位请求
    [GeTuiSdk lbsLocationEnable:NO andUserVerify:NO];
}

#pragma mark - 用户通知(推送) _自定义方法
- (void)registerRemoteNotification {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //[5] Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

/** 远程通知注册成功委托 */

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

#pragma mark - 远程通知(推送)回调
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground)
    {
        //[[DefaultService getInstance] analysisNotify:userInfo type:PushType_BackGroud];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",token);
//    UserDefaultSetObjectForKey(token, @"DEVICETOKEN");
//    UserDefaultSetObjectForKey(deviceToken, @"ORIG_DEVICETOKEN");
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"ORIG_DEVICETOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    // [3]:向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceToken:token];
    
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //    [_viewController logMsg:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
}


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId 传给后台做推送用
    NSLog(@">>>不是缓存的ciid ===== [GeTuiSdk RegisterClient]:%@", clientId);
    
    //UserDefaultSetObjectForKey(clientId, @"DEVICECID");
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"ORIG_DEVICETOKEN"];
    
    //NSLog(@">>>[GeTuiSdk RegisterClient缓存的等于===========]:%@", UserDefaultObjectForKey(@"DEVICECID"));

    [GeTuiSdk registerDeviceToken:token];
}
/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData
                            andTaskId:(NSString *)taskId
                             andMsgId:(NSString *)msgId
                           andOffLine:(BOOL)offLine
                          fromGtAppId:(NSString *)appId {
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
                                              length:payloadData.length
                                            encoding:NSUTF8StringEncoding];
    }
    NSString *msg = [NSString stringWithFormat:@"%@", payloadMsg];
    NSLog(@"GexinSdkReceivePayload : %@", msg);
    // 汇报个推自定义事件
    //    [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:msgId];
//    NSDictionary *dic = [msg mj_JSONObject];
//    if (!offLine) {
//        [[DefaultService getInstance] analysisNotify:dic type:PushTypeActivity];
//    } else{
//        [[DefaultService getInstance] analysisNotify:dic type:PushTypeActivity];
//    }
    [GeTuiSdk resetBadge];
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    NSLog(@"messageId === %@",messageId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    NSLog(@"error === %@",error);
    [self startGeTuiSDK];
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    
}

//SDK设置推送模式回调
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    
}

@end
