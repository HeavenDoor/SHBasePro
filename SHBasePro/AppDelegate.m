//
//  AppDelegate.m
//  shenghai
//
//  Created by  shenghai on 16/2/17.
//  Copyright © 2016年 shenghai. All rights reserved.
//

#import "AppDelegate.h"
#import "HcdGuideViewManager.h"
//#import "Reachability.h"
#import "RDVTabBarItem.h"
#import "TestViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DataViewController.h"
#import "MineViewController.h"
#import "UIImage+GIF.h"
#import <objc/runtime.h>// 导入运行时文件
#import "CenterViewController.h"
#import "AppHelper.h"
#import "AppDelegate+Push.h"
#import "Aspects.h"
#import "NSObject+RunTime.h"
#import <objc/runtime.h>
#import "SHSingleton.h"
#import "UncaughtExceptionHandler.h"
#import "MapViewController.h"
#import "NSTimer+Block.h"
#import <QMapKit/QMapKit.h>
#import <QMapSearchKit/QMapSearchKit.h>
//#import "AlipayHeader.h"
//#import "WXApi.h"
#import "GModel.h"
#import "GModel+ATest.h"
#import "GModel+BTest.h"
#import "TestViewController.h"
#import "NetworkReachabilityManager.h"

#import "ComplexDealCenter.h"


@interface AppDelegate () <RDVTabBarControllerDelegate>  //WXApiDelegate,
{
    NSString* aaa OBJC_ISA_AVAILABILITY;
}

@property (nonatomic, strong) UINavigationController *rootViewController;

@property (nonatomic, strong) AppHelper* appHelper;
//@property (nonatomic, strong) Reachability* reachability;
@property (nonatomic, strong) HomeViewController* homeViewController;
@property (nonatomic, strong) MessageViewController* messageViewController;
@property (nonatomic, strong) DataViewController* dataViewController;
@property (nonatomic, strong) MineViewController* mineViewController;

@property (nonatomic, strong) UINavigationController* homeNavigationController;
@property (nonatomic, strong) UINavigationController* dataNavigationController;
@property (nonatomic, strong) UINavigationController* msgNavigationController;
@property (nonatomic, strong) UINavigationController* mineNavigationController;

@property (nonatomic, strong) id<PayCenterInterfaceProtocol, PayCenterCallBackProtocol, PayCenterInterfaceProtocol> payCenter;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"1========%@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2========%@",[NSThread currentThread]);
    });
    NSLog(@"3========%@",[NSThread currentThread]);
    

    UIImage *img = [UIImage imageNamed:@"Image1"];
    NSData * imageData = UIImageJPEGRepresentation(img, 1);
    
    CGFloat length = [imageData length]/1024;
    
    
    NSError *error;
    [TestViewController aspect_hookSelector:@selector(testggwp) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){

        NSLog(@"TestViewController 在这里干坏事了");
        
    }error:&error];
        
    GModel *gmodel = [[GModel alloc] init];
    [gmodel performSelectorOnMainThread:@selector(ggwp) withObject:nil waitUntilDone:YES];
    
    NSString *apro = [[NSString alloc] initWithString:@"123"];
    NSString *bpro = [[NSString alloc] initWithString:@"456"];
    gmodel.aPro = apro;
    gmodel.bPro = bpro;
    
    GModel *mmdel = [gmodel copy];
    mmdel.aPro = @"shenghai";
    
    // 抓崩溃
    InstallUncaughtExceptionHandler();
    // 统计
    [self GGWPAnalyse];
    SHSingleton *sig = [[SHSingleton alloc] init];
    SHSingleton *ggg = [SHSingleton sharedInstance];
    
    unsigned int outCount = 0;
    Method* method = class_copyMethodList(self.class, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method* md = method[i];
        NSString* mdName = [NSString stringWithCString:method_getName(md)];
        NSLog(@"%@", mdName);
    }
    
    self.appHelper = [[AppHelper alloc] init];
    [self.appHelper startJSPatch];
    
    [QMapServices sharedServices].apiKey = @"QHGBZ-OYPLD-2RB4R-PEE3A-MGPJ2-UKBA4";
    [QMSSearchServices sharedServices].apiKey = @"QHGBZ-OYPLD-2RB4R-PEE3A-MGPJ2-UKBA4";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [NSThread sleepForTimeInterval:0.5];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStatusChanged:) name:kReachabilityChangedNotification object:nil];
//    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    [_reachability startNotifier];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [self setRDVTabBarRootViewController];
    // 创建3DTouch
    [self create3DTouch];
    
    //根据版本号来判断是否需要显示引导页，一般来说每更新一个版本引导页都会有相应的修改
    BOOL show = [userDefaults boolForKey:[NSString stringWithFormat:@"version_%@", version]];
    
    if (show) {
        [self showWelcomePage];
        [userDefaults setBool:NO forKey:[NSString stringWithFormat:@"version_%@", version]];
        [userDefaults synchronize];
    }
    
    [self pushApplication:application didFinishLaunchingWithOptions:launchOptions];
    //[WXApi registerApp:WeChatID];
    
    [NetworkReachabilityManager listenNetWorkingStatus:^(HFTNetworkStatus status) {
        switch (status) {
            case HFTNetworkStatusUnknown:
                NSLog(@"AppDelegate  未知网络");
                break;
            case HFTNetworkStatusNotReachable:
                NSLog(@"AppDelegate  没有联网");
                break;
            case HFTNetworkStatusReachableViaWWAN:
                NSLog(@"AppDelegate  蜂窝数据");
                break;
            case HFTNetworkStatusReachableViaWiFi:
                NSLog(@"AppDelegate 无线网");
                break;
            default:
                break;
        }
    }];
    return YES;
}


- (void) showWelcomePage
{
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"1"]];
    [images addObject:[UIImage imageNamed:@"2"]];
    [images addObject:[UIImage imageNamed:@"3"]];
    
    [[HcdGuideViewManager sharedInstance] showGuideViewWithImages:images andButtonTitle:@"立即体验"
                                              andButtonTitleColor:[UIColor whiteColor]
                                                 andButtonBGColor:[UIColor clearColor]
                                             andButtonBorderColor:[UIColor whiteColor]];
}

- (void) setRDVTabBarRootViewController
{
    _homeViewController = [[HomeViewController alloc] init];
    _homeNavigationController = [[UINavigationController alloc] initWithRootViewController:_homeViewController];
    _homeNavigationController.navigationBar.hidden = YES;
    
    _dataViewController = [[DataViewController alloc] init];
    _dataNavigationController = [[UINavigationController alloc] initWithRootViewController:_dataViewController];
    _dataNavigationController.navigationBar.hidden = YES;
    
    _messageViewController = [[MessageViewController alloc] init];
    _msgNavigationController = [[UINavigationController alloc] initWithRootViewController:_messageViewController];
    _msgNavigationController.navigationBar.hidden = YES;
    
    _mineViewController = [[MineViewController alloc] init];
    _mineNavigationController = [[UINavigationController alloc] initWithRootViewController:_mineViewController];
    _mineNavigationController.navigationBar.hidden = YES;
    
    self.tabbarController = [[RDVTabBarController alloc] init];
    self.tabbarController.delegate = self;
    self.tabbarController.tabbarType = RDVTabType_Custom;
    [self.tabbarController setViewControllers:@[_homeNavigationController, _dataNavigationController, _msgNavigationController, _mineNavigationController]];

    [self customizeTabBarForController:self.tabbarController];
    
    self.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.tabbarController];
    [self.rootViewController setNavigationBarHidden:YES];
    [self.window setRootViewController:self.rootViewController];
    [self.window makeKeyAndVisible];
    [self customizeInterface];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages = @[@"home", @"data", @"tb_qd_", @"msg", @"mine"];
    NSArray *tabBarItemNames = @[@"首页", @"数据", @"  ", @"消息", @"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items])
    {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        if (index == 2)
        {
            selectedimage = [UIImage imageNamed:@""];
            unselectedimage = [UIImage imageNamed:@""];
        }
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.title = tabBarItemNames[index];
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                         NSForegroundColorAttributeName:kColor(79, 170, 248),
                                         };
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                           NSForegroundColorAttributeName: kColor(200, 200, 200),
                                           };
        index++;
    }
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor  = kColor(185, 185, 185); //  alpha:0.5
    [[tabBarController tabBar] addSubview:lineLabel];
    [[tabBarController tabBar] setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
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
    
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
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
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ForGroundAction" object:nil];
    [_payCenter restoreSceneOfWeChatPay];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"asdf" message:@"asdfasdf" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options {
    if ([url.host isEqualToString:@"safepay"]) {
        LazyWeakSelf;
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            [weakSelf.payCenter aliPayCallBack:resultDic];
//        }];
//        return YES;
//    } else if ([url.relativeString rangeOfString:@"//pay/"].location != NSNotFound) {
//        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

#pragma mark - 微信支付回调
//-(void)onResp:(BaseResp *)resp {
//    if ([resp isKindOfClass:[PayResp class]]) {
//        PayResp *response = (PayResp *)resp;
//        switch (response.errCode) {
//            case WXSuccess: {
//                [_payCenter WeChatPayCallBackSuccess];
//                break;
//            }
//            default: {
//                [_payCenter callWeChatPayCallBackFaile:response.errStr];
//                break;
//            }
//        }
//    }
//}



/*- (void) netWorkStatusChanged: (NSNotification* )note
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
}*/

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void) grabButtonTriggered
{
    [[ComplexDealCenter sharedInstance] triggerd:@"shenghairen"];

    [self.tabbarController stopJDAnimation];
    CenterViewController *vc = [[CenterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav setNavigationBarHidden:YES];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.rootViewController presentViewController: nav animated:YES completion:nil];
}

+ (AppDelegate*) sharedInstance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (id<PayCenterInterfaceProtocol, PayCenterCallBackProtocol, PayCenterInterfaceProtocol>)payCenter {
    if (_payCenter == nil) {
        _payCenter = [[PayCenter alloc] init];
    }
    return _payCenter;
}

- (void)GGWPAnalyse {
    NSString *clsName = @"CenterViewController";
    NSString * sel = @"backTestBtnAction:";

    [NSClassFromString(clsName) aspect_hookSelector:NSSelectorFromString(sel) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        //NSLog(@"ggwp ==============");
        NSString *str = NSStringFromSelector([aspectInfo originalInvocation].selector);
        //NSLog(@"%@", aspectInfo);
        NSUInteger numberOfArguments = [aspectInfo originalInvocation].methodSignature.numberOfArguments;
        for (int i = 0; i < numberOfArguments; i++) {
            const char *myChar = [[aspectInfo originalInvocation].methodSignature getArgumentTypeAtIndex:i];
            NSString *string = [NSString stringWithFormat:@"%c", myChar];
            NSLog(string);
        }
        NSLog(@"ggwp ==============");
        
    }error:nil];
    
}
@end
