//
//  HomeViewController.m
//  SHBasePro
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "HomeViewController.h"
#import "DataViewControllerMVVM.h"

#import "NSObject+ApiServiceProtocol.h"
#import "PayCenterProtocol.h"


#import "PaymentView.h"
#import "MongoliaView.h"

#import "PayCenterHeader.h"

#import "PayParamsGenerator.h"
#import "MapParamsGenerator.h"


#import "UIImageView+GIF.h"
#import "UIImage+GIF.h"

#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <objc/runtime.h>

#import "CenterViewController.h"

//#import "TestViewController+AT.h"
//#import "TestViewController+BT.h"


#import "ATViewController.h"
#import "BTViewController.h"
#import "Aspects.h"
#import "NetworkReachabilityManager.h"

#import "ComplexDealCenter.h"
#import "TestLoginViewController.h"


//#import "CVWrapper.h"

@interface HomeViewController () <PayCenterProtocol, ComplexDealProtocol>

@property (strong, nonatomic) UIImageView* bgImg;
@property (strong, nonatomic) UIButton* msgBtn;

@property (strong, nonatomic) UIButton* mvvmBtn;


@property (strong, nonatomic) UIImageView* loadingImg;

@property (nonatomic, strong) CLLocationManager *mgr;

@property (nonatomic, strong) NSError *error;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
//    for (int i =0; i < 5; i++) {
//        CenterViewController *vc2 = [[CenterViewController alloc] init];
//        [self.navigationController pushViewController:vc2 animated:YES];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ComplexDealCenter sharedInstance] addDelegate:self];

    _error = [[NSError alloc] initWithDomain:@"CCCC" code:300 userInfo:@{@"AAA":@"BBB"}];
    objc_setAssociatedObject(_error, @"AAAAA", @"500", OBJC_ASSOCIATION_COPY);
    self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homebg"]];
    self.bgImg.frame = self.view.frame;
    [self.view addSubview:self.bgImg];
    
    
    {
        [self requestGetNetWithUrl:[NSURL URLWithString:@"http://www.baidu.com"] Param:@{@"KEY1": @"sheng", @"KEY2": @"hai"}];
        
        [self requestPostNetWithUrl:[NSURL URLWithString:@"http://www.baidu.com"] Param:@{@"KEY1": @"sheng", @"KEY2": @"hai"}];
    }
    
    
    self.msgBtn = [[UIButton alloc] init];
    self.msgBtn.backgroundColor = [UIColor grayColor];
    self.msgBtn.layer.borderWidth = 1;
    self.msgBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.msgBtn.layer.cornerRadius = 4;
    [self.msgBtn setTitle:@"objection" forState:UIControlStateNormal];
    [self.msgBtn setTitle:@"bbbb" forState:UIControlStateNormal];
    [self.msgBtn addTarget:self action:@selector(objectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.msgBtn];
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(0.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
    //self.msgBtn.enabled = NO;
    
    self.mvvmBtn = [[UIButton alloc] init];
    self.mvvmBtn.backgroundColor = [UIColor grayColor];
    self.mvvmBtn.layer.borderWidth = 1;
    self.mvvmBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.mvvmBtn.layer.cornerRadius = 4;
    [self.mvvmBtn setTitle:@"MVVM" forState:UIControlStateNormal];
    [self.mvvmBtn addTarget:self action:@selector(mvvmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mvvmBtn];
    [self.mvvmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(1.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
    
//    _loadingImg = [[UIImageView alloc] init];
//    [self.view addSubview:_loadingImg];
//    [_loadingImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.width.equalTo(@200);
//        make.height.mas_equalTo(@140);
//    }];
    //[_loadingImg sd_setImageWithURL:[NSURL URLWithString:@"http://192.168.11.112/aa.png"] placeholderImage:[UIImage imageNamed:@"本店"] options:SDWebImageRefreshCached];
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"aa" ofType:@"gif"];
//    NSData  *imageData = [NSData dataWithContentsOfFile:path];
//    [_loadingImg setImageWithURL:[NSURL URLWithString:@"http://192.168.11.112/aa.png"] placeholderImage:[UIImage sd_animatedGIFWithData:imageData] failedImage:[UIImage imageNamed:@"homebg"] options:SDWebImageCacheMemoryOnly];
    
//    [_loadingImg sd_setImageWithURL:[NSURL URLWithString:@"http://uuhf.vfanghui.com/uuhfWeb/wfUserManager/downLoadHeadPic?youyouUserId=230290&type=1"] placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image == nil) {
//            NSLog(@"图片下载失败");
//        }
//    }];
    
    [[PayCenter sharedPayCenter] setPayCenterDelegate:self];
    
    [NetworkReachabilityManager listenNetWorkingStatus:^(HFTNetworkStatus status) {
        switch (status) {
            case HFTNetworkStatusUnknown:
                NSLog(@"HomeViewController  未知网络");
                break;
            case HFTNetworkStatusNotReachable:
                NSLog(@"HomeViewController  没有联网");
                break;
            case HFTNetworkStatusReachableViaWWAN:
                NSLog(@"HomeViewController  蜂窝数据");
                break;
            case HFTNetworkStatusReachableViaWiFi:
                NSLog(@"HomeViewController 无线网");
                break;
            default:
                break;
        }
    }];
    
}

- (void)onComplexEventDealt:(NSString *)result {
    NSLog(@"%@ onComplexEventDealt Result: %@", [self class], result);
}


- (BOOL)locationAuthorized {
    BOOL isAuthorized = NO;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        isAuthorized = NO;
    } else if (kCLAuthorizationStatusNotDetermined == status) {
        if (_mgr == nil) {
            _mgr = [CLLocationManager new];
        }
        
        [_mgr requestWhenInUseAuthorization];
        isAuthorized = NO;
    } else { //开启的
        isAuthorized = YES;
    }
    return NO;
}

- (void)dealloc {
    NSLog(@"=====%@被销毁了=====", [self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)test {
    NSLog(@"=====%@ Test... =====", [self class]);
}

- (void) objectionAction: (UIButton*) sender {
    TestLoginViewController *vc = [[TestLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
//    for (int i = 0; i < 10; i++) {
//        CenterViewController *vc = [[CenterViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//        [vc.navigationController popViewControllerAnimated:YES];
//    }
    
//    sleep(0.3);
//    
//    CenterViewController *vc1 = [[CenterViewController alloc] init];
//    [self.navigationController pushViewController:vc1 animated:YES];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CenterViewController *vc2 = [[CenterViewController alloc] init];
//        [self.navigationController pushViewController:vc2 animated:YES];
//    });
    
    //[vc.navigationController popViewControllerAnimated:YES];
    
    //[[ComplexDealCenter sharedInstance] removeDelegate:self];
    /*
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    Method *method = class_copyMethodList([ATViewController class], &count);
    for (int i = 0; i < count; i++) {
        Method meth = method[i];
        SEL sel = method_getName(meth);
        const char *name = sel_getName(sel);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [array addObject:nameStr];
        
    }
    
    
    TestViewController * aa = [[TestViewController alloc] init];
    [aa test];
    */
////    @autoreleasepool
////    {
//        for (int i = 0; i < MAXFLOAT; i++) {
//            UILabel *label = [[UILabel alloc] init];
//        }
////    }
//    
//    
//    return;
//    NSString *ssss = objc_getAssociatedObject(_error, @"AAAAA");
//    
//    //[self locationAuthorized];
//    
//    NSMutableArray *array = [NSMutableArray array];
//    NSString *sss = array[1];
//    
//    return;
//    
//    CustomCameraViewController *customCameraViewVC = [[CustomCameraViewController alloc] initWithNibName:@"CustomCameraViewController" bundle:[NSBundle mainBundle]];
//    customCameraViewVC.pictureNumber = 4;
//    customCameraViewVC.couldSubmit = NO;
//    [self.navigationController pushViewController:customCameraViewVC animated:YES];
//    
//    
    
    //NSArray *imageArray = [_cameraView getAllImages];
    
//    _loadingImg = [[UIImageView alloc] init];
//    [self.view addSubview:_loadingImg];
//    [_loadingImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.width.equalTo(self.view.mas_width);
//        make.height.mas_equalTo(@200);
//    }];
    
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //NSArray *array = @[[UIImage imageNamed:@"s1"],[UIImage imageNamed:@"sh2"],[UIImage imageNamed:@"sh3"],[UIImage imageNamed:@"sh4"]];
//        NSArray *array = @[[UIImage imageNamed:@"ss1.jpg"],[UIImage imageNamed:@"ss2.jpg"]];
//        UIImage *image = [CVWrapper processWithArray:array];
//        if (image != nil) {
//            _loadingImg.image = image;
//        } else {
//            NSLog(@"图片合成失败");
//        }
//    });
//    
    
    
    
    
    
    
//    UIViewController <DataViewControllerProtocol> *tagsViewController = [[JSObjection defaultInjector] getObject:@protocol(DataViewControllerProtocol)];
//    tagsViewController.backgroundColor = [UIColor redColor];
//    [self.navigationController pushViewController:tagsViewController animated:YES];
}

- (void) mvvmAction: (UIButton*) sender {
    [[ComplexDealCenter sharedInstance] addDelegate:self];
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count;
    Method *method = class_copyMethodList([BTViewController class], &count);
    for (int i = 0; i < count; i++) {
        Method meth = method[i];
        SEL sel = method_getName(meth);
        const char *name = sel_getName(sel);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [array addObject:nameStr];
        
    }
    
    BTViewController * bb = [[BTViewController alloc] init];
    [bb test];

    
    
    
//    if (_mgr == nil) {
//        _mgr = [CLLocationManager new];
//    }
//    
//    [_mgr startUpdatingLocation];
//    
//    
////    DataViewControllerMVVM* mvvmVC = [[DataViewControllerMVVM alloc] init];
//    [self.navigationController pushViewController:mvvmVC animated:YES];
    
    
    
    
    
    /*UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    PaymentView *paymentView = [[PaymentView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 130, SCREEN_HEIGHT/2 - 80, 260, 160)];
    MongoliaView *backView = [[MongoliaView alloc] initWithAlpha:0.5];
    __weak typeof(backView) weakBackView = backView;
    __weak typeof(paymentView) weakPaymentView = paymentView;

    LazyWeakSelf;
    paymentView.payMentSelectBlock = ^(PaymentType type) {
        if (type == PaymentTypeAliPay) {
            [weakSelf callAliPay];
        } else if (type == PaymentTypeWeChat) {
            [weakSelf callWeChatPay];
        }
        [weakBackView removeFromSuperview];
        [weakPaymentView removeFromSuperview];
    };
    
    [keyWindow addSubview:backView];
    [keyWindow addSubview:paymentView];*/
}

- (void)callAliPay {
    NSLog(@"菊花转起来了");
    NSMutableDictionary *payParam = [NSMutableDictionary dictionary];
    
    NSString *notifyUrl = @"/alipay/notify_url.jsp";
    NSString *productName = @"好房通AV眼镜";
    
    [payParam setObject:productName forKey:kAliPayProductName];
    [payParam setObject:@"0.01" forKey:kAliPayPayAmount];
    [payParam setObject:notifyUrl forKey:kAliPayNotifyURL];
    [payParam setObject:productName forKey:kAliPayBody];
    id<PayCenterInterfaceProtocol, PayCenterParamsProtocol> payCenter = [PayCenter sharedPayCenter];
    [payCenter callAliPay:payParam Generator:[[PayParamsGenerator alloc] initWithObserver:payCenter]];
}

- (void)callWeChatPay {
    NSLog(@"菊花转起来了");
    NSMutableDictionary *payParam = [NSMutableDictionary dictionary];
    [payParam setObject:[NSString stringWithFormat:@"%.2f", 0.01 * 100] forKey:kWeChatPayPayAmount];
    
    id<PayCenterInterfaceProtocol, PayCenterParamsProtocol> payCenter = [PayCenter sharedPayCenter];
    [payCenter callWeChatPay:payParam Generator:[[PayParamsGenerator alloc] initWithObserver:payCenter]];
    
}

#pragma mark - PayCenterProtocol 支付结果处理
- (void)paramRequstFinish {
    NSLog(@"菊花隐藏了");
}

- (void)aliPaySuccess {
    NSLog(@"支付宝支付成功");
}

- (void)aliPayFaile:(NSString *)reason {
    NSLog(@"%@", [NSString stringWithFormat:@"支付宝支付失败 %@", reason]);
}

- (void)weChatPaySuccess {
    NSLog(@"微信支付成功");
}

- (void)weChatPayFaile:(NSString *)reason {
    NSLog(@"%@", [NSString stringWithFormat:@"微信支付失败 %@", reason]);
}

///**微信支付结果没有回调 根据outTradeNumber还原现场*/
//- (void)restoreWeChatPay:(NSString *)outTradeNumber {
//    
//}
#pragma mark - end

@end
