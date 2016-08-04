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
#import "RDVTabBarItem.h"

@interface AppDelegate ()
@property (nonatomic, strong) Reachability* reachability;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [NSThread sleepForTimeInterval:2.0];
    
    
    
//    ViewController *VC = [[ViewController alloc]init];
//    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:VC];
//    
//    self.window.rootViewController = nav;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_reachability startNotifier];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [self setRDVTabBarRootViewController];
    // 创建3DTouch
    [self create3DTouch];
    
    
    return YES;
}

- (void) setRDVTabBarRootViewController
{
    UIViewController *firstViewController = [[UIViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[UIViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[UIViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    self.tabbarController = [[RDVTabBarController alloc] init];
    [self.tabbarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController]];
    
    
    
    
    [self customizeTabBarForController:self.tabbarController];
    
    [self.window setRootViewController:self.tabbarController];
    [self.window makeKeyAndVisible];
    [self customizeInterface];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

// 创建3Dtouch
- (void)create3DTouch
{
    // 系统版本为IOS 9.0以上才会支持3d Touch
    if (IOS_VER_9)
    {
        NSArray *items = [UIApplication sharedApplication].shortcutItems;
        // 判断是不是已经创建了3d Touch
        if (items.count == 0)
        {
            [self setup3DTouch];
        }
    }
}

- (void) setup3DTouch
{
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"fx_3DTouch_AdorableStar"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"fx_3DTouch_Search_brand"];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"fx_3DTouch_Receipt_of_goods"];
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"fx_3DTouch_Star_Ticket"];
    
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.51fanxing.adorableStar" localizedTitle:@"萌星说" localizedSubtitle:nil icon:icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.51fanxing.searchBrand" localizedTitle:@"搜品牌" localizedSubtitle:nil icon:icon2 userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.51fanxing.receiptOfGoods" localizedTitle:@"查物流" localizedSubtitle:nil icon:icon3 userInfo:nil];
    UIMutableApplicationShortcutItem *item4 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.51fanxing.starTicket" localizedTitle:@"摇星券" localizedSubtitle:nil icon:icon4 userInfo:nil];
    
    NSArray *items = [NSArray arrayWithObjects:item1,item2,item3,item4, nil];
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:items];
    [UIApplication sharedApplication].shortcutItems = updatedItems;
}

// 3Dtouch 响应事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    // 判断先前我们设置的唯一标识
    if([shortcutItem.type isEqualToString:@"com.51fanxing.adorableStar"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"第一条" message:@"萌星说" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if ([shortcutItem.type isEqualToString:@"com.51fanxing.searchBrand"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"第二条" message:@"搜品牌" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    else if ([shortcutItem.type isEqualToString:@"com.51fanxing.receiptOfGoods"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"第三条" message:@"查物流" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if ([shortcutItem.type isEqualToString:@"com.51fanxing.starTicket"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"第四条" message:@"摇星券" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
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

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
