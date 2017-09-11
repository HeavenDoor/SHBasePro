/*******************************************************************************
 # File        : NetworkReachabilityManager.h
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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HFTNetworkStatus) {
	HFTNetworkStatusUnknown          = -1,
	HFTNetworkStatusNotReachable     = 0,
	HFTNetworkStatusReachableViaWWAN = 1,
	HFTNetworkStatusReachableViaWiFi = 2,
};

typedef void(^NetWorkReachabilityHandler)(HFTNetworkStatus status);

@interface NetworkReachabilityManager : NSObject

+ (void)listenNetWorkingStatus:(NetWorkReachabilityHandler)handler;

+ (HFTNetworkStatus)netWorkStatus;

@end
