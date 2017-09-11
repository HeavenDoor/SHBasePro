/*******************************************************************************
 # File        : NetworkReachabilityManager.m
 # Project     : Erp4iOS
 # Author      : shenghai
 # Created     : 2017/5/27
 # Corporation : 成都好房通科技股份有限公司
 # Description : 网络状态监控器
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "NetworkReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"

static NetworkReachabilityManager *networkReachabilityManager = nil;
static AFNetworkReachabilityManager *manager = nil;

@interface NetworkReachabilityManager ()

@property (nonatomic, assign) HFTNetworkStatus netWorkStatus;

@end

@implementation NetworkReachabilityManager

+ (instancetype)manager {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		networkReachabilityManager = [[NetworkReachabilityManager alloc] init];
	});
	return networkReachabilityManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if (networkReachabilityManager == nil) {
			networkReachabilityManager = [super allocWithZone:zone];
			manager = [AFNetworkReachabilityManager manager];
		}
	});
	return networkReachabilityManager;
}

+ (void)listenNetWorkingStatus:(NetWorkReachabilityHandler)handler {
	if (manager == nil) {
		[NetworkReachabilityManager manager];
	}
	//获取网络状态
	__block HFTNetworkStatus newStatus;
	[manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ((int)newStatus != status) {
            newStatus = (int)status;
            [[NetworkReachabilityManager manager] setValue:@(newStatus) forKey:@"netWorkStatus"];
            if (handler) {
                handler(newStatus);
            }
        }
		switch (status) {
			case AFNetworkReachabilityStatusUnknown:
				NSLog(@"未知网络");
				break;
			case AFNetworkReachabilityStatusNotReachable:
				NSLog(@"没有联网");
				break;
			case AFNetworkReachabilityStatusReachableViaWWAN:
				NSLog(@"蜂窝数据");
				break;
			case AFNetworkReachabilityStatusReachableViaWiFi:
				NSLog(@"无线网");
				break;
			default:
				break;
		}
	}];
	//开启网络监听
	[manager startMonitoring];
}

+ (HFTNetworkStatus)netWorkStatus {
	return (int)[[NetworkReachabilityManager manager] valueForKey:@"netWorkStatus"];
}

@end
