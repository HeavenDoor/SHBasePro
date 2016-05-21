//
//  AppDelegate.m
//  Test_Suteng3
//
//  Created by  suteng on 16/2/17.
//  Copyright © 2016年 suteng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Reachability.h"

@interface AppDelegate ()
@property (nonatomic, strong) Reachability* reachability;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    ViewController*VC=[[ViewController alloc]init];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:VC];
    [self.window makeKeyAndVisible];
    self.window.rootViewController=nav;
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    //[[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"NetworkStatus" options:NSKeyValueObservingOptionNew context:NULL];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_reachability startNotifier];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//
- (void) netWorkStatusChanged: (NSNotification* )note
{
    Reachability* reachability = note.object;
    
    if (![reachability isKindOfClass: [Reachability class]]) {
        return;
    }
    NetworkStatus status = reachability.currentReachabilityStatus;
    if (status == NotReachable)
    {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkStatus"] isEqualToString:@"0"])
        {
            NSLog(@"悲剧，无网络可用诶");
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"NetworkStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    else if (status == ReachableViaWiFi)
    {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkStatus"] isEqualToString:@"2"])
        {
            NSLog(@"哇塞，连上了WIFI诶");
            [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"NetworkStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    else if (status == ReachableViaWWAN)
    {
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"NetworkStatus"] isEqualToString:@"1"])
        {
            NSLog(@"唉，只有用流量上网了");
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"NetworkStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

@end
